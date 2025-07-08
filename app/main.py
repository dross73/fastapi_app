from fastapi import FastAPI

# Create a new FastAPI instance
app = FastAPI()


# Define a basic route at the root of the API
@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI"}
