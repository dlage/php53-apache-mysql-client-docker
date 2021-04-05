FROM ubuntu:focal

RUN apt-get update \
    && apt-get -y dist-upgrade \
    && apt-get install -y locales software-properties-common bash-completion \
    && apt-get install -y apache2 curl
RUN add-apt-repository -y ppa:sergey-dryabzhinsky/php53 \
    && add-apt-repository -y ppa:sergey-dryabzhinsky/packages \
    && apt-get update \
    && apt-get install -y php53-mod-mbstring php53-mod-gd php53-mod-curl php53-mod-dom php53-mod-mcrypt \
        php53-mod-openssl php53-mod-fileinfo php53-mod-mcrypt php53-mod-phar libapache2-mod-php53 php53-mod-bcmath \
        php53-mod-calendar php53-mod-exif php53-mod-json \
    && apt-get install -y php5-mysql

#RUN mv /etc/apache2/apache2.conf /etc/apache2/apache2.conf.dist
#COPY apache2.conf /etc/apache2/apache2.conf
RUN apt-get update && apt-get -y install vim less locate
COPY apache2-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# Enable apache2 required modules
RUN apt-get update && apt-get install -y libapache2-mod-php53 php53-mod-bcmath libmysqlclient18 php53-mod-calendar php53-mod-exif php53-mod-json php5-mysql
RUN a2dismod mpm_event && a2enmod rewrite ssl mpm_prefork php53


RUN rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]
