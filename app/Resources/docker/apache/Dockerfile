FROM httpd:2.4

ARG user
ARG uid
ARG gid

RUN groupadd -g $gid
RUN useradd --create-home $user -u $uid -g $gid
RUN usermod -aG $user "www-data"

COPY "./apache.conf" "/usr/local/apache2/conf/"
RUN echo "Include /usr/local/apache2/conf/apache.conf" >> "/usr/local/apache2/conf/httpd.conf"
