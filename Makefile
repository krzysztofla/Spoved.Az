# docker 
#--------------------------------------------
api image:
	docker build -t spoved.api.net.core ./api

api tag image:
	docker tag spoved-api.net.core:latest krzysztofla/ziqq-docker-repo:spoved-api-net-core

api push image:
	docker push krzysztofla/ziqq-docker-repo:spoved-api-net-core

app image:
	docker build -t spoved.app.react ./app

app tag image:
	docker tag spoved.app.react:latest krzysztofla/ziqq-docker-repo:spoved-app-react

app push image:
	docker push krzysztofla/ziqq-docker-repo:spoved-app-react
#--------------------------------------------

