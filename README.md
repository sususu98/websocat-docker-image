# websocat-docker-image

websocat docker image for x86_64 and arm64

## 构建命令

```sh
docker buildx build --platform linux/amd64,linux/arm64 -t ${username}/websocat:${tag} . --push
```