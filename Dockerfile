FROM trafex/php-nginx:3.5.0 AS base

  USER root

  # for healthcheck
  RUN apk add --no-cache curl

  COPY conf/status.conf /etc/nginx/conf.d/status.conf
  COPY healthcheck.sh /healthcheck.sh
  RUN chmod +x /healthcheck.sh

  USER nobody

  HEALTHCHECK --timeout=1s --interval=10s --retries=0 --start-period=30s CMD /healthcheck.sh
