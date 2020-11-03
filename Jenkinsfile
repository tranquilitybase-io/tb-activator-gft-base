pipeline
{
  agent any
    environment {
    def DockerHome = tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
    def DockerCMD = "${DockerHome}/bin/docker"
    }
    stages {
        stage('Activator SCM Checkout') {
          steps {
             git '$repourl'
          }
        }
        stage('Build Activator Docker Image')  {
          steps {
             sh "cp $GOOGLE_APPLICATION_CREDENTIALS docker/service-account.json"
             sh "ls -ltr docker/"
             sh "cat docker/service-account.json"
             sh "${DockerCMD} build -t tb-test:$BUILD_NUMBER docker/."
             sh "${DockerCMD} image ls"
          }
        }
        stage('Run Activator Docker Image') {
          steps {
              sh "${DockerCMD} run -t -d --name base-activator$BUILD_NUMBER tb-test:$BUILD_NUMBER"
              sh "${DockerCMD} ps"
           }
        }
        stage('Activator Terraform init validate plan') {
           steps {
              sh "ls -ltr"
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform init -force-copy tb-activator-gft-base/"
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform validate tb-activator-gft-base/"
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform plan -out activator-plan -var='host_project_id=$projectid' -var='activator_name=$activator_name' tb-activator-gft-base/"
           }
        }
        stage('Enable Required Google APIs') {
           steps {
              sh "gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS"
              sh "gcloud config set project $projectid"
              sh "gcloud services enable compute.googleapis.com"
              sh "gcloud services enable servicemanagement.googleapis.com"
              sh "gcloud services enable cloudresourcemanager.googleapis.com"
              sh "gcloud services enable storage-api.googleapis.com"
           }
        }
        stage('Activator Infra Deploy') {
           steps {
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform apply  --auto-approve activator-plan"
           }
         }
        stage('Set Up Remote State') {
           steps {
             sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform init -backend-config=bucket=activator-gft-base-shared-ec-3qe6vmxe -backend-config=prefix=tb_admin -force-copy tb-activator-gft-base/"
        }
      }
    }
