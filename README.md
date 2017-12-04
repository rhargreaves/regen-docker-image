# Regen/GTK+ 0.95

## macOS

* Install XQuartz

```
$ IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
$ docker run -e DISPLAY=$IP:0 -it rhargreaves/regen
```

## Linux

```
$ docker run -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it rhargreaves/regen
```
