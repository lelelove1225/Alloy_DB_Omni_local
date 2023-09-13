FROM debian:lts 

# Install dependencies
RUN apt-get update && apt-get install -y curl gnupg2
RUN curl https://asia-apt.pkg.dev/doc/repo-signing-key.gpg | apt-key add -
RUN echo "deb https://asia-apt.pkg.dev/projects/alloydb-omni alloydb-omni-apt main" \
    | tee -a /etc/apt/sources.list.d/artifact-registry.list
RUN apt-get update && apt-get install -y alloydb-cli

# Install Google Cloud CLI
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates gnupg
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
RUN apt-get update && apt-get install -y google-cloud-sdk

