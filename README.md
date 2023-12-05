# Spoved.Az

My personal side projec where I'm sharping my Cloud Engineering / DevOps skills.
[This is work in progress]
![image](https://github.com/krzysztofla/Spoved.Az/blob/development/docs/personal/2023-09-22%2016.16.50.gif)
## Tech Stack

- [x] React starter app based on YT tutorial
- [x] .Net Core Minimal API
- [x] Docker
- [x] Kubernetes
- [x] HELM
- [x] Github Actions
- [x] Azure [soon]
- [x] Rancher k3s

## How to run localhost
By using brew or chockolate please install below prerequsites:
1. Install Docker
2. Install Kubernetes
3. Install HELM
4. Install k3d
5. Install linkerd

## Create local kubernetes cluster using k3d and mount pods with apps:

```bash
k3d cluster create <name-of-the-cluster>
```

Now when we have cluster ready let's install demo application by running helm command


```bash
helm install <path-to-helm-directory> 
```

In this project all helm intallation configuration are in **helm-chart** folder.

In the next step we have to make sure that all ports configured for applications are accesible trough our ngnix gateway by running command below.
```bash
k3d cluster edit spoved-k3s-cluster --port-add 30008-30017:30008:30017@loadbalancer                                                                          
```
Execution of this command may take few seconds. After successful reconfiguration and cluster restart demo app should be accesible from http://localhost:30017

---

## Service Mesh creation

- To create service mesh in cluster I used Linkerd service mesh tools. In the first step install Linkerd (you can use installation manager like brew).

```bash
brew install linkerd
```

- Next step is to check if cluster has all prerequisites ready for creating service mesh. For this you have to run:

```bash

linkerd check --pre

## it shoud show similar output if everything is okay

kubernetes-api
--------------
√ can initialize the client
√ can query the Kubernetes API

kubernetes-version
------------------
√ is running the minimum Kubernetes API version

pre-kubernetes-setup
--------------------
√ control plane namespace does not already exist
√ can create non-namespaced resources
√ can create ServiceAccounts
√ can create Services
√ can create Deployments
√ can create CronJobs
√ can create ConfigMaps
√ can create Secrets
√ can read Secrets
√ can read extension-apiserver-authentication configmap
√ no clock skew detected

linkerd-version
---------------
√ can determine the latest version
√ cli is up-to-date

Status check results are √
```

- Now when everything is okay linkerd can be installed by simply running:

```bash
linkerd install --crds | kubectl apply -f -

## example output
customresourcedefinition.apiextensions.k8s.io/authorizationpolicies.policy.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/httproutes.policy.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/meshtlsauthentications.policy.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/networkauthentications.policy.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/serverauthorizations.policy.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/servers.policy.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/serviceprofiles.linkerd.io created
customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io created
##

## now apply linkerd 

linkerd install | kubectl apply -f -
```



- To check if everything is going according to the plan lets run check cmd.
This will check if all controll planes and other stuff was installed correctly.

```bash
linkerd check
```

---
## Installation of dashboards 
- To take controll over metrics let's install visualization tools dedicated for linkerd.

```bash
linkerd viz install | kubectl apply -f -  
```
- Once again check if installation is going according to the plan
```bash
linkerd check

...

linkerd-viz
-----------
√ linkerd-viz Namespace exists
√ can initialize the client
√ linkerd-viz ClusterRoles exist
√ linkerd-viz ClusterRoleBindings exist
√ tap API server has valid cert
√ tap API server cert is valid for at least 60 days
√ tap API service is running
√ linkerd-viz pods are injected
√ viz extension pods are running
√ viz extension proxies are healthy
√ viz extension proxies are up-to-date
√ viz extension proxies and cli versions match
√ prometheus is installed and configured correctly
√ viz extension self-check
```
- Now dashboard is ready to go
```bash
linkerd viz dashboard &
```
![image](https://github.com/krzysztofla/Spoved.Az/blob/development/docs/service_mesh/linkerd_dashboard.png)

---
## Meshing our apps

Now to make informations about our apps visible in dashboard we have to mesh it. We can do this on a live application without downtime, thanks to Kubernetes’s rolling deploys. 

At the first place let's make sure that deployments are on place:
```bash
kubectl get deploy 

...
NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
spoved-frontend-deploy   1/1     1            1           5d20h
spoved-backend-deploy    1/1     1            1           5d20h
```

If deployments are up and ready we can inject linkerd proxy as side cars like follow:
```bash
kubectl get deploy -o yaml | linkerd inject - | kubectl apply -f - 

...
deployment "spoved-frontend-deploy" injected
deployment "spoved-backend-deploy" injected

```
Great! Now pods are meshed with proxy and we can see all trafic going to and from them.

![image](https://github.com/krzysztofla/Spoved.Az/blob/development/docs/service_mesh/linkerd_meshed_pods.png)

---
## Installing Jaeger, Prometheus and Grafana

To gather all nececary informations about telemetry we have to install Jaeger, Prometheus and Grafana

```bash
linkerd jaeger install | kubectl apply --filename -    
```

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana -n grafana --create-namespace grafana/grafana \
  -f https://raw.githubusercontent.com/linkerd/linkerd2/main/grafana/values.yaml
```

This is fed the default values.yaml file, which configures as a default datasource Linkerd Viz’ Prometheus instance, sets up a reverse proxy (more on that later), and pre-loads all the Linkerd Grafana dashboards.

**Note!**

The access to Linkerd Viz’ Prometheus instance is restricted through the prometheus-admin AuthorizationPolicy, granting access only to the metrics-api ServiceAccount. In order to also grant access to Grafana, you need to add an AuthorizationPolicy pointing to its ServiceAccount. You can apply authzpolicy-grafana.yaml which grants permission for the grafana ServiceAccount.
```bash
kubectl apply -f ./service_mesh/grafana/auth_policy_grafana.yaml    
```

**Hook Grafana with Linkerd Viz Dashboard**
In the case of in-cluster Grafana instances (such as as the one from the Grafana Helm chart or the Grafana Operator mentioned above), make sure a reverse proxy is set up, as shown in the sample grafana/values.yaml file:
```
grafana.ini:
  server:
    root_url: '%(protocol)s://%(domain)s:/grafana/'
```
Then refer the location of your Grafana service in the Linkerd Viz values.yaml entry grafana.url. For example, if you installed the Grafana official Helm chart in the grafana namespace, you can install Linkerd Viz through the command line like so:
```
linkerd viz install --set grafana.url=grafana.grafana:3000 \
  | kubectl apply -f -
```

**Now I suggest to restart the cluster**

```bash
k3d cluster stop spoved-k3s-cluster
k3d cluster start spoved-k3s-cluster
```

Now we should be able to access the telemetry in real time like so:
![image](https://github.com/krzysztofla/Spoved.Az/blob/development/docs/personal/linkerd_grafana_st.gif)
![image](https://github.com/krzysztofla/Spoved.Az/blob/development/docs/personal/grafana.gif)