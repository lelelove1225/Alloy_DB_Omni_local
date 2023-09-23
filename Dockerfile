FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings

# Install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg

# Add docker repository
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME")" stable" > /etc/apt/sources.list.d/docker.list

# Install Docker
RUN apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io 

# Install alloydb-cli
RUN apt-get update && apt-get install -y curl gnupg2
RUN curl https://asia-apt.pkg.dev/doc/repo-signing-key.gpg | apt-key add -
RUN echo "deb https://asia-apt.pkg.dev/projects/alloydb-omni alloydb-omni-apt main" \
    | tee -a /etc/apt/sources.list.d/artifact-registry.list
RUN apt-get update && apt-get install -y alloydb-cli

# Add gcloud repository and Install Google Cloud CLI
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk docker

# Check, configure, install and create directory
# after install alloydb
RUN mkdir /data && alloydb system-check && sudo alloydb database-server install --data-dir=/data
