# 1. Base Image, use the official slim version of Python 3.10 on Alpine/Debian Linux
FROM python:3.10-slim

# 2. Prevent Python from writing .pyc files and enable unbuffered output for real-time logging
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PORT=5000

# 3. Set the internal working directory for all subsequent instructions
WORKDIR /usr/src/app

# 4. Copy requirements.txt from host to the container image
COPY requirements.txt ./

# 5. Install dependencies without caching to keep the image lightweight
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy remaining application files into the working directory
COPY app.py ./
COPY templates/ ./templates/
COPY /static/docker.png ./static/

# 7.  Declare that the container listens on port 5000 at runtime
EXPOSE 5000

# 8. Entrypoint specify the default command to execute when the container starts
ENTRYPOINT ["python", "app.py"]