import pandas as pd
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from typing import List
import joblib

# Define the FastAPI app
app = FastAPI(title="Multivariate Linear Regression API")

# Load the dataset
df = pd.read_csv('data.csv')  # Replace 'data.csv' with the path to your dataset

# Define the features and target
X = df.drop('target', axis=1)  # Replace 'target' with the name of your target column
y = df['target']  # Replace 'target' with the name of your target column

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train the linear regression model
model = LinearRegression()
model.fit(X_train, y_train)

# Save the trained model
joblib.dump(model, 'linear_regression_model.joblib')

# Define the input data model using Pydantic
class PredictionInput(BaseModel):
    features: List[float]

# Create the prediction endpoint
@app.post('/predict')
def predict(input_data: PredictionInput):
    try:
        # Load the trained model
        model = joblib.load('linear_regression_model.joblib')
        
        # Convert input data to a DataFrame
        data = pd.DataFrame([input_data.features])
        
        # Make a prediction
        prediction = model.predict(data)
        
        return {"prediction": prediction[0]}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

# Run the FastAPI application
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
