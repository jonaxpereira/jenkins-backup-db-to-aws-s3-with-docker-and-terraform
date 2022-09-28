FROM centos:7

# https://phoenixnap.com/kb/how-to-enable-ssh-centos-7
RUN yum install openssh-server -y

RUN /usr/sbin/sshd-keygen > /dev/null 2>&1

CMD /usr/sbin/sshd -D