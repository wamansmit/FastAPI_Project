# Use an official Python image as a base
FROM python:3.9-slim

# Copy files

WORKDIR /app


# Copy the requirements file
COPY hello-fastapi/* /app/


#COPY app/* /app/

# Install the dependencies
RUN pip install -r requirements.txt

# Expose the port the application will use
EXPOSE 9009

# Run the command to start the development server when the container launches
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "9009"]
