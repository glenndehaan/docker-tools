# Docker Tools

This collection of tools and resources is designed to enhance your debugging experience within Docker, Docker Swarm, and Kubernetes environments. By leveraging the power of containerization, the docker-tools image offers a comprehensive set of utilities to help you diagnose and troubleshoot problems seamlessly.

[![Image Size](https://img.shields.io/docker/image-size/glenndehaan/docker-tools)](https://hub.docker.com/r/glenndehaan/docker-tools)

## Tools
Below is an overview of all installed tools besides the default tools already available within Alpine Linux:

* **bash**: A widely used shell for executing commands, scripting, and interactive shell sessions.
* **less**: View and navigate large text files comfortably within the terminal.
* **glow**: Render markdown files in the terminal with rich formatting and syntax highlighting.
* **htop**: An interactive process viewer that provides detailed information about system processes, resource utilization, and more.
* **mc**: Midnight Commander, a text-based file manager that allows for efficient file operations within the container.
* **git**: Version control system for tracking changes in source code and collaborating with others.
* **whois**: A utility for querying WHOIS databases to retrieve information about domain registrations and IP addresses.
* **bind-tools**: A collection of DNS utilities, including `dig` and `nslookup`, for performing DNS-related diagnostics and lookups.
* **curl**: A versatile command-line tool for making HTTP requests and testing connectivity to web services.
* **wget**: A command-line tool for retrieving files from the web using various protocols such as HTTP, HTTPS, and FTP.
* **zip**: A utility for creating compressed zip archives.
* **unzip**: A utility for extracting files from zip archives.
* **openssl**: A powerful cryptographic toolkit that provides various tools and libraries for secure communication and data encryption.
* **openssh**: Connect securely to remote systems using the SSH protocol.
* **jq**: Process JSON data with ease, allowing for effective parsing and manipulation.
* **telnet**: Test network services by establishing a connection to a specified host and port.
* **nmap**: Perform network exploration and security auditing, discovering hosts and services on a network.
* **mysql-client**: Command-line interface for connecting to MySQL databases and executing SQL queries.
* **mariadb-client**: Command-line interface for connecting to MariaDB databases and performing database operations.
* **postgresql15-client**: Command-line interface for connecting to PostgreSQL databases and executing SQL queries.
* **kubectl**: Command-line interface for interacting with Kubernetes clusters, allowing you to manage and control your containerized applications.
* **helm**: A package manager for Kubernetes that simplifies the deployment and management of applications on a Kubernetes cluster.
* **helmfile**: Deploy multiple Kubernetes charts and manage Helm releases declaratively.
* **kubectx**: Switch between Kubernetes contexts with ease, simplifying management of multiple clusters.
* **kubent**: Simple tool to check whether you're using any deprecated APIs in your cluster and therefore should upgrade your workloads first, before upgrading your Kubernetes cluster.
* **kubeconform**: Validate Kubernetes resource YAML files against best practices and policies.
* **kube-linter**: Analyze Kubernetes configurations for potential issues and improvements.
* **testssl.sh**: Test SSL/TLS security configuration of a server by performing a comprehensive analysis.
* **shellcheck**: Analyze shell scripts for common errors, improving their reliability and maintainability.
* **hugo**: Build and manage static websites and blogs with the Hugo static site generator.

## Auto Rebuild
This feature ensures that the docker-tools image is automatically rebuilt and updated on a weekly basis, specifically during Saturday nights.

The purpose of this feature is to keep the docker-tools image up to date with the latest software versions, security patches, and enhancements.

Here's how the feature works:

* **Scheduled Rebuilds**: The docker-tools repository is configured to trigger an automatic rebuild of the image every Saturday night. This scheduled process ensures that the image remains current.
* **Software Updates**: During the rebuild process, the docker-tools image pulls the latest versions of the included debugging tools, utilities, and dependencies. This ensures that you have access to the most recent versions, incorporating bug fixes, performance improvements, and new features.
* **Security Enhancements**: Regularly rebuilding the docker-tools image allows for timely inclusion of security updates. By staying up to date, you can leverage the latest security patches and ensure that your debugging workflows within Docker, Docker Swarm, or Kubernetes environments are robust and protected against potential vulnerabilities.

## Usage
This container can be used in specific scenarios below are some of these described:

### Docker / Docker Swarm
You can use the container for quick debugging purposes for example exporting a database within the cluster.
Below is a command that spawns the container as a temporary one. When you exit out of the session it will clean up the container.

```shell
docker run --rm -it --pull=always glenndehaan/docker-tools /bin/sh
```

### Kubernetes
You can use the container for quick debugging purposes for example exporting a database within the cluster.
Below is a command that spawns the container as a temporary pod. When you exit out of the session it will clean up the pod.

```shell
kubectl run -i -v=4 --rm --tty debug --image=glenndehaan/docker-tools --restart=Never --image-pull-policy=Always -- sh
```

### Kubernetes - Init Container
You can use the container as a kubernetes init container for example to create a database before your main application starts.
Below is an example kubernetes deployment definition.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app-deployment
  labels:
    app: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      initContainers:
        - name: my-app-init
          image: glenndehaan/docker-tools:latest
          command: [ 'sh', '-c', 'echo -e "Run your scripts here!"' ]
      containers:
        - name: my-app
          image: user/app:latest
```

### GitLab
You can use the container as a base job image allowing you to access all included tools.
Below is an example GitLab job / `.gitlab-ci.yml` definition.

```yaml
example-job:
  image: glenndehaan/docker-tools:latest
  script:
    - echo "Run your scripts here!"
```

### GitHub Actions
You can use the container as a base container allowing you to access all included tools.
Below is an example GitHub action / `.github/workflows/test.yml`.

```yaml
name: Test

on:
  push:
    branches:
      - 'master'

jobs:
  example-job:
    runs-on: ubuntu-latest
    container: glenndehaan/docker-tools:latest
    steps:
      - name: Run motd
        run: motd
      - name: Example script
        run: echo "Run your scripts here!"
```
