# docker-php-nginx

An extension of https://github.com/TrafeX/docker-php-nginx/ with a few bonus features I find useful.

## Status host

A host `internal-status` is added to the nginx config which will return status reports on that
hostname only. This hostname should **not** be exposed publicly, however, it is useful for
monitoring tools to check the status of the server.

It listens on the following endpoints:

- `/ready` -- a 200 `ok` if the server is ready to serve requests
- `/status` -- a standard nginx `stub_status` report
- `/fpm-status` -- PHP-FPM status page
- `/fpm-ping` -- PHP-FPM ping page
