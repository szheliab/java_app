node {

def Response
String recepients = 'kouris92@gmail.com'

try {
	stage(name : 'Checkout') {
		checkout scm     
	}

	stage(name : 'Maven build') {
		sh 'mvn clean package'
	}
	
	stage('Docker Build') {
		sh 'docker build -t my_app:my_app .'
	}

	stage('Docker RUN') {
		sh 'docker run -d --name java_app -p 8383:8080  my_app:my_app'
	}

	stage('Docker Check') {
		def proc = sh './curl.sh'.execute()
		def b = new StringBuffer()
		proc.consumeProcessErrorStream(b)

		println proc.text
		println b.substring()
	}
	if (Response=="HTTP/1.1 200") 
	      { currentBuild.result = 'SUCCESS' }
	 else { currentBuild.result = 'FAILURE' }
	

}

catch (any) {
	
	currentBuild.result = 'FAILURE'
	throw any
}

finally {

stage ('Send mail') {        
	println currentBuild.result
	step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: 'kouris92@gmail.com', sendToIndividuals: true])
	}

stage ('CleanUP') {
	sh 'docker rm -f java_app && docker rmi my_app:my_app'
	deleteDir()
	}
}
}
