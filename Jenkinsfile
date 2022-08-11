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
            sh 'mvn clean package'
            }
    }
    stage('sonar test'){
        steps{
            withSonarQubeEnv('Sonar-Server-7.8'){

            sh 'mvn sonar:sonar'
            }
        }

    }
    stage('Artifacts to Nexus Repo'){
        steps{
nexusArtifactUploader artifacts: [[
        artifactId: '01-maven-web-app', 
        file: 'target/01-maven-web-app.war', 
        type: 'war']], 
        credentialsId: 'Nexus', 
        groupId: 'in.arsalan', 
        nexusUrl: '65.2.10.30:8081', 
        nexusVersion: 'nexus3', 
        protocol: 'http', 
        repository: 'mvnrelease', 
        version: '1.0-RELEASE'
        }
    }
    stage('Docker Build'){
        steps{
            sh 'docker build -t thazeemsk/javawebapp'
        }
    }
    stage('Docker Push'){
        steps{
            withCredentials([string(credentialsId: 'dockercreden', variable: 'Dockercred')]) {
            sh 'docker login -u thazeemsk -p ${Dockercred}'
        }
        sh 'docker push thazeemsk/javawebapp'
        }
    }
    stage('kubernetes deploy'){
        steps{
            kubernetesDeploy(
            configs: 'maven-webapp.yml',
            kubeconfigId: 'kubernetes'
        )
        }
    }
    stage('Deploy in Apache Tomcat'){
        steps{
            sshagent(['ssh-agent']){
               sh 'scp -o StrictHostKeyChecking=No target/01-maven-webapp.war ec2-user@ip:/home/ubuntu/apache-tomcat-9.0.65/webapps'
               sh 'ssh -o StrictHostKeyChecking=no ubuntu@13.126.219.66 sh /home/ubuntu/apache-tomcat-9.0.65/bin/startup.sh'  
                 }
         }
    }
}
}
