FROM php:fpm
ARG TIMEZONE

RUN apt-get update && apt-get install -y \
    openssl \
    git \
    unzip

# Install Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
#&& composer --version

# Change apt
RUN apt-get clean \
    && cd /var/lib/apt \
    && mv lists lists.old \
    && mkdir -p lists/partial \
    && apt-get clean \
    && echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib \n \
        deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib \n \
        deb http://mirrors.aliyun.com/debian-security buster/updates main \n \
        deb-src http://mirrors.aliyun.com/debian-security buster/updates main \n \
        deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib \n \
        deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib" > /etc/apt/sources.list \
    # update and install libs
    && apt-get update \
    && apt-get install -y openssl unzip \
    # PHP extension
    && docker-php-ext-install -j$(nproc) pdo_mysql pdo_mysql mysqli \
    && docker-php-ext-enable mysqli

# Set timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone \
&& printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/tzone.ini \
&& "date"
