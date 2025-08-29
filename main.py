from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import httpx

app = FastAPI(title="StatusBoard")

origins = [
    "https://boyanantonov02.github.io",
    "http://localhost:8000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

sites = ["https://www.google.com", "https://www.facebook.com", "https://www.youtube.com", "https://www.test-Offline-test.com"]

@app.get("/")
def read_root():
    return {"message": "Welcome to StatusBoard!"}

@app.get("/status")
async def check_sites():
    status_results = {}
    async with httpx.AsyncClient() as client:
        for site in sites:
            try:
                response = await client.get(site, timeout=5)
                status_results[site] = "Online" if response.status_code == 200 else f"Error {response.status_code}"
            except Exception as e:
                status_results[site] = f"Offline ({e})"
    return status_results
