# Build lakeFS
FROM alpine:3.18

#install wget
RUN apk add -U --no-cache ca-certificates netcat-openbsd
RUN apk add wget && apk add curl

# get lastest version of lakeFS
ENV LAKEFS_VERSION=0.108.0

#download binary lakefs
RUN cd /tmp && wget https://github.com/treeverse/lakeFS/releases/download/v${LAKEFS_VERSION}/lakeFS_${LAKEFS_VERSION}_Linux_x86_64.tar.gz && \
    tar xfv lakeFS_${LAKEFS_VERSION}_Linux_x86_64.tar.gz && \
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

