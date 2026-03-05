from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.database import Base, engine
from app import models  # noqa: F401 - registers all models

app = FastAPI(
    title="Hospital Management System API",
    description="Backend API for Hospital & Clinic Management System",
    version="1.0.0"
)

# Create all tables on startup
Base.metadata.create_all(bind=engine)

# CORS settings — allows React frontend to talk to FastAPI
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {
        "message": "Hospital Management System API",
        "status": "running",
        "docs": "/docs"
    }

@app.get("/health")
def health_check():
    return {"status": "healthy"}