pipeline {
    agent any
    environment {
        hello=123456
        world=456789
    }

    stages {
        stage('环境监测') {
            steps {
                sh 'whoami'
            }
        }
        stage('编译') {
            agent {
                docker {image 'golang:latest'}
            }
            steps {
                //
                sh 'go --version'
            }
        }
        stage('测试') {
            steps {
                //
                echo '测试.....'
            }
        }
        stage('打包') {
            steps {
                //
                echo '打包...'
            }
        }
        stage('部署') {
            steps {
                //
                echo '部署...'
            }
        }
    }
}