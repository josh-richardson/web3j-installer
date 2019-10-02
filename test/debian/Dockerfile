FROM debian

RUN apt-get update && apt-get install -y \
      unzip \
      wget \
      default-jre \
      curl

COPY test/test_web3j.sh /
COPY web3j.sh /
RUN chmod +x /test_web3j.sh
RUN chmod +x /web3j.sh

ENTRYPOINT /bin/bash /test_web3j.sh