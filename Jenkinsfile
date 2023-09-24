pipeline {
          
	 agent {
                  label "aj-slave"
	       } 
	  
	    stages {
	           stage ("Pull the Code") {
                        steps {
                            git branch: 'main', url: 'https://github.com/ajay-devop/aws-project.git'  
			  }
		   }
                   stage ("Build the Code") {
                        steps {
                            sh 'sudo mvn clean package' 
			  }       
		   }
		   stage ("Create Docerfile") {
                        steps {
                            sh 'sudo docker build -t new-java-app:$BUILD_TAG .'
			    sh 'sudo docker tag new-java-app:$BUILD_TAG ajaydevop/new-java-app:$BUILD_TAG'
			}
		   }
		   stage ("Push the docker Image") {
                        steps {
			    withCredentials([usernamePassword(credentialsId: 'dockerhub-password', passwordVariable: 'docker_pass_var', usernameVariable: 'docker_user_var')]) {
                            sh 'sudo docker login -u ${docker_user_var} -p ${docker_pass_var}'
			    sh 'sudo docker push ajaydevop/new-java-app:$BUILD_TAG'
}
                           
			}
		   }
		   stage ("Create docker container") {
                        steps {
                            sh 'sudo docker rm -f $(docker ps -a -q)'
			    sh 'sudo docker run -dit --name web -p 8080:8080 ajaydevop/new-java-app:$BUILD_TAG'
			}
		   }
		   stage ("Approval by User") {
                        steps {
                               input 'please confirm the massage'
			}
		   }
		   stage ("Production box") {
                        steps {
			       script {
                                   sshagent (["production-key"]){
                                      sh 'ssh ubuntu@13.233.199.135 -o StrictHostKeyChecking= no'
				      sh 'ssh ubuntu@13.233.199.135 sudo docker run -d -p 8080:8080 ajaydevop/new-java-app:$BUILD_TAG'
				   }
			       }
			}
		   }

	  }

}
