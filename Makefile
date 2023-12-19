# docker images arm
#-------------------------------------------------------------------------
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
#-------------------------------------------------------------------------

# docker images x86
#-------------------------------------------------------------------------
api imagex86:
	docker buildx build --platform linux/amd64 -t spoved.api.net.corex86 ./api

api tag imagex86:
	docker tag spoved-api.net.corex86:latest krzysztofla/ziqq-docker-repo:spoved-api-net-core-x86

api push imagex86:
	docker push krzysztofla/ziqq-docker-repo:spoved-api-net-corex86

app image:
	docker build -t spoved.app.react ./app

app tag image:
	docker tag spoved.app.react:latest krzysztofla/ziqq-docker-repo:spoved-app-react

app push image:
	docker push krzysztofla/ziqq-docker-repo:spoved-app-react
#-------------------------------------------------------------------------

