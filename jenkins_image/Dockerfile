FROM jenkins/jenkins:lts

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /var/jenkins_home
RUN jenkins-plugin-cli --plugin-file /var/jenkins_home/plugins.txt

USER root
RUN apt install unzip && apt-get update \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip && ./aws/install

USER jenkins

COPY --chown=jenkins:jenkins utilities "${JENKINS_HOME}"/utilities
COPY --chown=jenkins:jenkins casc "${JENKINS_HOME}"/casc
ENV CASC_JENKINS_CONFIG "${JENKINS_HOME}"/casc