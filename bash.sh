#!/bin/bash

# Create the project directory
mkdir hello-fastapi

# Create the app directory
mkdir hello-fastapi/app

# Create the files
touch hello-fastapi/app/main.py
touch hello-fastapi/app/requirements.txt
touch hello-fastapi/Dockerfile
touch hello-fastapi/README.md
touch hello-fastapi/.gitignore

# Add content to the files
echo "from fastapi import FastAPI" >> hello-fastapi/app/main.py
echo "app = FastAPI()" >> hello-fastapi/app/main.py
echo "" >> hello-fastapi/app/main.py
echo "@app.get(\"/\")" >> hello-fastapi/app/main.py
echo "def read_root():" >> hello-fastapi/app/main.py
echo "    return {\"message\": \"Hello, World!\"}" >> hello-fastapi/app/main.py

echo "fastapi" >> hello-fastapi/app/requirements.txt
echo "uvicorn" >> hello-fastapi/app/requirements.txt

echo "# Use an official Python image as a base" >> hello-fastapi/Dockerfile
echo "FROM python:3.9-slim" >> hello-fastapi/Dockerfile
echo "" >> hello-fastapi/Dockerfile
echo "# Set the working directory to /app" >> hello-fastapi/Dockerfile
echo "WORKDIR /app" >> hello-fastapi/Dockerfile
echo "" >> hello-fastapi/Dockerfile
echo "# Copy the requirements file" >> hello-fastapi/Dockerfile
echo "COPY app/requirements.txt ." >> hello-fastapi/Dockerfile
echo "" >> hello-fastapi/Dockerfile
echo "# Install the dependencies" >> hello-fastapi/Dockerfile
echo "RUN pip install -r requirements.txt" >> hello-fastapi/Dockerfile
echo "" >> hello-fastapi/Dockerfile
echo "# Copy the application code" >> hello-fastapi/Dockerfile
echo "COPY app/ ." >> hello-fastapi/Dockerfile
echo "" >> hello-fastapi/Dockerfile
echo "# Expose the port the application will use" >> hello-fastapi/Dockerfile
echo "EXPOSE 8000" >> hello-fastapi/Dockerfile
echo "" >> hello-fastapi/Dockerfile
echo "# Run the command to start the development server when the container launches" >> hello-fastapi/Dockerfile
echo "CMD [\"uvicorn\", \"main:app\", \"--host\", \"0.0.0.0\", \"--port\", \"8000\"]" >> hello-fastapi/Dockerfile

echo "Hello, World! with FastAPI and Docker" >> hello-fastapi/README.md

echo "*.pyc" >> hello-fastapi/.gitignore
echo "__pycache__/" >> hello-fastapi/.gitignore
