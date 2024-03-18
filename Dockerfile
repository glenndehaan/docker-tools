#
# Define OS
#
FROM alpine:3.19

#
# Set Arguments
#
ARG TARGETARCH

#
# Basic OS management
#

# Install packages
RUN apk add --no-cache bash less htop mc git whois bind-tools curl wget zip unzip openssl openssh jq inetutils-telnet procps-ng coreutils mysql-client mariadb-client postgresql15-client kubectx nmap shellcheck hugo \
    && apk add --no-cache helmfile glow --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing

#
# Install additional packages
#

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$TARGETARCH/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh \
    && rm get_helm.sh

# Install kubent
RUN curl -fsSL -o get_kubent.sh https://raw.githubusercontent.com/doitintl/kube-no-trouble/master/scripts/install.sh \
    && chmod 700 get_kubent.sh \
    && TERM=xterm ./get_kubent.sh \
    && rm get_kubent.sh

# Install kubeconform
RUN curl -fsSL -o kubeconform-linux-$TARGETARCH.tar.gz https://github.com/yannh/kubeconform/releases/latest/download/kubeconform-linux-$TARGETARCH.tar.gz \
    && tar xf kubeconform-linux-$TARGETARCH.tar.gz \
    && cp kubeconform /usr/local/bin \
    && rm kubeconform \
    && rm kubeconform-linux-$TARGETARCH.tar.gz \
    && rm LICENSE

# Install kube-linter
RUN curl -fsSL -o kube-linter https://github.com/stackrox/kube-linter/releases/latest/download/kube-linter-linux \
    && chmod 755 kube-linter \
    && cp kube-linter /usr/local/bin \
    && rm kube-linter

# Install testssl.sh
RUN mkdir /opt/testssl \
    && git clone --depth 1 https://github.com/drwetter/testssl.sh.git /opt/testssl \
    && ln -s /opt/testssl/testssl.sh /usr/local/bin/testssl

#
# Copy additional scripts
#
COPY ./scripts/motd.sh /usr/local/bin/motd
COPY ./scripts/readme.sh /usr/local/bin/readme

#
# Setup entrypoint
#
COPY ./scripts/entrypoint.sh /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]

#
# Save build time to file
#
RUN date +'%d-%m-%Y %T %Z' > /etc/docker-tools-build

#
# Copy README
#
COPY ./README.md /opt/README.md
