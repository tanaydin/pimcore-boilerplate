FROM mysql:8.0

ARG user
ARG uid
ARG gid

RUN groupadd -g $gid
RUN useradd --create-home $user -u $uid -g $gid
RUN usermod -aG $user "mysql"

COPY "*.cnf" "/etc/mysql/conf.d/"
COPY "*.sql" "/docker-entrypoint-initdb.d/"
