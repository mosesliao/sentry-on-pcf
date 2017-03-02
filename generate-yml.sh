#!/bin/bash

REDIS_HOST=`echo $VCAP_SERVICES | jq '.["p-redis"]' | jq '.[0].credentials.host'`
REDIS_PWD=`echo $VCAP_SERVICES | jq '.["p-redis"]' | jq '.[0].credentials.password'`
REDIS_PORT=`echo $VCAP_SERVICES | jq '.["p-redis"]' | jq '.[0].credentials.port'`
echo "host: ${REDIS_HOST}, port: ${REDIS_PORT}"

cat > .sentry/config.yml << EOF
# While a lot of configuration in Sentry can be changed via the UI, for all
# new-style config (as of 8.0) you can also declare values here in this file
# to enforce defaults or to ensure they cannot be changed via the UI. For more
# information see the Sentry documentation.
###############
# Mail Server #
###############
mail.backend: '${SMTP_BACKEND}'  # Use dummy if you want to disable email entirely
mail.host: '${SMTP_HOST}'
mail.port: ${SMTP_PORT}
# mail.username: ''
# mail.password: ''
# mail.use-tls: false
# The email address to send on behalf of
# mail.from: 'root@localhost'
# If you'd like to configure email replies, enable this.
# mail.enable-replies: false
# When email-replies are enabled, this value is used in the Reply-To header
# mail.reply-hostname: ''
# If you're using mailgun for inbound mail, set your API key and configure a
# route to forward to /api/hooks/mailgun/inbound/
# mail.mailgun-api-key: ''
###################
# System Settings #
###################
# If this file ever becomes compromised, it's important to regenerate your a new key
# Changing this value will result in all current sessions being invalidated.
# A new key can be generated with `$ sentry config generate-secret-key`
system.secret-key: '^rq9d4y!3b$123ee+gw(=e17+bw*!x#fo9w7s+5j4y0(hj=f3i'
# The ``redis.clusters`` setting is used, unsurprisingly, to configure Redis
# clusters. These clusters can be then referred to by name when configuring
# backends such as the cache, digests, or TSDB backend.
redis.clusters:
  default:
    hosts:
      0:
        host: ${REDIS_HOST}
        port: ${REDIS_PORT}
        password: ${REDIS_PWD}
################
# File storage #
################
# Uploaded media uses these `filestore` settings. The available
# backends are either `filesystem` or `s3`.
filestore.backend: 'filesystem'
filestore.options:
  location: '/tmp/sentry-files'
# filestore.backend: 's3'
# filestore.options:
#   access_key: 'AKIXXXXXX'
#   secret_key: 'XXXXXXX'
#   bucket_name: 's3-bucket-name'
EOF