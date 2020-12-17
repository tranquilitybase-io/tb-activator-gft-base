pipeline
{
    agent any
    environment {
        def DockerHome = tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
        def DockerCMD = "${DockerHome}/bin/docker"
        def activator_params = "${activator_params}"
    }
    stages {
        stage('Activate GCP Service Account and Set Project') {
            steps {
                sh "gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS"
                sh "gcloud config set project $projectid"
            }
        }
        stage('Enable Required Google APIs') {
            steps {
                script {
                    def activator_metadata = readYaml file: ".tb/activator_metadata.yml"
                    echo "activator_metadata map ${activator_metadata}"
                    def gcpApisRequired = activator_metadata.get('gcpApisRequired')
                    if (gcpApisRequired) {
                        gcpApisRequired.each {
                            echo "Enabling $it"
                            sh "gcloud services enable $it"
                        }
                    }
                }
            }
        }
        stage('Build Activator Docker Image') {
            steps {
                sh "cp $GOOGLE_APPLICATION_CREDENTIALS service-account.json"
                sh "cat service-account.json"
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
                sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform plan -out activator-plan -var='host_project_id=$projectid' -var-file=deployment_code/activator_params.json deployment_code/"
            }
        }
        stage('Activator Infra Deploy') {
            steps {
                sh "${DockerCMD} exec base-activator$BUILD_NUMBER terraform apply  --auto-approve activator-plan"
            }
        }
    }
}
