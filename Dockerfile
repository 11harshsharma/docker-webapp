# Use a lightweight Python image as base
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application files into the container
COPY app.py /app/app.py

# Install Flask
RUN pip install flask

# Expose the port for the Flask application
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]

