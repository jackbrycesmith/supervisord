FROM golang:alpine AS builder

RUN apk add --no-cache --update git gcc rust musl-dev

COPY . /src
WORKDIR /src

RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o /usr/local/bin/supervisord github.com/ochinchina/supervisord

FROM scratch

COPY --from=builder /usr/local/bin/supervisord /usr/local/bin/supervisord

ENTRYPOINT ["/usr/local/bin/supervisord"]