# 1. [VULNERABILITY] Using 'latest' tag (Unpredictable builds)
FROM ubuntu:latest

# 2. [VULNERABILITY] Storing secrets in LABEL
LABEL maintainer="admin@vulnerable.com" \
      secret_password="monkey123"

# 3. [VULNERABILITY] Storing secrets in ENV variables
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
ENV DB_PASSWORD="production_db_password_123"

# 4. [VULNERABILITY] Installing 'sudo' and 'ssh' (Attack surface)
# 5. [VULNERABILITY] Not cleaning apt-cache (Image bloat)
RUN apt-get update && \
    apt-get install -y sudo curl python3 openssh-server vim

# 6. [VULNERABILITY] Using ADD instead of COPY (Risk of Zip slips/Remote URLs)
ADD . /app

WORKDIR /app

# 7. [VULNERABILITY] Creating a sensitive private key file inside the image
RUN echo "-----BEGIN RSA PRIVATE KEY-----" > /app/id_rsa_private.pem

# 8. [VULNERABILITY] Running as Root (No USER created)

# 9. [VULNERABILITY] No HEALTHCHECK instruction

# 10. Expose Port 8080 (Matches your Workflow!)
EXPOSE 8080

# 11. Start Python Web Server (So Nuclei has something to scan)
CMD ["python3", "-m", "http.server", "8080"]
