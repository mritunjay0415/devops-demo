pipeline {
    agent any
    environment {
        KUBECONFIG = "~/.kube/config"  // Set the Kubernetes config file path
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the GitHub repository
                git 'https://github.com/mritunjay0415/devops-demo.git'
            }
        }
        stage('Terraform Apply') {
            steps {
                script {
                    // Initialize Terraform and apply changes
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
                    // Run the Ansible playbook to deploy Nginx
                    sh '''
                    ansible-playbook -i inventory deploy.yaml
                    '''
                }
            }
        }
    }
    post {
        always {
            // Clean up or notify after the job
            echo 'Job finished'
        }
    }
}
