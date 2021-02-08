# shell-test-starter

### when build

> cd docker
> docker build -t c_dev_centos7 .

### when connect

> docker run -it -p 20021:20022 --privileged -v ${PWD}/../src:/workdir --name "c_dev_env" --cap-add=SYS_PTRACE --security-opt="seccomp=unconfined" c_dev_centos7 /bin/bash
> docker run -it --privileged -v ${PWD}/../src:/workdir --name "c_dev_env" --cap-add=SYS_PTRACE --security-opt="seccomp=unconfined" c_dev_centos7 /bin/bash

### when restart

> docker start c_dev_env
> docker attach c_dev_env
