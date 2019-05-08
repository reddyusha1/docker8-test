FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get clean && apt-get update && apt-get upgrade -y
#RUN apt-get update \
    #&& DEBIAN_FRONTEND=noninteractive apt-get -y 

RUN apt-get install apache2 -y
COPY apache2-config.conf /etc/apache2/sites-enabled/000-default.conf


RUN apt-get install php -y 

RUN apt-get install libapache2-mod-php  -y
RUN rm /var/www/html/index.html

#RUN apt-get install git php7.0 php7.0-curl php7.0-dom php7.0-gd php7.0-mbstring php7.0-sqlite3 -y
#RUN apt-get install php5.6-gd -y
RUN apt-get update -y && \
    apt-get install -y \
    mysql-client \
    php7.2-dev \
    php7.2  \
    php7.2-cli \
    php7.2-fpm \
    php7.2-common \
    php7.2-curl \
    php7.2-gd \
    php7.2-memcached \
    php7.2-xdebug \
    php-pear \
    php7.2-json \
    php7.2-mbstring \
    php7.2-intl \
    php7.2-mysql \
    php7.2-xml \
    php7.2-zip \
    php7.2-apcu \
    php7.2-ctype \
    php7.2-dom \
    php7.2-iconv \
    php7.2-imagick \
    php7.2-json \
    php7.2-intl \
    php7.2-opcache \
    php7.2-pdo \
    php7.2-mysqli \
    php7.2-xml  \
    php7.2-tokenizer \
    php7.2-zip \
    php7.2-simplexml \
    php7.2-bcmath \
    apache2 \
    #libapache2-mod-fastcgi \
    libapache2-mod-php7.2 \
    rsyslog --force-yes
WORKDIR /var/www/html/
ENV DRUPAL_VERSION 8.3.5
#ENV DRUPAL_MD5 423cc4d28da066d099986ac0844f6abb
RUN apt-get install curl -y
RUN curl -fSL "http://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz \
	#&& echo "$clear{DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - \
	&& tar -xz --strip-components=1 -f drupal.tar.gz \
	&& rm drupal.tar.gz \
	&& chown -R www-data:www-data sites
#COPY drupal-8.3.5  /var/www/html/

#RUN chmod -R 777 sites/default/files/
#RUN chmod a+w drupal/drupal-8.3.5/sites/default/settings.php
#RUN chmod go-w drupal/drupal-8.3.5/sites/default/settings.php
#RUN chmod go-w drupal/drupal-8.3.5/sites/default
#RUN chmod 777 /start.sh
RUN chown -R www-data:www-data /var/www/html/sites/default


EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/apache2ctl"]
