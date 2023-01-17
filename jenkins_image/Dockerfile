FROM jenkins/jenkins:lts

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /var/jenkins_home
RUN jenkins-plugin-cli --plugin-file /var/jenkins_home/plugins.txt

ENV CASC_JENKINS_CONFIG "${JENKINS_HOME}"/casc
COPY --chown=jenkins:jenkins casc "${JENKINS_HOME}"/casc
COPY --chown=jenkins:jenkins utilities "${JENKINS_HOME}"/utilities