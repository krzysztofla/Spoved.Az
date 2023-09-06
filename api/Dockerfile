FROM ubuntu as build

RUN mkdir -p /opt/spoved-api

WORKDIR /opt/spoved-api

COPY . .

FROM python:3.11.5-slim as result

RUN mkdir -p /opt/spoved-api

COPY --from=build /opt/spoved-api /opt/spoved-api

RUN pip install -r /opt/spoved-api/requirements.txt

WORKDIR /opt/spoved-api
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]

EXPOSE 443/tcp 8080/tcp