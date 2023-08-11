pipeline {
    agent {
        label "docker-slave"
    }
    tools {
            terraform 'terraform'
    }

    environment {
        DO_TOKEN     = credentials('do_token')
        PVT_KEY     = credentials('private_key') 
        
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/kansola/terraform-project.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform plan') {
            steps {
               sh 'terraform plan -var "do_token=$DO_TOKEN" -var "pvt_key=$PVT_KEY"'
            }
        }
        stage('Apply / Destroy') {
            steps {
               sh 'terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PVT_KEY" --auto-approve'
            }

        }
    }
}
