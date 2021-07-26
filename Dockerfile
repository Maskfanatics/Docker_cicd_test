# syntax=docker/dockerfile:1
FROM busybox:latest
COPY --chmod=755 <<EOF /app/run.sh
#!/bin/sh
while true; do
  echo -ne "The time is now $(date +%T)\\r"
  sleep 1
done
EOF

<<<<<<< HEAD
ENTRYPOINT /app/run.sh
=======
FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o /docker-gs-ping-roach

##
## Deploy
##

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /docker-gs-ping-roach /docker-gs-ping-roach

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-gs-ping-roach"]
>>>>>>> 99f067a (Fix trailing slash issue in Dockerfile COPY)
