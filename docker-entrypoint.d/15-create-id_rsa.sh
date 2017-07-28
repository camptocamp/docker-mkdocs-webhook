#!/bin/bash

if test -n "${SSH_PRIVATE_KEY}"; then
  mkdir -p ~/.ssh
  echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
  chmod 0600 ~/.ssh/id_rsa
fi
