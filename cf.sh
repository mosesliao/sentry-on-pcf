#!/bin/bash

sentry init
echo "Putting sentry.conf.py file"
./generate-py.sh

# mv config.yml .sentry/
echo "Put config.yml file"

./generate-yml.sh

sentry run worker --autoreload &
sentry run cron --autoreload &
sentry createuser --no-input --email= --password= --superuser
sentry run web -w 3 --upgrade --with-lock --noinput