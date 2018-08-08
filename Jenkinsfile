node {

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
	}
	
}

catch (any) {

	
}

finally {
	stage('CleanUp') {
		sh 'docker rm -f java_app && docker rmi my_app:my_app'
		deleteDir()
	}

	stage('Send Mail') {
		if (response.equals("HTTP/1.1 200"))
                {   emailext (
			subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'")
		}
           else { emailext (
			subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'") }

	}

}
}
