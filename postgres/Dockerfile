FROM postgres

ENV POSTGRES_USER root
ENV POSTGRES_DB mosquitto-auth
ENV POSTGRES_PASSWORD test123

COPY mosquitto-auth.sql /docker-entrypoint-initdb.d/
