FROM php:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y git

RUN cd /tmp/ && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

WORKDIR /srv/

RUN composer create-project certificationy/certificationy-cli

WORKDIR /srv/certificationy-cli/

ENTRYPOINT ["docker-php-entrypoint", "php", "certificationy.php", "start"]

CMD ["--number=20"]
