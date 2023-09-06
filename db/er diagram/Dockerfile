# Use the official MySQL image as the base image
FROM mysql:5.7

# Environment variables for MySQL configuration
ENV MYSQL_ROOT_PASSWORD=root_password
ENV MYSQL_DATABASE=mydatabase
ENV MYSQL_USER=myuser
ENV MYSQL_PASSWORD=mypassword

# Copy SQL schema script to /docker-entrypoint-initdb.d/
COPY revisiontool.sql /docker-entrypoint-initdb.d/

# Expose the default MySQL port
EXPOSE 3306
