---
layout: post
title:  "Заметки про Docker"
date:   2022-05-25 18:00:00 +0300
categories: open info
---

TIP: For exiting without stopping the container type: ^P^Q

[Шпаргалка с коммандами Docker](https://habr.com/ru/company/flant/blog/336654/)

### Команды
``` text
docker run
       start  Start one or more stopped containers
       stop   send SIGTERM, and then SIGKILL after grace period (10s)
       kill   send SIGKILL, or specified signal
          -s, --signal string   Signal to send to the container (default "KILL")
attach     context    export     info       logs       port       rm         service    system     version
build      cp         help       inspect    manifest   ps         rmi        stack      tag        volume
builder    create     history    kill       network    pull       run        start      top        wait
commit     diff       image      load       node       push       save       stats      trust
config     events     images     login      pause      rename     search     stop       unpause
container  exec       import     logout     plugin     restart    secret     swarm      update

docker pull scottyhardy/docker-remote-desktop
docker search curl
docker run --network ipvnet -i -t debian
docker attach CONTAINER_NAME
docker image COMMAND
docker images
docker exec -i -t 17b633d75ebe /bin/bash
docker container rm 1db3cc116d2b 28d966da0468
```

### Запуск
``` text
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
-a, --attach list       Attach to STDIN, STDOUT or STDERR 
-d, --detach
-e, --env list          Set environment variables
-h, --hostname string   Container host name
    --init              Run an init inside the container that forwards signals and reaps processes
-i, --interactive       Keep STDIN open even if not attached
-l, --label list        Set meta data on a container
-m, --memory bytes      Memory limit
-p, --publish list      Publish a container's port(s) to the host
-t, --tty                            Allocate a pseudo-TTY
-u, --user string                    Username or UID (format: <name|uid>[:<group|gid>])
-v, --volume list                    Bind mount a volume
    --volume-driver string           Optional volume driver for the container
    --volumes-from list              Mount volumes from the specified container(s)
-w, --workdir string                 Working directory inside the container

```

### Информация по контейнерам
``` text
docker ps -as 
```

Удалить остановленные контейнеры:

	docker rm $(docker ps -a -q -f status=exited)
	
### Сохранение состояния	
``` text
docker export container_name > image.tar 
       import 
docker save container_name1 container_name2 > save.tar
       load 
```

- save – для сохранения нескольких images в один файл с сохранением истории слоёв
- export – создаёт копию контейнера, объединяя слои.

`docker commit --change='CMD ["apachectl", "-DFOREGROUND"]' -c "EXPOSE 80" c3f279d17e0a  svendowideit/testimage:version4`
	
- Commit a container with new configurations, CMD and EXPOSE instructions.
- By default, the container being committed and its processes will be paused while the image is committed.
	
`docker commit cd8cc357e1c3 centos_with_vim`

- Сохраняет состояние контейнера cd8cc357e1c3 под именем centos_with_vim 

### Добавление бриджа host-shared bridge

Командами:
``` text
ip a flush enp0s3
brctl addbr br0
brctl addif br0 enp0s3:
ip link set br0 address 00:0a:e7:2c:44:2a
dhclient br0
```

С назначением бриджу MAC сетевой карты /etc/network/interfaces:
``` text
auto mylxcbr0
iface mylxcbr0 inet dhcp
bridge_ports enp0s3
bridge_hw enp0s3
#bridge_stp off
bridge_fd 0
bridge_maxwait 0
post-up ethtool -s enp0s3 wol g
```

``` text
docker network create -d ipvlan --subnet=192.168.78.0/25 --gateway=192.168.78.1 -o parent=br0 ipvnet
docker network connect YOUR_NETWORK YOUR_CONTAINER
               disconnect
docker run --network ipvnet IMAGE
```

### Информация об объектах:
``` text
docker inspect 
       info

docker inspect --format '{% raw %}{{ .NetworkSettings.IPAddress }}{% endraw %}' $(docker ps -q)
```

Overlay FS
``` text
mount -t overlay -o \
lowerdir=/var/lib/docker/overlay2/d9a49b141c9e642fba6244d1308f50fe312bbf1ef99e0a2dc5355fdcb2106ea6-init/diff:/var/lib/docker/overlay2/ddf6dd3b47961cfd8df08072c787c7789ee890ce71fb44e69636149c09121a05/diff:/var/lib/docker/overlay2/4ab159950c8f83ee207f05f292c86662b385e333c5567435618a93a6c580a03a/diff,\
upperdir=/var/lib/docker/overlay2/d9a49b141c9e642fba6244d1308f50fe312bbf1ef99e0a2dc5355fdcb2106ea6/diff,\
workdir=/var/lib/docker/overlay2/d9a49b141c9e642fba6244d1308f50fe312bbf1ef99e0a2dc5355fdcb2106ea6/work \
overlay /mnt/merged
```

Если ты хочешь ручками что-то править в системе и работать с контейнером как с отдельным компьютером, то тебе нужно смотреть не на Docker, а на LXC. [KRoN73](https://www.linux.org.ru/forum/admin/12631072?cid=12631252)  

x2go  
PULSE_SERVER=tcp:localhost:4713; export PULSE_SERVER

[Полное практическое руководство по Docker: с нуля до кластера на AWS](https://habr.com/ru/post/310460/)

[Docker save/export](https://rtfm.co.ua/docker-chast-2-upravlenie-kontejnerami/)

<https://docs.docker.com>

<https://hub.docker.com/>