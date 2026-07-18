#!/usr/bin/env bash
# Simple health check script to verify if Nginx is responding on HTTP port 80
set -e

echo "Checking application health status..."

URL="http://localhost/health"
MAX_RETRIES=5
SLEEP_TIME=5

for i in $(seq 1 $MAX_RETRIES); do
    echo "Attempt $i of $MAX_RETRIES..."
    
    if curl -s -f "$URL" > /dev/null; then
        echo "Health check passed! The application is running smoothly."
        exit 0
    fi
    
    echo "Application not ready yet. Waiting $SLEEP_TIME seconds..."
    sleep $SLEEP_TIME
done

echo "Error: Health check failed after $MAX_RETRIES attempts."
echo "Showing container status and recent logs for debugging:"
docker compose ps || true
docker compose logs --tail=15 nginx || true
exit 1
