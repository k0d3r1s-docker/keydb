#!/bin/sh

# rm -rf ./source/
# git clone https://github.com/keydb/keydb.git source

cd ./source || exit
git reset --hard
git pull
VERSION=`git rev-parse --short HEAD`

cd .. || exit

docker build --tag k0d3r1s/keydb:${VERSION} --tag k0d3r1s/keydb:unstable --squash --compress --no-cache -f Dockerfile.unstable  --build-arg version=${VERSION} . || exit

old=`cat latest`
hub-tool tag rm k0d3r1s/keydb:$old -f
echo -n $VERSION > latest

docker push k0d3r1s/keydb:${VERSION}
docker push k0d3r1s/keydb:unstable