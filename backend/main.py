from typing import Union
from typing import List, Dict

from fastapi import FastAPI
from pydantic import BaseModel
from weather_api import realtime
from weather_api import forecast
from qna import res
from qna import new_chat

app = FastAPI()

# class Item(BaseModel):
#     name: str
#     price: float
#     is_offer: Union[bool, None] = None


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/add/{item_id_1}/{item_id_2}")
def read_item(item_id_1: int, item_id_2: int):
    return {"sum": item_id_1 + item_id_2}

# @app.put("/items/{item_id}")
# def update_item(item_id: int, item: Item):
#     return {"item_name": item.name, "item_id": item_id}

@app.get("/realtime/{lat}/{lon}")
def real_item(lat: float, lon: float):
    return realtime(lat, lon)

@app.get("/forecast/{lat}/{lon}/{day}")
def forecast_api(lat:float, lon:float, day:int):
    return forecast(lat, lon, day)

@app.post("/query/")
def query_api(data_list: List[Dict[str, str]], message: str):
    result = res(message, data_list)
    return result

# async def process_data(data: List[Dict]):
#     # Do something with the data, such as save it to a database or perform some analysis
#     return {"message": "Data processed successfully!"}

# returns initial message array
# class InputData(BaseModel):
#     name: str
#     age: int



@app.get("/new_query/{crop_name}")
def new_query_api(crop_name: str) -> List[Dict]:
    # print(query)
    return new_chat(crop_name)