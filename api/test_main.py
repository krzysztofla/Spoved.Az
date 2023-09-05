from fastapi import FastAPI
from fastapi.testclient import TestClient
from .main import app

client = TestClient(app)


def test_read_main():
    response = client.get("/main")
    assert response.status_code == 200
    assert response.json() == {"Hello": "World"}

def test_read_aboutme():
    response = client.get("/aboutme")
    assert response.status_code == 200
    assert response.json() == {"Hello": "About me"}