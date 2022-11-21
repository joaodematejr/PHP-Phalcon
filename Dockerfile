FROM webdevops/php-nginx:8.1

ARG PHALCON_VERSION=5.1.1

RUN set -xe && \
    docker-php-source extract && \
    # Install ext-phalcon
    curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && \
    tar xzf /v${PHALCON_VERSION}.tar.gz && \
    docker-php-ext-install -j $(getconf _NPROCESSORS_ONLN) \
    /cphalcon-${PHALCON_VERSION}/build/phalcon \
    && \
    # Remove all temp files
    rm -r \
    /v${PHALCON_VERSION}.tar.gz \
    /cphalcon-${PHALCON_VERSION} \
    && \
    docker-php-source delete && \
    php -m

#ENV WEB_DOCUMENT_ROOT=/var/www/html/app/public

ENV WEB_DOCUMENT_ROOT=/app

#RUN docker-php-ext-install mysqli
#RUN docker-php-ext-install pdo pdo_mysql
#RUN docker-php-ext-install pdo pdo_mysql && docker-php-ext-enable pdo_mysql