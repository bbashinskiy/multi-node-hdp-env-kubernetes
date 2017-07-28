FROM centos:centos6
MAINTAINER generydey@gmai.com
ENV TZ=Europe/Warsaw
ENV KUBECONFIG=/.kube/kube-config-prod-dal10-allianz_test.yml

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install wget openssh-clients unzip ntp python-setuptools && \
    wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.5.0.3/ambari.repo -O /etc/yum.repos.d/ambari.repo && \
    yum -y --setopt=tsflags=nodocs install ambari-server && \
    yum clean all

RUN wget -nv http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u112-linux-x64.tar.gz -P /var/lib/ambari-server/resources/ && \
    mkdir -p /usr/jdk64/ && chmod a+x /usr/jdk64/ && \
    tar --no-same-owner -xf /var/lib/ambari-server/resources/jdk-8u112-linux-x64.tar.gz -C /usr/jdk64/ && \
    wget -nv http://public-repo-1.hortonworks.com/ARTIFACTS/jce_policy-8.zip -P /var/lib/ambari-server/resources/ && \
    unzip /var/lib/ambari-server/resources/jce_policy-8.zip -d /usr/jdk64/jdk1.8.0_112/jre/lib/security/

RUN easy_install supervisor && mkdir /var/log/supervisor 

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

RUN ambari-server setup -s -j /usr/jdk64/jdk1.8.0_112/

ADD ./configs/supervisord.conf /etc/supervisord.conf
COPY ./configs/supervisord.d /etc/supervisord.d
COPY ./configs/credentials /.kube
COPY ./configs/templates /var/lib/ambari-server/resources/templates
COPY ./scripts /scripts

EXPOSE 8080 8440 8441

CMD ["supervisord"]
