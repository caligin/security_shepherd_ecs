FROM ubuntu:14.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN adduser --disabled-password --gecos "" bastion
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin no/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

COPY authorized_keys /home/bastion/.ssh/authorized_keys
RUN chown -R bastion. /home/bastion/.ssh
RUN chmod 660 /home/bastion/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
