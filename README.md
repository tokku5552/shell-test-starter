# shell-test-starter

書くこと

- Linux でしかつかえない

# Command Tips

## start continer

```
docker-compose up
docker-compose run c_dev_env /bin/bash
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
