FROM jenkins/jenkins:lts

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ENV JENKINS_HOME=/var/jenkins_home
#RUN groupadd -g ${gid} ${group} \
 #   && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}
    
USER root
RUN apt-get update -qq \
    && apt-get install -y apt-utils curl \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
&& apt-get install docker-ce=17.12.1~ce-0~debian -y

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
 
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
# Scaling
#RUN /usr/local/bin/install-plugins.sh kubernetes

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
