# Simple Java Springboot application
Simple java springboot application
endpoint :8080/health should answer "UP"
to build jar please use:
```
docker run -it --rm --name my-maven-project -v "$PWD":/usr/src/app -v "$HOME"/.m2:/root/.m2 -w /usr/src/app maven:3.6-jdk-8 mvn clean package
```
