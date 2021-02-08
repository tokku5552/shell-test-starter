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

# # config sshd
# RUN yum install -y openssh-server && yum clean all
# # enable sshd
# RUN systemctl enable sshd
# RUN mkdir /var/run/sshd
# # change root password
# RUN echo 'root:rootpassword' | chpasswd
# # enable permit root login
# RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
# # RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
# RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key
# # sshポート変更
# RUN sed -i 's/#Port 22/Port 20022/' /etc/ssh/sshd_config

# EXPOSE 20022
# # EXPOSE 22
# CMD ["/usr/sbin/sshd", "-D"]