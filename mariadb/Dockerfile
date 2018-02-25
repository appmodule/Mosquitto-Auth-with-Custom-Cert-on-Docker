FROM mariadb

ENV MYSQL_DATABASE mosquitto-auth
ENV MYSQL_ROOT_PASSWORD test123

COPY mosquitto-auth.sql /docker-entrypoint-initdb.d/
