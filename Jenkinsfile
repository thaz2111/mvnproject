pipeline{
    agent any;
stages{
    stage('git clone'){
    steps{
        git 'https://github.com/thaz2111/mvnproject.git'
        }
        }
    stage('maven build'){
        steps{
            def mavenHome = tool name: "maven-3.8.6", type: "maven"
            def mavenCMD = "${mavenHome/bin/mvn}"
            sh '${mavenCMD} clean package'
            
        }
    }
}
}