node {

String subject = """${env.JOB_NAME} was ${result}""";
String body = """${result} commit ${shortCommit}""";
String to = "kouris92@gmail.com"
def response

try {
	stage('Checkout') {
		checkout scm     
	}

	stage('Maven build') {
		sh 'mvn clean package'
	}
	
	stage('Sonar') {
		def mvnHome = tool name: 'Maven', type: 'maven'
		withSonarQubeEnv('SonarQUBE') {
			sh "${mvnHome}/bin/mvn sonar:sonar"
		}
	}
	stage('Docker Build') {
		sh 'docker build -t my_app:my_app .'
	}

	stage('Docker RUN') {
		sh 'docker run -d --name java_app -p 8383:8080  my_app:my_app'
	}

	stage('Docker Check') {
		sleep 10
		response = sh returnStdout: true, script: 'head -n1 <(curl -I 10.28.12.215:8383/health/ 2> /dev/null)'
		println response
	}

}

catch (any) {

		result = "FAILURE"
                shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
                emailext(subject: subject, body: body, to: to);
}

finally {
	
        stage('Send Mail') {
		if(response.equals("HTTP/1.1 200")) {

		result = "SUCCESS"
		shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
		emailext(subject: subject, body: body, to: to); }
		
		else {

		result = "FAILURE"
                shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
                emailext(subject: subject, body: body, to: to); }

        }

	stage('CleanUp') {
		sh 'docker rm -f java_app && docker rmi my_app:my_app'
		sh 'git clean -ffdx'
		deleteDir()
	}


}

}
