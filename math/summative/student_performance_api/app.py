from fastapi import FastAPI
from pydantic import BaseModel
import joblib
from fastapi.middleware.cors import CORSMiddleware

# Load the trained model
model = joblib.load("student_performance_model.joblib")


# Define the InputData class
class InputData(BaseModel):
    hours_studied: float
    previous_scores: float
    extracurricular_activities: str
    sleep_hours: float
    sample_question_papers_practiced: int


# Initialize FastAPI
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def read_root():
    return {"message": "Hello World"}


# Function to convert input data to model format
def convertRequestToModelValue(data):
    extracurricular_activities = 1 if data["extracurricular_activities"] == "Yes" else 0
    return [
        data["hours_studied"],
        data["previous_scores"],
        extracurricular_activities,
        data["sleep_hours"],
        data["sample_question_papers_practiced"],
    ]


@app.post("/predict")
def predict(data: InputData):
    # Convert input data to the required format for the model
    input_data = [convertRequestToModelValue(data.dict())]

    # Make prediction
    prediction = model.predict(input_data)
    print(prediction[0])

    # Return the prediction as a response
    return {"prediction": round(prediction[0], 0)}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)
