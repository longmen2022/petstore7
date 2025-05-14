# Copyright 2010-2025 the original author or authors.
# Licensed under the Apache License, Version 2.0 (https://www.apache.org/licenses/LICENSE-2.0)

# Use OpenJDK 17 base image
FROM openjdk:17.0.2

# Set working directory
WORKDIR /usr/src/myapp

# Copy only essential files first (to leverage Docker layer caching)
COPY .mvn /usr/src/myapp/.mvn
COPY mvnw /usr/src/myapp/mvnw
COPY pom.xml /usr/src/myapp/pom.xml

# Ensure Maven Wrapper has execution permissions
RUN chmod +x mvnw

# Download dependencies separately to speed up build times
RUN ./mvnw dependency:resolve

# Copy the rest of the application files
COPY src /usr/src/myapp/src

# Build the project
RUN ./mvnw clean package -DskipTests=true

# Expose application port
EXPOSE 8080

# Start the application
CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]
