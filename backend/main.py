from typing import Union

from fastapi import FastAPI
from pydantic import BaseModel
from weather_api import realtime

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float
    is_offer: Union[bool, None] = None


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/add/{item_id_1}/{item_id_2}")
def read_item(item_id_1: int, item_id_2: int):
    return {"sum": item_id_1 + item_id_2}

@app.put("/items/{item_id}")
def update_item(item_id: int, item: Item):
    return {"item_name": item.name, "item_id": item_id}

@app.get("/realtime/{lat}/{lon}")
def read_item(lat: float, lon: float):
    return realtime(lat, lon)

