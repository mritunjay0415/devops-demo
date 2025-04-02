pipeline {
    agent any
    environment {
        KUBECONFIG = "/var/lib/jenkins/.kube/config"  // Ensure Jenkins uses the correct kubeconfig
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
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Check and Import Namespace') {
            steps {
                script {
                    // Extract namespace name dynamically from main.tf
                    def namespace = sh(script: "grep 'name =' main.tf | awk -F'\"' '{print \$2}'", returnStdout: true).trim()
                    
                    if (namespace) {
                        echo "Extracted namespace from main.tf: ${namespace}"
                        
                        // Check if namespace already exists in Kubernetes
                        def namespaceExists = sh(script: "microk8s.kubectl get namespace ${namespace} --no-headers --ignore-not-found | wc -l", returnStdout: true).trim()
                        
                        if (namespaceExists == "1") {
                            echo "Namespace '${namespace}' already exists. Importing into Terraform..."
                            sh "terraform import kubernetes_namespace.demo_ns ${namespace} || echo 'Namespace already imported.'"
                        } else {
                            echo "Namespace '${namespace}' does not exist. Proceeding with Terraform apply."
                        }
                    } else {
                        echo "No namespace found in main.tf. Skipping import check."
                    }
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Ansible Deploy') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yaml'
            }
        }
    }
    post {
        always {
            echo 'Job finished'
        }
    }
}
