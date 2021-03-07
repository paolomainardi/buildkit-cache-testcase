FROM composer:1.10.13 as base
RUN apk add --no-cache patch nodejs npm python2 g++
WORKDIR /var/www/html
RUN COMPOSER_MEMORY_LIMIT=-1 composer global require hirak/prestissimo

COPY src/drupal/composer* /var/www/html/

# Install PHP dependencies to gather static artifacts.
RUN composer install --ignore-platform-reqs -v --no-interaction --prefer-dist --no-progress

# We need this to avoid the fact that we can't have custom dockerignore files
# and we want to remove everything that is PHP related.
RUN find . -name "*.php" -type f -exec rm -f {} + && \
    find . -name "*.module" -type f -exec rm -f {} + && \
    find . -name "*.inc" -type f -exec rm -f {} + && \
    find . -name "*.install" -type f -exec rm -f {} + && \
    find . -name "*.test" -type f -exec rm -f {} + && \
    find . -name "*.theme" -type f -exec rm -f {} + && \
    find . -name "*.twig" -type f -exec rm -f {} + && \
    find . -name "*.yml" -type f -exec rm -f {} +

# And here we just keep the static files we need to have a smaller squashed image.
FROM ghcr.io/sparkfabrik/docker-php-drupal-nginx:1.17.6-alpine.d8 as nginx

ENV NGINX_DEFAULT_ROOT /var/www/html/web
COPY --from=base /var/www/html /var/www/html
WORKDIR /var/www/html
