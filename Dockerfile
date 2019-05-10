FROM debian:stretch

EXPOSE 9000

ENV RELEASE=stretch \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    WEBHOOK_VERSION=2.6.9 \
    SITEDIR="/doc"

RUN apt-get update \
    && apt-get install -y make python2.7 git virtualenv \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/git/doc && git -C /var/lib/git/doc init

# virtualenv insists on using python2
RUN ln -sf /usr/bin/python2.7 /usr/bin/python2

COPY build-doc.yaml.tmpl /etc/webhook/build-doc.yaml.tmpl
COPY build-doc.sh /build-doc.sh

# Install webhook
RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/adnanh/webhook/releases/download/${WEBHOOK_VERSION}/webhook-linux-amd64.tar.gz \
    && tar xzf webhook-linux-amd64.tar.gz \
    && mv webhook-linux-amd64/webhook /usr/local/bin/webhook \
    && rm -f webhook-linux-amd64.tar.gz \
    && apt-get remove -y --purge wget \
    && apt-get clean

# install nss_wrapper in case we need to fake /etc/passwd and /etc/group (i.e. for OpenShift)
RUN apt-get update && \
    apt-get install -y --no-install-recommends libnss-wrapper && \
	rm -rf /var/lib/apt/lists/*

COPY nss_wrapper.sh /
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY /docker-entrypoint.d/* /docker-entrypoint.d/

VOLUME ["/doc", "/var/lib/git/doc"]

ENTRYPOINT ["/docker-entrypoint.sh", "/usr/local/bin/webhook"]
CMD ["-hooks", "/etc/webhook/build-doc.yaml.tmpl", "-template", "-verbose"]
