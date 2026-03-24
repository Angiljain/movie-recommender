FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements file first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose port (Hugging Face Spaces defaults to 7860 for Docker spacing)
EXPOSE 7860

# Command to run the application using Gunicorn (production server)
CMD ["gunicorn", "-b", "0.0.0.0:7860", "--timeout", "120", "--workers", "1", "--threads", "2", "app:app"]
