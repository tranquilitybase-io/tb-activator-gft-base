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
         stage('Remove previous Docker Images')  {
          steps {
          //  sh "${DockerCMD} container stop f1b6b5656b73" 
            sh "${DockerCMD} image rm -f 831bf72f9b9c"
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
              sh "${DockerCMD} run -t -d --name base-activators$BUILD_NUMBER tb-test:$BUILD_NUMBER"
              sh "${DockerCMD} ps"
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
         stage('Set Up Bucket') {
           steps {
             sh "gsutil mb -p $projectid -l europe-west2 gs://${activator_name}-${projectid}"
           }
         }
        stage('Activator Terraform init validate plan') {
           steps {
              sh "ls -ltr"
              sh "${DockerCMD} exec base-activators$BUILD_NUMBER ls -l"
              sh "${DockerCMD} exec base-activators$BUILD_NUMBER terraform init -backend-config=bucket=$activator_name-$projectid -backend-config=prefix=tb_admin ./tb-activator-gft-base"
              sh "${DockerCMD} exec base-activators$BUILD_NUMBER terraform validate ./tb-activator-gft-base "
              sh "${DockerCMD} exec base-activators$BUILD_NUMBER terraform plan -out activator-plan -var='host_project_id=$projectid' tb-activator-gft-base/"
           }
        }
        stage('Activator Infra Deploy') {
           steps {
              sh "${DockerCMD} exec base-activators$BUILD_NUMBER terraform apply --auto-approve activator-plan"
           }
         }
    }
}
