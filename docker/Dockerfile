FROM golang:alpine
MAINTAINER "GFT"

ENV TERRAFORM_VERSION=0.12.24
ENV ACTIVATOR_NAME=tb-activator-gft-base

RUN apk add --update git bash openssh python3 wget unzip jq

RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/ && rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN mkdir tb-activator-gft-base
COPY *.tf tb-activator-gft-base/

#
COPY input.auto.tfvars.json tb-activator-gft-base/pre-transform.json
# RUN ["/bin/bash","-c", "cat tb-activator-gft-base/pre-transform.json | jq '.' > tb-activator-gft-base/pre-transform.json"]
RUN cat tb-activator-gft-base/input.auto.tfvars.json

RUN ls tb-activator-gft-base

RUN mkdir /opt/app/ && mkdir /opt/app/data
COPY service-account.json /opt/app/data/.

