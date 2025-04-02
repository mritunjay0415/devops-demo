pipeline {
    agent any
    environment {
        KUBECONFIG = "~/.kube/config"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', 
                    branches: [[name: '*/main']], 
                    userRemoteConfigs: [[url: 'https://github.com/mritunjay0415/devops-demo.git']]
                ])
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    sh '''
                    terraform init
                    terraform apply -auto-approve
                    '''
                }
            }
        }
        stage('Ansible Deploy') {
            steps {
                script {
                    sh '''
                    ansible-playbook -i inventory deploy.yaml
                    '''
                }
            }
        }
    }
    post {
        always {
            echo 'Job finished'
        }
    }
}
