# GPS-Server_Docker
GPS-Server_Docker using GPS for building up ntp server.


# Quick Start

Install docker-ce, example given on Debian.

```
[tcjj3@debian]$ sudo apt install -y curl
[tcjj3@debian]$ curl -fsSL get.docker.com -o get-docker.sh
[tcjj3@debian]$ sudo sh get-docker.sh
[tcjj3@debian]$ sudo groupadd docker
[tcjj3@debian]$ sudo usermod -aG docker $USER
[tcjj3@debian]$ sudo systemctl enable docker && sudo systemctl start docker
```

Run GPS-Server_Docker.

```
docker run -d -i -t \
 --privileged \
 --restart always \
 --name=GPS_Server \
 --device /dev \
 -v /dev:/dev \
 -e DEVICE=/dev/ttyUSB0 \
 -p 2947:2947 \
 -p 123:123/udp \
 tcjj3/gps-server_docker:latest
```

or

```
docker run -d -i -t \
 --privileged \
 --restart always \
 --name=GPS_Server \
 --device /dev \
 -v /dev:/dev \
 -e DEVICE=/dev/ttyUSB0 \
 -p 2947:2947 \
 -p 123:123/udp \
 -v /var/run:/var/run \
 tcjj3/gps-server_docker:latest
```

In these case, "**`/dev/ttyUSB0`**" is your device mount point. If you not sure your device mount point, please remove the "**`DEVICE`**" environment variable.
<br>
<br>
The port **`2947`** is using by **`gpsd`**, and the port **`123`** is using by **`ntpd`**.
<br>
If you use `ntpdate xx.xx.xx.xx` and it shows "**`the NTP socket is in use, exiting`**", just modify the port **`123`** which is using by **`ntpd`** to a free port such as  **`124`**. Like this:

```
docker run -d -i -t \
 --privileged \
 --restart always \
 --name=GPS_Server \
 --device /dev \
 -v /dev:/dev \
 -e DEVICE=/dev/ttyUSB0 \
 -p 2947:2947 \
 -p 124:123/udp \
 tcjj3/gps-server_docker:latest
```
