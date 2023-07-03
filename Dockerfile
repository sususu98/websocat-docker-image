# 第一阶段：构建阶段
FROM curlimages/curl AS builder

ARG TARGETPLATFORM

# 根据目标架构下载对应的二进制文件
RUN case "$TARGETPLATFORM" in \
    "linux/arm64") \
    curl -L https://github.com/vi/websocat/releases/download/v1.11.0/websocat.aarch64-unknown-linux-musl -o /tmp/websocat ;; \
    "linux/amd64") \
    curl -L https://github.com/vi/websocat/releases/download/v1.11.0/websocat.x86_64-unknown-linux-musl -o /tmp/websocat ;; \
    esac && \
    chmod +x /tmp/websocat && \
    /tmp/websocat --version

# 第二阶段：最终镜像
FROM alpine:3.15

WORKDIR /
# 复制第一阶段构建好的二进制文件到最终容器中
COPY --from=builder /tmp/websocat /usr/local/bin/websocat

ENTRYPOINT ["/usr/local/bin/websocat"]
