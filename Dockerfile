# syntax=docker/dockerfile:1

ARG PHP_VERSION=8.3
FROM docker.io/library/php:${PHP_VERSION}-fpm

LABEL "language"="php"
LABEL "framework"="laravel"

ENV APP_ENV=prod
ENV APP_DEBUG=false

WORKDIR /var/www

# install-php-extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync

# apt dependencies and node.js
RUN set -eux \
		&& apt update \
		&& apt install -y cron curl gettext git grep libicu-dev nginx pkg-config unzip \
		&& rm -rf /var/www/html \
		&& curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh \
		&& bash nodesource_setup.sh \
		&& apt install -y nodejs \
		&& rm -rf /var/lib/apt/lists/*

# composer and php extensions
RUN install-php-extensions @composer apcu bcmath gd intl mysqli opcache pcntl pdo_mysql sysvsem zip

# nginx configuration
RUN cat <<'EOF' > /etc/nginx/sites-enabled/default
server {
    listen 8080;
    root /var/www;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php index.html;
    charset utf-8;

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        fastcgi_param DOCUMENT_ROOT $realpath_root;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_hide_header X-Powered-By;
    }

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
        gzip_static on;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }

    error_log /dev/stderr;
    access_log /dev/stderr;
}
EOF

# 將所有檔案放置正確目錄，保證權限
COPY . /var/www
RUN mkdir -p /var/www/storage /var/www/bootstrap/cache \
  && chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache \
  && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# 切換到非 root，執行依賴安裝與建置
USER www-data
RUN if [ -f composer.json ]; then composer install --optimize-autoloader --classmap-authoritative --no-dev; fi
RUN if [ -f package.json ]; then npm install && npm run build; fi

# 自動補 .env 與 APP_KEY
RUN if [ ! -f .env ] && [ -f .env.example ]; then cp .env.example .env && php artisan key:generate; fi
# 清除舊快取避免環境問題
RUN php artisan config:clear && php artisan cache:clear && php artisan route:clear && php artisan view:clear

USER root

# 若專案有 public 目錄就修正 nginx root
RUN if [ -d /var/www/public ]; then sed -i 's|root /var/www;|root /var/www/public;|' /etc/nginx/sites-enabled/default; fi

CMD nginx; php-fpm;

EXPOSE 8080
