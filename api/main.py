from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"Hello": "Alive"}

@app.get("/main")
async def read_root():
    return {"Hello": "World"}

@app.get("/aboutme")
async def read_item():
    return {"Hello": "About me"}

