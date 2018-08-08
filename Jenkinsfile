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
                long start_time = System.currentTimeMillis();
                long wait_time = 10000;
                long end_time = start_time + wait_time
                while(Response!="HTTP/1.1 200" && (System.currentTimeMillis() < end_time)){
                    def Curl = "curl -I http://10.28.12.215:8383".execute().text
                    Response = Curl[0..11]
                    println Response
		}
	if (Response=="HTTP/1.1 200") 
	      { currentBuild.result = 'SUCCESS' }
	 else { currentBuild.result = 'FAILURE' }
	}

}

catch (any) {
	
	currentBuild.result = 'FAILURE'
	throw any
}

finally {

stage ('Send mail') {        
	println currentBuild.result
	step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: '${recipients}', sendToIndividuals: true])
	}

stage ('CleanUP') {
	deleteDir()
	}
}
}
