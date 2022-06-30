FROM ubuntu:20.04
LABEL maintainer="sunboy_zgz"
LABEL homepage="https://github.com/sunboyZgz"
LABEL version="1.0" \
      description="a env for lab of nanjing university"
ARG DEBIAN_FRONTEND=noninteractive
RUN set -x\
    && apt update\
    && apt install -y build-essential gcc make perl dkms git gcc-riscv64-unknown-elf gdb-multiarch qemu-system-misc

RUN cd $HOME && git clone https://github.com/plctlab/riscv-operating-system-mooc

RUN apt update \
    && apt install openssh-server net-tools -y \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo "root:123456" | chpasswd

EXPOSE 22
ENTRYPOINT service ssh restart && bash