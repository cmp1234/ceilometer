FROM cmp1234/docker-nginx:1.10.3-python2.7.13-alpine3.6

MAINTAINER Wang Lilong "wanglilong007@gmail.com"

ENV VERSION=6.0.0

		#openssl \
		#openssl-dev \
#&& apk add --no-cache libffi-dev python-dev libssl-dev mysql-client python-mysqldb \

RUN set -x \  
    && apk add --no-cache --virtual .build-deps \
		coreutils \
		gcc \
		linux-headers \
		make \
		musl-dev \
        libffi-dev \
        python-dev \
        mysql-client \
	py-mysqldb \
	mariadb-dev \
		zlib \
		zlib-dev \
		libxml2-dev \
		libxml2 \
		libxslt-dev \
		libxslt \
    && curl -fSL https://github.com/openstack/ceilometer/archive/${VERSION}.tar.gz -o ceilometer-${VERSION}.tar.gz \
    && tar xvf ceilometer-${VERSION}.tar.gz \
    && cd ceilometer-${VERSION} \
    && pip install -r requirements.txt \
    && PBR_VERSION=${VERSION}  pip install . \
    && pip install uwsgi MySQL-python \
    && cp -r etc /etc/keystone \
    && pip install python-openstackclient \
    && cd - \
    && rm -rf ceilometer-${VERSION}* \
    && apk del .build-deps
