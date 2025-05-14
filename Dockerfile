# Copyright 2010-2025 the original author or authors.
# Licensed under the Apache License, Version 2.0 (https://www.apache.org/licenses/LICENSE-2.0)

FROM openjdk:17.0.2

# Set working directory
WORKDIR /usr/src/myapp

# Copy application files
COPY . .

# Ensure `mvnw` is executable to avoid permission errors
RUN chmod +x mvnw

# Build the project
RUN ./mvnw clean package

# Start the application
CMD ["./mvnw", "cargo:run", "-P", "tomcat90"]