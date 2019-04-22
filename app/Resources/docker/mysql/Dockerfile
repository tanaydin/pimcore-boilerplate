FROM mysql:8.0

ARG user
ARG uid
ARG gid

RUN useradd --create-home $user
RUN usermod --uid $uid --gid $gid $user
RUN usermod -aG $user "mysql"

COPY "*.cnf" "/etc/mysql/conf.d/"
COPY "*.sql" "/docker-entrypoint-initdb.d/"