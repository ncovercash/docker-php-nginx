#!/bin/sh

curl --silent --fail http://localhost:8080/ready -H "Host: internal-status" | grep ok || exit 1
curl --silent --fail http://localhost:8080/fpm-ping -H "Host: internal-status" | grep pong || exit 1
