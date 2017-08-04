# MkDocs Webhook

Webhook docker image to build documentation using *mkdocs*. The documentation is built into
the configurable folder which can be served directly by a httpd server. The webhook is
typically triggered when a push occurs on the documentation git repository.


# Configure the image

The following environment variables allow to configure the image.

- SITEDIR : The destination folder where is put the built documentation.
- HOOKS_SECRET : The secret of the webhook.
- GIT_SUBDIR : An optional sub-directory in the git repository where to find the documentation.
- SSH_PRIVATE_KEY : An optional ssh private key for fetching the documentation source from a git repository.

The git repository to fetch the documentation from is given into the payload of the POST
triggered by the webhook.
