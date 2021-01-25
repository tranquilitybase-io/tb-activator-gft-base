FROM golang:alpine
MAINTAINER "GFT"

ENV TERRAFORM_VERSION=0.12.24
ENV ACTIVATOR_NAME=tb-activator-gft-base

RUN apk add --update git bash openssh python3 wget unzip jq

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/ && rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN mkdir deployment_code
COPY deployment/*.tf deployment_code/

# process activator variables json
COPY activator_params.json activator_params.json
RUN ["/bin/bash","-c", "cat activator_params.json | jq '.' > deployment_code/activator_params.json"]
RUN cat deployment_code/activator_params.json

# process environment variables json
COPY environment_params.json environment_params.json
RUN ["/bin/bash","-c", "cat environment_params.json | jq '.' > deployment_code/environment_params.json"]
RUN cat deployment_code/environment_params.json

RUN ls deployment_code

RUN mkdir /opt/app/ && mkdir /opt/app/data
COPY service-account.json /opt/app/data/.

