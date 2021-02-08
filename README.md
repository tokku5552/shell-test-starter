# shell-test-starter

### when build

> docker build -t c_dev_centos7 .

### when connect

> docker run -it --name "c_dev_env" --cap-add=SYS_PTRACE --security-opt="seccomp=unconfined" c_dev_centos7 /bin/bash
