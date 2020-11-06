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
             git url:'$repourl', branch:'issue-395'
          }
        }
        stage('Build Activator Docker Image')  {
          steps {
             sh "cp $GOOGLE_APPLICATION_CREDENTIALS docker/service-account.json"
             sh "ls -ltr docker/"
             sh "cat docker/service-account.json"
             sh "${DockerCMD} build -t tb-testt:$BUILD_NUMBER docker/."
             sh "${DockerCMD} image ls"
          }
        }
        stage('Run Activator Docker Image') {
          steps {
              sh "${DockerCMD} run -t -d --name base-activatorrrr$BUILD_NUMBER tb-testt:$BUILD_NUMBER"
              sh "${DockerCMD} ps"
           }
        }
         stage('Set Up Bucket') {
           steps {
             sh "gsutil mb -p $projectid -l europe-west2 gs://${activator_name}-${projectid}"
           }
         }
        stage('Activator Terraform init validate plan') {
           steps {
              sh "ls -ltr"
              sh "${DockerCMD} exec base-activatorrrr$BUILD_NUMBER ls -l"
              sh "${DockerCMD} exec base-activatorrrr$BUILD_NUMBER terraform init -backend-config=bucket=$activator_name-$projectid -backend-config=prefix=tb_admin ./tb-activator-gft-base"
              sh "${DockerCMD} exec base-activatorrrr$BUILD_NUMBER terraform validate ./tb-activator-gft-base "
              sh "${DockerCMD} exec base-activatorrrr$BUILD_NUMBER terraform plan -out activator-plan -var='host_project_id=$projectid' tb-activator-gft-base/"
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
              sh "${DockerCMD} exec base-activatorrrr$BUILD_NUMBER terraform apply --auto-approve activator-plan"
           }
         }
    }
}
