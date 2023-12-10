#!/bin/sh

curl --silent --fail http://localhost:8080/ready -H "Host: localhost" | grep ok || exit 1
curl --silent --fail http://localhost:8080/fpm-ping -H "Host: localhost" | grep pong || exit 1
