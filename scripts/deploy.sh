#!/usr/bin/env bash
# Deployment script ran on AWS EC2 by GitHub Actions
set -e

echo "==========================================="
echo "Starting deployment on AWS EC2"
echo "==========================================="

# Check and install Docker if not present
if ! command -v docker &>/dev/null; then
    echo "Docker not found. Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io docker-compose-plugin
    sudo usermod -aG docker ubuntu
fi

# Navigate to project root
cd "$(dirname "$0")/.."

# Pull the latest Docker images from GitHub Container Registry
echo "Pulling latest container images..."
docker compose pull

# Start or recreate containers in the background
echo "Starting application containers..."
docker compose up -d --remove-orphans

# Clean up old unused images to save disk space on EC2
echo "Cleaning up old Docker images..."
docker image prune -f

echo "==========================================="
echo "Deployment finished successfully!"
echo "==========================================="
docker compose ps
