FROM cmp1234/nginx-python:1.10.3-python2.7.13-alpine3.6

MAINTAINER Wang Lilong "wanglilong007@gmail.com"

ENV VERSION=6.0.0

RUN set -x \  
    && apk add --no-cache --virtual .build-deps \
		coreutils \
		curl \
		gcc \
		linux-headers \
		make \
		musl-dev \
        libffi-dev \
	python2 \
        python2-dev \
        mysql-client \
	#py-mysqldb \
	mariadb-dev \
		zlib \
		zlib-dev \
		libxml2-dev \
		libxml2 \
		libxslt-dev \
		libxslt \
    #&& apk add --no-cache --virtual .run-deps py-mysqldb \
    && curl -fSL https://github.com/openstack/ceilometer/archive/${VERSION}.tar.gz -o ceilometer-${VERSION}.tar.gz \
    && tar xvf ceilometer-${VERSION}.tar.gz \
    && cd ceilometer-${VERSION} \
    && pip install -r requirements.txt \
    && PBR_VERSION=${VERSION}  pip install . \
    && pip install  PyMySQL==0.7.4 \
    && cp -rf etc/* /etc/ \
    && pip install python-openstackclient==3.12.0 \
    && cd - \
    && rm -rf ceilometer-${VERSION}* \
    && apk del .build-deps
