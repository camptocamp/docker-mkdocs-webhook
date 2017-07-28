#!/bin/sh

sed -i "s/%{HOOKS_SECRET}/${HOOKS_SECRET}/g" /etc/webhook/*.json
