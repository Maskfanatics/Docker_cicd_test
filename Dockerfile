##
## Build
##

FROM golang:1.16-buster AS build

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go env -w  GOPROXY=https://goproxy.cn,direct
RUN go mod download

COPY *.go ./

RUN go build -o /docker-gs-ping-roach

##
## Deploy
##

FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY --from=build /docker-gs-ping-roach /docker-gs-ping-roach

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/docker-gs-ping-roach"]
