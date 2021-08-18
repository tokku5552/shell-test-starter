# shell-test-starter

### when connect

- コンテナを起動するとき

```
docker-compose up
docker-compose run c_dev_env /bin/bash

```

- コンテナを停止するとき

```
docker-compose down
docker-compose down --rmi all
```

### when restart

> docker start c_dev_env
> docker attach c_dev_env
