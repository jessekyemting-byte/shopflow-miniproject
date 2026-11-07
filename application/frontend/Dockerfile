# Use the actively maintained official Nginx unprivileged image instead of the deprecated nginxinc version
FROM nginx/nginx-unprivileged:mainline-alpine

# Temporarily escalate to root (required because the base image defaults to UID 101)
USER root

# Upgrade all OS packages to patch the CRITICAL vulnerabilities (CVE-2026-111497, CVE-2026-31789)
RUN apk update && apk upgrade --no-cache

# Drop privileges back to the non-root 'nginx' user (UID 101) to maintain the security boundary
USER 101

# Copy your custom Nginx configuration (proxies /api/ and handles /healthz)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy the static frontend HTML/JS/CSS files into the container's default serving directory
COPY . /usr/share/nginx/html/

# Expose the unprivileged port
EXPOSE 8080
