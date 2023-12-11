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
RUN apk add --no-cache bash htop mc git whois bind-tools curl wget zip unzip openssl jq inetutils-telnet mysql-client mariadb-client postgresql15-client terraform

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

#
# Copy additional scripts
#
COPY ./scripts/motd.sh /usr/local/bin/motd

#
# Setup entrypoint
#
COPY ./scripts/entrypoint.sh /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]

#
# Save build time to file
#
RUN date +'%d-%m-%Y %T %Z' > /etc/docker-tools-build
