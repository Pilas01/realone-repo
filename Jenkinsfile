pipeline {
    agent any
    environment {
        VERSION = "${env.BUILD_ID}"
    }
    stages {
        stage('Git checkout') {
            steps {
                git 'https://github.com/Pilas01/realone-repo.git'
            }
        }
        
        stage('Build with maven') {
            steps {
                sh 'cd SampleWebApp && mvn clean install'
            }
        }
        
             stage('Test') {
            steps {
                sh 'cd SampleWebApp && mvn test'
            }
        
            }

        stage("docker build & docker push"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'docker-password', variable: 'docker-pass')]) {
                             sh '''
                                docker build -t 18.116.23.238:8083/springapp:${VERSION} .
                                docker login -u admin -p admin 18.116.23.238:8083
                                docker push 18.116.23.238:8083/springapp:${VERSION}
                                docker rmi 18.116.23.238:8083/springapp:${VERSION}
                                 
                            '''
                       }
                    }
                }
            }
         
         stage('Deploying application on k8s cluster') {
            steps {
               script{
                    withCredentials([[
    $class: 'AmazonWebServicesCredentialsBinding',
    credentialsId: "mycredentials",
    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
]]) { 
                        dir('kubernetes/') {
                          sh 'aws eks update-kubeconfig --name myapp-eks-cluster --region us-east-1'
                          sh 'kubectl apply -f deploy-loadbalancer.yml'



 
                        }
                    }
               }
            }
        }
        
        }
    }
