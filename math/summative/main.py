from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import numpy as np

app = FastAPI()

origins = [
    "http://localhost:49882",
    "http://localhost:8000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class TVInput(BaseModel):
    TV: int

# Example model coefficients (replace with your trained model coefficients)
model_intercept = 2.5
model_coef = 0.1

@app.post("/predict")
def predict_sales(tv: TVInput):
    # Your prediction logic here
    tv_value = tv.TV
    predicted_sales = model_intercept + model_coef * tv_value
    return {"predicted_sales": predicted_sales}
