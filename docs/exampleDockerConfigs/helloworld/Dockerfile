# Stage 1: build the docker image 'docker build .'
# Stage 2: Create a local directory for docker volum to put service account file.
# Stage 3: run the image, docker run -t -v {local directory for service account file}:/opt/app/data/ -d {image_id} 
# Stage 4: execute command on container,  'docker exec -it {container_id}  terraform init tb-activator-gft-datazone/'


FROM docker.pkg.github.com/tranquilitybase-io/tb-activator-gft-base/activator-base:1.0
MAINTAINER "GFT"


COPY info.json .

RUN git clone https://github.com/tranquilitybase-io/tb-activator-gft-base.git


