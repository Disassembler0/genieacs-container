FROM node:22

COPY mongodb.sources /etc/apt/sources.list.d/mongodb.sources

RUN apt-get update -y && \
    apt-get install -y mongodb-org-server supervisor && \
    apt-get clean && \
    ln -s /usr/bin/true /usr/bin/ping

RUN npm install -g genieacs

RUN useradd --system --no-create-home --user-group genieacs && \
    mkdir /etc/genieacs /var/log/genieacs && \
    ln -s /etc/genieacs /usr/local/lib/node_modules/genieacs/config

COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /etc/genieacs /var/lib/mongodb

EXPOSE 3000 7547 7557 7567

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
