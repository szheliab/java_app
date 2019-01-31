# Simple Java Springboot application
Simple java springboot application
endpoint :8080/health should answer "UP".
To build jar please use:
```
docker run -it --rm --name my-maven-project -v "$PWD":/usr/src/app -v "$HOME"/.m2:/root/.m2 -w /usr/src/app maven:3.6-jdk-8 mvn clean package
```
Application can take environment variables:
```
DB_HOST: mysqlhost
DB_PORT: 3306
DB_NAME: testdb
DB_USER: root
DB_PASS: 123456aA
```
