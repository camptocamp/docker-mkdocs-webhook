#!/bin/bash -x

REF="$1"
REMOTE="$2"

cd /var/lib/git/doc

if [ ! -f .git ]; then
	/nss_wrapper.sh git init
fi

if ! git config remote.origin.url &> /dev/null; then
  /nss_wrapper.sh git remote add origin $2
fi
/nss_wrapper.sh git fetch
branch=$(cut -d/ -f3 <<<"${REF}")
/nss_wrapper.sh git checkout -f $branch
/nss_wrapper.sh git pull

if [ -n "${GIT_SUBDIR}" ]; then
    cd ${GIT_SUBDIR} && make build
else
    make build
fi
