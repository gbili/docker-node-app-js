# node app js

This is meant to run a node server container. Relies on an external volume.

It can be used in conjunction with `git-server-hooks` where both share the volume `node-apps`.

## Build

You can already specify `package.json`'s parent dirname with: `APP_DIRNAME` arg.

**IMPORTANT**: It is paramount that you specify the correct group id `GID` corresponding to the one who has read/write/execute rights on the shared volume `node-apps`. To figure out what the `GID` is, simply do:

```sh
docker volume inspect git-server-hooks_node-apps
# copy paste the directory for example:
sudo ls -la /var/lib/docker/volumes/git-server-hooks_node-apps/_data/<appdir>
# will output
# total 128
# drwxrws---   6 ubuntu 1002  4096 Jul  5 16:26 .
# drwxr-xr-x   3 root   root  4096 Jul  5 13:49 ..
# -rw-r--r--   1   1001 1002    26 Jul  5 16:26 .dockerignore
# -rw-r--r--   1   1001 1002  1547 Jul  5 16:26 .gitignore
# -rw-r--r--   1   1001 1002  1559 Jul  5 16:26 Dockerfile
# drwxrws---   2 ubuntu 1002  4096 Jul  5 16:26 content
# drwxrws--- 201 ubuntu 1002 12288 Jul  5 16:26 node_modules
# -rw-r--r--   1   1001 1002 78803 Jul  5 16:26 package-lock.json
# -rw-r--r--   1   1001 1002   779 Jul  5 16:26 package.json
# drwxrws---   3 ubuntu 1002  4096 Jul  5 14:25 static
# drwxrws---   2 ubuntu 1002  4096 Jul  5 16:26 views
```

Take note of the GID in the 4th column (here `1002`) and pass it as a build parameter: `COMMON_GROUP_GID`

```sh
sudo docker build --build-arg COMMON_GROUP_GID=1002 -t docker.zivili.ch/gbili/node-app-js:0.0.1 .
```

## Installation

You only require access to the image from your docker installation. If you are using `docker-compose` thigs get easier, since you can reuse `docker-compse.yml` by changing the `envorinoment:` section:

- `APP_DIRNAME`: name of `package.json`'s parent dir.
- `VIRTUAL_HOST`: depends on `nginx-proxy`: `example.com` of where you want to server your app.
- `LETSENCRYPT_HOST`: depends on let's encrypt certbot: `example.com` of where you want to get ssl.
- `LETSENCRYPT_EMAIL`: depends on let's encrypt certbot: `mail@example.com`

So make sure to join the `nginx-proxy` external network

Then you need to carefully specify the external volume name created by `git-server-hooks`, usually: `git-server-hooks_node-apps`.

## Resetting

```sh
# login to docker remote host
ssh ubuntu@...

# assuming you correctly installed dotfiles
flush-start -d blog

cd $ws/blog
docker-compose up -d

exit

# from local blog
git push live
```
