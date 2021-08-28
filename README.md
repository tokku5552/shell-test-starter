# shell-test-starter

書くこと

- Linux でしかつかえない

# Sample

# Requires

# Command Tips

## start continer

### simply

```
docker-compose up
docker-compose run c_dev_env /bin/bash
```

### when connecting to a started container

```
docker exec -it "$(docker ps -qf "name=c_dev_env")" /bin/bash
```

## stop continer

- simply

```
docker-compose down
```

- when you want to completely erase the image

```
docker-compose down --rmi all
```

# License

Copyright (c) 2021 tokku5552  
This software is released under the MIT License.  
https://opensource.org/licenses/mit-license.php
