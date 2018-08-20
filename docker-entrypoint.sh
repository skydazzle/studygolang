#!/usr/bin/env bash

# TODO run the install cmd
set -x
CURDIR=`pwd`
OLDGOPATH="$GOPATH"
export GOPATH="$GOPATH:$CURDIR"

if [ ! -d log ]; then
        mkdir log
fi

gofmt -w -s src

BUILD="`git symbolic-ref HEAD | cut -b 12-`-`git rev-parse HEAD`"

go install -ldflags "-X global.Build="$BUILD server/studygolang
go install server/indexer
go install server/crawler

export GOPATH="$OLDGOPATH"
# TODO run binary
./start.sh
sleep infinity
set +x
