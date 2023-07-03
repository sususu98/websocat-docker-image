FROM curlimages/curl AS builder

ARG TARGETPLATFORM

# 根据目标架构下载对应的二进制文件
RUN if [ "$TARGETPLATFORM" == "linux/arm64" ]; then \
    echo "$TARGETPLATFORM"&& \
    curl -L https://github.com/vi/websocat/releases/download/v1.10.0/websocat.aarch64-unknown-linux-musl -o /tmp/websocat; \
    elif [ "$TARGETPLATFORM" == "linux/amd64" ]; then \
    echo "$TARGETPLATFORM"&& \
    curl -L https://github.com/vi/websocat/releases/download/v1.10.0/websocat.x86_64-unknown-linux-musl -o /tmp/websocat; \
    fi && \
    chmod +x /tmp/websocat

# 创建目标容器镜像
FROM alpine:3.15

WORKDIR /
# 复制第一阶段构建好的二进制文件到最终容器中
COPY --from=builder /tmp/websocat /usr/local/bin/websocat

ENTRYPOINT ["/usr/local/bin/websocat"]
