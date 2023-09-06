dependencies: 
	pip install -r requirements.txt
api_container:
	docker build -t spoved-api ./api
start_app:
	uvicorn src.main:app --reload 
lint:
	black ./


# docker run --name spoved-api spoved-api