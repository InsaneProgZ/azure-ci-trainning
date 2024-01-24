# Stage 1: Dependency download
FROM gradle:jdk21-alpine AS dependencies

WORKDIR /app

COPY build.gradle.kts .
COPY settings.gradle.kts .

# Download dependencies
RUN gradle --refresh-dependencies

# Stage 2: Build the Project
FROM dependencies AS build

WORKDIR /app

# Copy the Gradle files and the source code
COPY --from=dependencies /app .

# Copy the rest of the source code
COPY src src

# Build the project
RUN gradle --no-daemon jar

# Stage 2: Build and run
FROM amazoncorretto:21-alpine-jdk

WORKDIR /app

COPY --from=build /app/build/libs/*.jar ./app.jar
# Expose the port that the application will run on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app"]
