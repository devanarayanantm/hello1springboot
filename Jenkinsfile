pipeline {
    agent any

//    tools {
//       maven 'Maven 3.8.6'
//        jdk 'Java 17'
//    }

    stages {

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Docker Image Build and Push') {
            when {
                branch 'main'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred-id', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        docker login -u $DOCKER_USER -p $DOCKER_PASS
                        docker build -t $DOCKER_USER/examspring .
                        docker push $DOCKER_USER/examspring
                    '''
                }
            }
        }

	stage('Kubernetes Deploy') {
	    when {
        	branch 'main'
    	    }
    	    steps {
        	sh '''
                        kubectl delete -f k8smanifest/deployment.yaml --ignore-not-found

                        echo "Reapplying deployment..."
                        kubectl apply -f k8smanifest/deployment.yaml

            	//	kubectl apply -f k8smanifest/deployment.yaml
           	//	kubectl apply -f k8s/service.yaml
        	'''
    }
}
    }
}
