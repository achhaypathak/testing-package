FROM achhaypathak/maven:latest

# ARG GITHUB_ACTOR
# ARG GITHUB_TOKEN

# ENV GITHUB_ACTOR=${GITHUB_ACTOR}
# ENV GITHUB_TOKEN=${GITHUB_TOKEN}

# # RUN mkdir -p /root/.m2
# # RUN echo "<settings><servers><server><id>github</id><username>$GITHUB_ACTOR</username><password>$GITHUB_TOKEN</password></server></servers></settings>" > /root/.m2/settings.xml
# RUN --mount=type=secret,id=GITHUB_TOKEN export GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN) 

# ENV GITHUB_TOKEN=$GITHUB_TOKEN

# RUN echo $GITHUB_TOKEN && env

COPY pom.xml /build

RUN env

RUN mvn clean install
COPY src /build/src
RUN mvn clean package -DskipTests && ls -lath /build/target

# Run our service using Amazon Corretto. Corretto gives free Java security updates
# FROM java:21

# COPY --from=mvn-build /build/target/capital-service-0.0.1-SNAPSHOT.jar /app/capital-service.jar
# CMD ["java", "-jar", "capital-service.jar"]
