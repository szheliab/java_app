node {

def subject =  println "test1" 
def body = echo "test2"
def to = "kouris92@gmail.com"
println subject
println body
println to

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

println subject
println body
println to

	
}

catch (any) {

	
}

finally {
	
        stage('Send Mail') {
		if(response.equals("HTTP/1.1 200")) {

		result = "SUCCESS"
		env.shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
		emailext(subject: subject, body: body, to: to); }
		
		else {

		result = "FAILURE"
                env.shortCommit = sh(returnStdout: true, script: "git log -n 1 --pretty=format:\'%h\'").trim()
                emailext(subject: subject, body: body, to: to); }

        }

println subject
println body
println to

	stage('CleanUp') {
		sh 'docker rm -f java_app && docker rmi my_app:my_app'
		sh 'git clean -ffdx'
		deleteDir()
	}

println subject
println body
println to

}

}
