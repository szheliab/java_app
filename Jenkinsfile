node {


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
		sleep 10
		while(Response!="HTTP/1.1 200" && (System.currentTimeMillis() < end_time)){
                    def Curl = "curl -I http://10.28.12.215:8383/health".execute().text
                    Response = Curl[0..11]
                    println Response
                }
	}
	
}

catch (any) {
	
	result = 'FAILuRE'
	throw any
}

finally {
println result

}
}
