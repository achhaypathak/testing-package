FROM maven:3.9-amazoncorretto-17-al2023 as mvn-build
COPY pom.xml /build
RUN mvn -e -B dependency:resolve dependency:resolve-plugins
COPY src /build/src
RUN mvn clean package -DskipTests && ls -lath /build/target

# Run our service using Amazon Corretto. Corretto gives free Java security updates
# FROM java:21

# COPY --from=mvn-build /build/target/capital-service-0.0.1-SNAPSHOT.jar /app/capital-service.jar
# CMD ["java", "-jar", "capital-service.jar"]
