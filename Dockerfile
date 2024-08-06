FROM prestashop/prestashop:latest

EXPOSE 443

RUN apt update && apt-get install net-tools

RUN a2enmod ssl

RUN a2enmod headers

RUN a2ensite default-ssl

COPY ./conf/apache2.conf /etc/apache2/apache2.conf
COPY ./conf/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
COPY ./conf/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key
COPY ./conf/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

RUN apache2ctl configtest

RUN service apache2 restart

