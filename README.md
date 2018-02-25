# Mosquitto-Auth-with-Custom-Cert-on-Docker
Note that currently Postgres version is only working while mysql version has problem with accessing database in current development phase.
## Starting containers
In order to generate custom certificate that can be used on client side you need to generate it first with script ./generate-CA. If you don't need certificates you can ommit this step but you need to adjust mosquitto.conf in mosquitto/auth_backends/POSTGRES/mosquitto.conf and remove last 3 lines regarding certificates
```bash
cd mosquitto
./generate-CA.sh your_host your_host_ip
cd ..
docker-compose up
```
## Testing with mosquitto client
You will get two users on initial setup one is **test** with pass test123 who can write only on topic test/# and the other one is **super** with pass super123 which can read and write on all topics. Please note that you will need to use option -i to set identity since default identity is not acceptable because it has / in string:
```bash
#super
mosquitto_pub -i superId -d  -p 8883 --cafile mosquitto/ca.crt -u super -P super123 -t 'mytopic' -m 'yoyo'
mosquitto_sub -i superId -v  -p 8883 --cafile mosquitto/ca.crt -u super -P super123 -t '#'

#test
mosquitto_pub -i testId -d  -p 8883 --cafile mosquitto/ca.crt -u test -P test123 -t 'test/topic' -m 'yoyo'
mosquitto_sub -i testId -v  -p 8883 --cafile mosquitto/ca.crt -u test -P test123 -t 'test/#'

```
For more users and ACL lists you will need to connect to 
```bash
ubuntu@dev:~/docker$ docker exec -ti postgres bash
root@e3d946f35859:/# psql -d mosquitto_auth
psql: FATAL:  database "mosquitto_auth" does not exist
root@e3d946f35859:/# psql -d mosquitto-auth
```
After that you have insert examples here: https://github.com/appmodule/Mosquitto-Auth-with-Custom-Cert-on-Docker/blob/master/postgres/mosquitto-auth.sql
For password you need to generate PBKDF2-sha256 passwords using NodeJS tool https://github.com/manolodd/pbkdf2-mosquitto or for other languages you can find scripts here: https://github.com/jpmens/mosquitto-auth-plug/tree/master/contrib

Thanks for great work which is using here in project:
 1. https://github.com/jpmens/mosquitto-auth-plug/
 2. https://gist.githubusercontent.com/kirang89/b7579e5f331df2313078/raw/fb1a72b0cd090af76b63710944401b09b1c73da0/generate-CA.sh
