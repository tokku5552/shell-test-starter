FROM centos:7

WORKDIR /workdir

# system update
RUN yum -y update && yum clean all
RUN yum -y update && \
    yum -y groupinstall "Development Tools"

# set locale
RUN yum reinstall -y glibc-common && yum clean all
ENV LANG ja_JP.UTF-8

# editor install
RUN yum install -y vim && yum clean all
