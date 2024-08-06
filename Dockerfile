FROM maven:3.9-amazoncorretto-17-al2023 as mvn-build

# ARG GITHUB_ACTOR
ARG GITHUB_TOKEN

# RUN mkdir -p /root/.m2
# RUN echo "<settings><servers><server><id>github</id><username>$GITHUB_ACTOR</username><password>$GITHUB_TOKEN</password></server></servers></settings>" > /root/.m2/settings.xml
RUN --mount=type=secret,id=GITHUB_TOKEN export GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN) 

RUN mkdir -p /build
WORKDIR /build
COPY pom.xml /build

RUN mvn clean install
COPY src /build/src
RUN mvn clean package -DskipTests && ls -lath /build/target

# Run our service using Amazon Corretto. Corretto gives free Java security updates
# FROM java:21

# COPY --from=mvn-build /build/target/capital-service-0.0.1-SNAPSHOT.jar /app/capital-service.jar
# CMD ["java", "-jar", "capital-service.jar"]
