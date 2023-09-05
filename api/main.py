from typing import Union
from fastapi import FastAPI

app = FastAPI()

@app.get("/main")
def read_root():
    return {"Hello": "World"}

@app.get("/aboutme")
def read_item():
    return {"Hello": "About me"}

