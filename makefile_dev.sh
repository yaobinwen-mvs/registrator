#!/bin/sh

# NOTE(ywen): I moved the `RUN` commands in `Dockerfile.dev` into this shell
# script because `Dockerfile.dev` used `&&` to chain a long list of commands.
# It case there happens an error, it would be easier to see which command
# causes the error when the commands are run separately.

set -ex

apk --no-cache add -t build-deps build-base go git curl
apk --no-cache add ca-certificates

export GOPATH=/go && mkdir -p /go/bin && export PATH=$PATH:/go/bin

curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

cd /go/src/github.com/gliderlabs/registrator

export GOPATH=/go
git config --global http.https://gopkg.in.followRedirects true

dep ensure
go build -ldflags "-X main.Version=dev" -o /bin/registrator
