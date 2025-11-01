# syntax=docker/dockerfile:1

# Use a small and secure Python base image
FROM python:3.8-slim-buster

# Set working directory inside the container
WORKDIR /app

# Copy only requirements first (for better caching)
COPY requirements.txt .

# Install dependencies efficiently
# - Upgrade pip
# - No pip cache to keep image small
# - Add pip check to verify dependency compatibility
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip check

# Copy the application source code
COPY . .

# Expose port 5000 (Flask default)
EXPOSE 5000

# Use environment variable to make Flask production-ready
ENV FLASK_ENV=production

# Command to run the Flask app
CMD ["python3", "app.py"]

