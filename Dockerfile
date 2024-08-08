FROM achhaypathak/maven:latest AS mvn-build

# ARG GITHUB_ACTOR
# ARG GITHUB_TOKEN

# ENV GITHUB_ACTOR=${GITHUB_ACTOR}
# ENV GITHUB_TOKEN=${GITHUB_TOKEN}

RUN --mount=type=secret,id=GITHUB_ACTOR export GITHUB_ACTOR=$(cat /run/secrets/GITHUB_ACTOR) 
RUN --mount=type=secret,id=GITHUB_TOKEN export GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN) 

RUN env
# # RUN mkdir -p /root/.m2
# # RUN echo "<settings><servers><server><id>github</id><username>$GITHUB_ACTOR</username><password>$GITHUB_TOKEN</password></server></servers></settings>" > /root/.m2/settings.xml
# RUN --mount=type=secret,id=GITHUB_TOKEN export GITHUB_TOKEN=$(cat /run/secrets/GITHUB_TOKEN) 

# ENV GITHUB_TOKEN=$GITHUB_TOKEN

# RUN echo $GITHUB_TOKEN && env

COPY pom.xml /build

RUN env

RUN mvn -e -B dependency:resolve dependency:resolve-plugins
COPY src /build/src
RUN mvn clean package -DskipTests && ls -lath /build/target

# Run our service using Amazon Corretto. Corretto gives free Java security updates
FROM amazoncorretto:21-al2023
WORKDIR /app
COPY --from=mvn-build /build/target/test-1.0-SNAPSHOT.jar /app/test.jar
CMD ["java", "-jar", "test.jar"]
