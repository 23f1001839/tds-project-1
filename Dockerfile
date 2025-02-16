FROM python:3.12-slim-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download and install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Install Python packages
RUN pip install fastapi uvicorn httpx python-dotenv requests python-dateutil scipy numpy pandas

# Set up the application directory
WORKDIR /app

# Copy all application files
COPY . /app

# Expose the port for FastAPI
EXPOSE 8000

# Command to run FastAPI with Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
