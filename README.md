# What is this?
This is a Dockerfile + docker-compose.yml which builds Apache + Flask environment.

# How to run Container
  *  build container
``` bash
$ docker-compose build
```
  * run container
``` bash
$ docker-compose up -d 
```
  * confirm 
``` bash
$ curl http://localhost:8080/
Hello, Flask!
```

# Related page（Japanese）
https://qiita.com/haruka_lbr/items/2132d7ff337267fb39bf
