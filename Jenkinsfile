node {

String Recepients = 'kouris92@gmail.com'

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
	
        stage('Send Mail') {
		step([$class: 'Mailer',
                notifyEveryUnstableBuild: true,
                recipients: "kouris92@gmail.com",
                sendToIndividuals: true])
        }


	stage('CleanUp') {
		sh 'docker rm -f java_app && docker rmi my_app:my_app'
		sh 'git clean -ffdx'
		deleteDir()
	}
}

}
