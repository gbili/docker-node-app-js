# node app js

This is meant to run a node server container. Relies on an external volume.

It can be used in conjunction with `git-server-hooks` where both share the volume `node-apps`.

## Build

You can already specify `package.json`'s parent dirname with: `APP_DIRNAME` arg.

## Installation

You only require access to the image from your docker installation. If you are using `docker-compose` thigs get easier, since you can reuse `docker-compse.yml` by changin the `envorinoment:`:

- `APP_DIRNAME`: name of `package.json`'s parent dir.
- `VIRTUAL_HOST`: depends on `nginx-proxy`: `example.com` of where you want to server your app.
- `LETSENCRYPT_HOST`: depends on let's encrypt certbot: `example.com` of where you want to get ssl.
- `LETSENCRYPT_EMAIL`: depends on let's encrypt certbot: `mail@example.com`

So make sure to join the `nginx-proxy` external network

Then you need to carefully specify the external volume name created by `git-server-hooks`, usually: `git-server-hooks_node-apps`.
