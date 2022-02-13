FROM openjdk:17 as build

ADD target/app.jar /app.jar
RUN jar -xf app.jar

FROM openjdk:17

COPY --from=build /BOOT-INF/lib /app/lib/
COPY --from=build /META-INF /app/META-INF
COPY --from=build /BOOT-INF/classes /app
ENTRYPOINT ["java","-cp","app:app/lib/*","ru.rsavin.usersmanagement.Application"]