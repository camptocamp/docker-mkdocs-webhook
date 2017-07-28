#!/bin/sh

cd /var/lib/git/doc

if ! git config remote.origin.url &> /dev/null; then
  git remote add origin $1
fi
git fetch
git checkout -f master
git pull

make build
