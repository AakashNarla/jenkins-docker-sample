FROM tomcat:8
# Take the war and copy to webapps of tomcat

from jenkins/jenkins:lts

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ENV JENKINS_HOME=/var/jenkins_home
RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}
    
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
    
    ace-editor:1.1
analysis-core:1.95
ant:1.8
antisamy-markup-formatter:1.5
artifactory:2.15.1
authentication-tokens:1.3
blueocean:1.4.2
bouncycastle-api:2.16.2
branch-api:2.0.19
build-timeout:1.19
build-with-parameters:1.4
claim:2.14.1
cloudbees-disk-usage-simple:0.9
cloudbees-folder:6.4
cobertura:1.12
command-launcher:1.2
config-file-provider:2.18
credentials-binding:1.16
credentials:2.1.16
display-url-api:2.2.0
docker-commons:1.11
docker-workflow:1.15.1
durable-task:1.22
email-ext:2.62
embeddable-build-status:1.9
external-monitor-job:1.7
favorite:2.3.1
findbugs:4.72
git-client:2.7.1
git-server:1.7
git:3.8.0
github-api:1.90
github-branch-source:2.3.3
github-organization-folder:1.6
github:1.29.0
gradle:1.28
greenballs:1.15
groovy:2.0
handlebars:1.1.1
htmlpublisher:1.15
icon-shim:2.0.3
ivy:1.28
jackson2-api:2.8.11.1
jacoco:3.0.1
javadoc:1.4
jquery-detached:1.2.1
junit:1.24
last-changes:2.6.2
mailer:1.21
mapdb-api:1.0.9.0
matrix-auth:2.2
matrix-project:1.12
maven-plugin:3.1.2
metrics:3.1.2.11
momentjs:1.1.1
pam-auth:1.3
pipeline-build-step:2.7
pipeline-github-lib:1.0
pipeline-graph-analysis:1.6
pipeline-input-step:2.8
pipeline-milestone-step:1.3.1
pipeline-model-api:1.2.8
pipeline-model-declarative-agent:1.1.1
pipeline-model-definition:1.2.8
pipeline-model-extensions:1.2.8
pipeline-rest-api:2.10
pipeline-stage-step:2.3
pipeline-stage-tags-metadata:1.2.8
pipeline-stage-view:2.10
plain-credentials:1.4
prometheus:1.1.1
pubsub-light:1.12
resource-disposer:0.8
role-strategy:2.7.0
saml:1.0.5
scm-api:2.2.6
script-security:1.43
sse-gateway:1.15
ssh-credentials:1.13
ssh-slaves:1.26
structs:1.14
support-core:2.46
timestamper:1.8.9
token-macro:2.4
variant:1.1
violations:0.7.11
warnings:4.68
windows-slaves:1.3.1
workflow-aggregator:2.5
workflow-api:2.26
workflow-basic-steps:2.6
workflow-cps-global-lib:2.9
workflow-cps:2.47
workflow-durable-task-step:2.19
workflow-job:2.18
workflow-multibranch:2.17
workflow-scm-step:2.6
workflow-step-api:2.14
workflow-support:2.18
ws-cleanup:0.34
