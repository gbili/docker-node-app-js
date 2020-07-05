# docker-node-app

To build the image you have to pass `ID_RSA_PUB` argument. One way of creating such an argument is to pass it as a variable to your build command:

```bash
# create the variable from a file
cd my-node-app
mkdir .ssh
cp ~/.ssh/id_rsa.pub .ssh/

# pass it to docker build command
sudo docker build --build-arg ID_RSA_PUB=$RSAPUB --build-arg LOCAL_USER=g --build-arg VIRTUAL_HOST=crystalball.at .
```

Let's say you have created an image from this docker file, named `gbili/node-blog`, then if you want to run a container created with this image in an external network, like for example `nginx-proxy`, you can:

```bash
sudo docker run -itd --network=nginx-proxy gbili/node-blog
```
