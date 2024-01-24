# Use the official Gradle image as a base image
FROM gradle:8.5.0-jdk21-alpine AS builder

# Copy the Gradle project files
COPY --chown=gradle:gradle . /home/gradle/src

# Set the working directory
WORKDIR /home/gradle/src

# Build the application
RUN gradle build --no-daemon

# Create a smaller image for runtime
FROM amazoncorretto:21-alpine-jdk

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /home/gradle/src/build/libs/*T.jar /app/app.jar

# Expose the port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]