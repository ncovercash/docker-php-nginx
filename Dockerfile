FROM trafex/php-nginx:3.5.0 AS base

  USER root

  # clean slate
  RUN rm /var/www/html/*

  # for healthcheck
  RUN apk add --no-cache curl

  COPY conf/status.conf /etc/nginx/conf.d/status.conf
  COPY healthcheck.sh /healthcheck.sh
  RUN chmod +x /healthcheck.sh

  # support cron
  RUN apk add --no-cache dcron libcap
  
  RUN chown nobody:nobody /usr/sbin/crond \
    && setcap cap_setgid=ep /usr/sbin/crond

  RUN echo -e "\n[program:crond]\ncommand=/usr/sbin/crond -f -L /dev/stdout\nstdout_logfile=/dev/stdout\nstdout_logfile_maxbytes=0\nstderr_logfile=/dev/stderr\nstderr_logfile_maxbytes=0" >> /etc/supervisor/conf.d/supervisord.conf

  USER nobody

  HEALTHCHECK --timeout=1s --interval=10s --retries=0 --start-period=30s CMD /healthcheck.sh
