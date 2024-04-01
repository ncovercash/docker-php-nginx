FROM trafex/php-nginx:3.5.0 AS base

  USER root

  # for healthcheck
  RUN apk add --no-cache curl

  COPY conf/status.conf /etc/nginx/conf.d/status.conf
  COPY healthcheck.sh /healthcheck.sh
  RUN chmod +x /healthcheck.sh

  # support cron
  RUN echo -e "[program:crond]\ncommand=crond -f\nstdout_logfile=/dev/stdout\nstdout_logfile_maxbytes=0\nstderr_logfile=/dev/stderr\nstderr_logfile_maxbytes=0" >> /etc/supervisor/conf.d/supervisord.conf

  USER nobody

  HEALTHCHECK --timeout=1s --interval=10s --retries=0 --start-period=30s CMD /healthcheck.sh
