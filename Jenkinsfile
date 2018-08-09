node {

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

		env.shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
                env.BUILD_STATUS = "FAILURE"
                String body = "${env.BUILD_STATUS} " + "${env.shortCommit}";
                String subject = "${env.JOB_NAME} was " + "${env.BUILD_STATUS}";
                emailext(subject: subject, body: body, to: to);
}

finally {
	
        stage('Send Mail') {
		if(response.equals("HTTP/1.1 200")) {

		env.shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
                env.BUILD_STATUS = "SUCCESS"
                String body = "${env.BUILD_STATUS} Commit " + "${env.shortCommit}";
                String subject = "${env.JOB_NAME} was " + "${env.BUILD_STATUS}";
		emailext(subject: subject, body: body, to: to); }
		
		else {

		env.shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
                env.BUILD_STATUS = "FAILURE"
                String body = "${env.BUILD_STATUS} " + "${env.shortCommit}";
                String subject = "${env.JOB_NAME} was " + "${env.BUILD_STATUS}";
                emailext(subject: subject, body: body, to: to); }

        }

	stage('CleanUp') {
		sh 'docker rm -f java_app && docker rmi my_app:my_app'
		/*sh 'git clean -ffdx'
		deleteDir() */
	}


}

}
