from typing import Optional

from fastapi import FastAPI

from jwtfunctions import *

app = FastAPI()

@app.get("/")
def read_root():
    return { "Health": "OK" }


@app.get("/token/{user}")
def create_token(user: str, q: Optional[str] = None):
    token = encode(user)
    return { "token": token }