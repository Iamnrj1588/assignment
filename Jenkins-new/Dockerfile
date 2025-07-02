FROM jenkins/jenkins:lts

USER root

# Install Docker CLI, Git, Node.js, unzip
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common unzip git && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian bookworm stable" > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install Sonar Scanner CLI
RUN curl -Lo /tmp/sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip && \
    unzip /tmp/sonar-scanner.zip -d /opt && \
    ln -s /opt/sonar-scanner-5.0.1.3006-linux /opt/sonar-scanner && \
    echo 'export PATH=$PATH:/opt/sonar-scanner/bin' >> /etc/profile && \
    echo 'export SONAR_SCANNER_OPTS="-Xmx512m"' >> /etc/profile

# Environment variables
ENV PATH=$PATH:/opt/sonar-scanner/bin
ENV SONAR_SCANNER_OPTS="-Xmx512m"

# Copy plugin list and install
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy Groovy init script
COPY init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

USER jenkins
