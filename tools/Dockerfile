FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
        curl \
        wget \
        unzip \
        gnupg \
        lsb-release \
        software-properties-common \
        git \
        python3-pip \
        && rm -rf /var/lib/apt/lists/*

# tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Terraform
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform

# terraform-docs
RUN curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.19.0/terraform-docs-v0.19.0-$(uname)-amd64.tar.gz \
    && tar -xzf terraform-docs.tar.gz \
    && chmod +x terraform-docs \
    && mv terraform-docs /usr/local/bin/terraform-docs \
    && rm terraform-docs.tar.gz

# kubectl
RUN KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt) && \
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# helmfile
RUN curl -Lo ./helmfile.tar.gz https://github.com/helmfile/helmfile/releases/download/v1.1.0/helmfile_1.1.0_linux_amd64.tar.gz \
    && tar xzf ./helmfile.tar.gz \
    && mv helmfile /usr/local/bin \
    && chmod +x /usr/local/bin/helmfile

# ansible-lint
RUN pip3 install  --break-system-packages ansible-lint
