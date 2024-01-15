# docker images arm
#-------------------------------------------------------------------------
api image:
	docker build -t spoved.api.net.core ./api

api tag image:
	docker tag spoved.api.net.core:latest krzysztofla/ziqq-docker-repo:spoved-api-net-core

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
# .NET6 docker build stuck on dotnet restore #3338 when building on mac m1 arm
# https://github.com/dotnet/dotnet-docker/issues/3338
api imagex86:
	docker buildx build --platform linux/amd64 -t spoved.api.net.corex86 ./api

api tag imagex86:
	docker tag spoved.api.net.corex86:latest krzysztofla/ziqq-docker-repo:spoved-api-net-core-x86

api push imagex86:
	docker push krzysztofla/ziqq-docker-repo:spoved-api-net-corex86

app imagex86:
	docker build -t spoved.app.reactx86 ./app

app tag imagex86:
	docker tag spoved.app.reactx86:latest krzysztofla/ziqq-docker-repo:spoved-app-react-x86

app push imagex86:
	docker push krzysztofla/ziqq-docker-repo:spoved-app-react-x86
#-------------------------------------------------------------------------

