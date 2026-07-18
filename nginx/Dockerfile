# Use lightweight Nginx alpine image
FROM nginx:alpine

# Install curl for health check
RUN apk add --no-cache curl

# Remove default Nginx configuration
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy custom Nginx config and HTML files
COPY nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

# Expose HTTP port 80
EXPOSE 80

# Health check to ensure container is responding
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD curl -fs http://localhost/health || exit 1

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
