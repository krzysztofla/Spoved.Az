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

## How to run localhost

1. Install Docker
2. Install Kubernetes
3. Install HELM
4. Install Minikube
5. Install Qemu
6. Install socket_vmnet

## How to run on Mnikube with Qemu and host mapping

1. AKS Ingress on localhost Mac

To make it work we need to add ip to host mapping on etc/hosts file
When we are working on minikube we have to open tunnel on separate terminal that will be working in background

2. AKS Node Port on localhost Mac

Step 1: Install Qemu

Install the Qemu emulator using the following command.

brew install qemu
Step 2: Setup Qemu socket_vvmnet

For minikube service URLs to work, you need to start the socket_vmnet service

brew install socket_vmnet
brew tap homebrew/services
```HOMEBREW=$(which brew) && sudo ${HOMEBREW} services start socket_vmnet```
Step 3: Install minikube

brew install minikube
Step 4: Start Minikube with the Qemu driver and socket_vmnet

minikube start --driver qemu --network socket_vmnet

To validate the networking, get the service URL using the following command. It will give you the node IP with NodePort in URL format.

minikube service <service name with node port> --url

If you don’t have socket_vmnet running with Qemu and if you try to access Minikube service URLs, you will get the error.

How to edit Hosts file on Mac
To edit Hosts file Mac features is not a difficult although completely non-obvious process. To open Hosts file on Mac, which is hidden, you need to use Terminal:

Launch Terminal
Type sudo nano /etc/hosts and press Return
Enter your admin password
![image](docs/minikube/sudo_nano_hosts.png)