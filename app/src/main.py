from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator







app = FastAPI(
    title="Boarding Week 2 Microservice",
    version="1.0.0"
)


@app.get("/")
def root():
    return {
        "application": "boarding-week2",
        "status": "running"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy"
    }


@app.get("/api/products")
def products():
    return {
        "products": [
            {
                "id": 1,
                "name": "Laptop",
                "price": 65000
            },
            {
                "id": 2,
                "name": "Keyboard",
                "price": 2500
            },
            {
                "id": 3,
                "name": "Mouse",
                "price": 1200
            }
        ]
    }


Instrumentator().instrument(app).expose(app)
