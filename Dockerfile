# Use the latest stable Python 3.13 base image
FROM python:3.13-slim

# Set environment variables to avoid .pyc file and enable unbuffered output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1 

# Create a non-root user with no home directory and no shell access
RUN adduser --disabled-password --no-create-home --gecos "" appuser

# Set the working directory in the container
WORKDIR /app

# Copy dependency file and install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code and fix ownership (optional but safer)
COPY app/ .
RUN chown -R appuser:appuser /app

# Switch to the non-root user
USER appuser

# Run the app using Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
