FROM fedora

RUN yum -y update && yum clean all
RUN yum -y install unzip wget java which && yum clean all
RUN yum -y install curl && yum clean all

COPY test/test_web3j.sh /
COPY web3j.sh /
RUN chmod +x /test_web3j.sh
RUN chmod +x /web3j.sh

ENTRYPOINT /test_web3j.sh