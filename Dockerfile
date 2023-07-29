# Build lakeFS
FROM alpine:3.18

#install wget
RUN apk add -U --no-cache ca-certificates netcat-openbsd
RUN apk add wget && apk add curl

#download binary lakefs
RUN cd /tmp && wget https://github.com/treeverse/lakeFS/releases/download/v0.104.0/lakeFS_0.104.0_Linux_x86_64.tar.gz && \
    tar xfv lakeFS_0.104.0_Linux_x86_64.tar.gz && \
    mv lakefs /bin/lakefs && \
    mv lakectl /bin/lakectl && cd && \
    rm -rf * /tmp/* \

#setup env
ENV ACCESS_KEY $ACCESS_KEY
ENV SECRET_ACCESS_KEY $SECRET_ACCESS_KEY
ENV REPOSITORY $REPOSITORY

WORKDIR /app

COPY scripts/* ./
COPY conf/* ./

EXPOSE 8000/tcp

RUN addgroup -S lakefs && adduser -S lakefs -G lakefs
USER lakefs
WORKDIR /home/lakefs

ENTRYPOINT ["sh", "/app/entrypoint.sh"]

