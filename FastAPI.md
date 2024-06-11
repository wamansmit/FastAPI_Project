Write a "Hello World" application using FastAPI, dockerize it, and push the image to Docker Hub:

### Step 1: Write the FastAPI Source Code
Create a file named `main.py` and add the following FastAPI code:

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Hello World"}
```

### Step 2: Create a `requirements.txt` File
List all the necessary packages for your application. For our "Hello World" app, it will just be FastAPI and Uvicorn:

```
fastapi
uvicorn[standard]
```

### Step 3: Dockerize the FastAPI Application
Create a `Dockerfile` in the root directory of your project with the following content:

```Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application's code
COPY . .

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
```

### Step 4: Build the Docker Image
Run the following command in your terminal to build the Docker image:

```bash
docker build -t my-fastapi-app .
```

### Step 5: Push the Image to Docker Hub
First, tag your image with your Docker Hub username and repository:

```bash
docker tag my-fastapi-app:latest username/my-fastapi-app:latest
```

Then, push the image to Docker Hub:

```bash
docker push username/my-fastapi-app:latest
```

Make sure to replace `username` with your actual Docker Hub username.

**Note:** Before pushing the image, ensure you are logged in to Docker Hub using the `docker login` command.

And that's it! You've now written a FastAPI "Hello World" application, dockerized it, and pushed it to Docker Hub. You can now pull and run your containerized application from anywhere using Docker.

Source: Conversation with Copilot, 11/06/2024
(1) Install FastAPI Python and Create Hello World App on Windows. https://www.youtube.com/watch?v=3JJgJsscdgQ.
(2) Hello World with Python's FastAPI Framework. https://www.youtube.com/watch?v=bl-kVpPs8oI.
(3) Hello World avec FastAPI - Tuto 3 FastAPI. https://www.youtube.com/watch?v=MkGpuvn5dno.
(4) First Steps - FastAPI - tiangolo. https://fastapi.tiangolo.com/tutorial/first-steps/.
(5) GitHub - tiangolo/fastapi: FastAPI framework, high performance, easy to .... https://github.com/tiangolo/fastapi.
(6) Write Your First Backend API with FastAPI (Hello World). https://www.slingacademy.com/article/write-your-first-backend-api-with-fastapi-hello-world/.
(7) Building a Stylish Hello World with Svelte and FastAPI: A Step-by-Step .... https://blog.devgenius.io/building-a-stylish-hello-world-with-svelte-and-fastapi-a-step-by-step-guide-bad5557d3794.
(8) FastAPI - Hello World - Online Tutorials Library. https://www.tutorialspoint.com/fastapi/fastapi_hello_world.htm.
(9) A Step-by-Step guide to Build and Push Your Own Docker Images to .... https://medium.com/@komalminhas.96/a-step-by-step-guide-to-build-and-push-your-own-docker-images-to-dockerhub-709963d4a8bc.
(10) docker push | Docker Docs. https://docs.docker.com/reference/cli/docker/image/push/.
(11) Push a Docker image into the Docker Hub - Teco Tutorials. https://blog.tericcabrel.com/push-docker-image-docker-hub/.
(12) How to create a docker image and push it to Docker Hub. https://www.techrepublic.com/article/how-to-create-a-docker-image-and-push-it-to-docker-hub/.
(13) How to build a Docker image and upload it to Docker Hub. https://www.techrepublic.com/article/how-to-build-a-docker-image-and-upload-it-to-docker-hub/.
(14) FastAPI in Containers - Docker - FastAPI - tiangolo. https://fastapi.tiangolo.com/deployment/docker/.
(15) Dockerizing FastAPI Application: A Comprehensive Guide. https://medium.com/@navinsharma9376319931/dockerizing-fastapi-application-a-comprehensive-guide-4c065e5600f9.
(16) How to Dockerize and Deploy a Fast API Application to Kubernetes .... https://dev.to/bravinsimiyu/how-to-dockerize-and-deploy-a-fast-api-application-to-kubernetes-cluster-35a9.
(17) Using FastAPI inside Docker containers - LogRocket Blog. https://blog.logrocket.com/using-fastapi-inside-docker-containers/.
(18) undefined. https://bit.ly/3d3Hhzt.
(19) undefined. https://fastapi.tiangolo.com.
(20) undefined. http://127.0.0.1:8000.
(21) undefined. http://127.0.0.1:8000/docs.
(22) undefined. https://github.com/komal-max/Build-and-Push-Your-Own-Docker-Images.
(23) undefined. https://hub.docker.com/_/nginx.