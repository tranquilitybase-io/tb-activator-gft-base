pipeline
{
    agent any
    environment {
       def DockerHome = tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
       def DockerCMD = "${DockerHome}/bin/docker"
       def activator_params = "${activator_params}"
       def activator_metadata = readYaml file: ".tb/activator_metadata.yml"
    }
    stages {
        stage('Read activator metadata') {
          steps {
            echo "1 $activator_metadata"
            echo "2 ${activator_metadata}""
          }
        }
        stage('Build Activator Docker Image')  {
          steps {
             sh "cp $GOOGLE_APPLICATION_CREDENTIALS service-account.json"
             sh "cat service-account.json"
             sh "echo ${activator_params}"
             sh "echo \$activator_params"
             sh "echo \$activator_params > activator_params.json"
             sh "ls -ltr docker/"
             sh "${DockerCMD} build -f docker/Dockerfile -t tb-test:$BUILD_NUMBER ."
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
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform init deployment_code"
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform validate deployment_code/"
              sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform plan -out activator-plan -var='host_project_id=$projectid' deployment_code/"
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
       }
}
