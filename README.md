# Sentry 8.13.0 On PCF

This script is proven to be able to deploy Sentry.io to Pivotal Cloud Foundry

## Steps

1. Git clone this respository
2. Set up your PostgreSQL / MySQL and Redis Service Brokers in PCF
3. Add in the following `env` details to `manifest.yml`
	* `SMTP_BACKEND`, `SMTP_HOST`, `SMTP_PORT` for emailing configurations
	* `http_proxy` and `https_proxy` if your cf is behind proxy servers
	* `superuser_email` and `superuser_password` to create the first user
4. `cf login` and run `cf push` to deploy

