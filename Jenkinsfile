pipeline {
    agent any
    tools {
        maven 'M2_HOME'
    }
    
    options {
        checkoutToSubdirectory('source')
    }
    
    stages {
        stage ('Build') {
            
            steps {
                dir ('source') {
                    sh '''mvn -Dmaven.test.failure.ignore=true clean install
                          cp -R target/*.war ansible/hello-world.war'''
                }
                dir ('/home/ec2-user') {
                    sh 'terraform init && terraform apply -auto-approve'
                }
            }
        }
    }
}
