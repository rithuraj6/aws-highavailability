from fastapi.testclient import TestClient
from src.main import app

client = TestClient(app)


def test_root():
    response = client.get("/")

    assert response.status_code == 200
    assert response.json()["application"] == "boarding-week2"
    assert response.json()["status"] == "running"


def test_health():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}


def test_products():
    response = client.get("/api/products")

    assert response.status_code == 200

    data = response.json()

    assert "products" in data
    assert len(data["products"]) == 3
    assert data["products"][0]["name"] == "Laptop"
