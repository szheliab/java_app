node {

String subject = "${env.JOB_NAME} was " + "${env.BUILD_STATUS}";
String body = "${env.BUILD_STATUS} " + "${env.shortCommit}";
String to="kouris92@gmail.com"

try {
	stage('Checkout') {
		checkout scm     
	}

	stage('Maven build') {
		sh 'mvn clean package'
	}
	
	stage('Docker Build') {
		sh 'docker build -t my_app:my_app .'
	}

	stage('Docker RUN') {
		sh 'docker run -d --name java_app -p 8383:8080  my_app:my_app'
	}

	stage('Docker Check') {
		sleep 10
		def response = sh returnStdout: true, script: 'head -n1 <(curl -I 10.28.12.215:8383/health/ 2> /dev/null)'
		println response
	
	if (response.equals("HTTP/1.1 200"))
		{ println env.shortCommit
                  env.BUILD_STATUS = "SUCCESS"
                  env.shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
		 }
	   else { env.BUILD_STATUS = "FAILURE" }        

	}
	
}

catch (any) {

	println "${env.BUILD_STATUS}"
	
}

finally {
	stage('CleanUp') {
		sh 'docker rm -f java_app && docker rmi my_app:my_app'
		deleteDir()
	}
	stage('Send Mail') {
		emailext(subject: subject, body: body, to: to, );
	}
}
}
