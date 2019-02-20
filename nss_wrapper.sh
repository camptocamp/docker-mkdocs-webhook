#!/bin/bash

if ! getent passwd "$(id -u)" &> /dev/null && [ -e /usr/lib/libnss_wrapper.so ]; then
	export LD_PRELOAD='/usr/lib/libnss_wrapper.so'
	export NSS_WRAPPER_PASSWD="$(mktemp)"
	export NSS_WRAPPER_GROUP="$(mktemp)"
	echo "webhook:x:$(id -u):$(id -g):webhook:/:/bin/false" > "$NSS_WRAPPER_PASSWD"
	echo "webhook:x:$(id -g):" > "$NSS_WRAPPER_GROUP"
fi

exec "$@"
