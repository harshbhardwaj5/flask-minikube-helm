FROM python:3.11-slim

# Set non-root user
RUN adduser --disabled-password --gecos '' flaskuser

# Add runtime dependencies for security
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl-dev ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY app.py ./

# Upgrade pip & install flask safely
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir flask && \
    chown -R flaskuser /app

USER flaskuser

EXPOSE 5000

CMD ["python", "app.py"]
