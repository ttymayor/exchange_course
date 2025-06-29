# syntax=docker/dockerfile:1

ARG PHP_VERSION=8.3
FROM docker.io/library/php:${PHP_VERSION}-fpm

LABEL "language"="php"
LABEL "framework"="laravel"

ENV APP_ENV=prod
ENV APP_DEBUG=false

WORKDIR /var/www

# 安裝 PHP 擴展 & 必備環境
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync

RUN set -eux \
    && apt update \
    && apt install -y cron curl gettext git grep libicu-dev nginx pkg-config unzip \
    && rm -rf /var/www/html \
    && curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN install-php-extensions @composer apcu bcmath gd intl mysqli opcache pcntl pdo_mysql sysvsem zip

# Nginx 標準設定，反代到 php-fpm
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

# 複製專案檔案
COPY . /var/www

# 預建 vendor、storage、bootstrap/cache，給 www-data 權限（Composer 需要）
RUN mkdir -p /var/www/vendor /var/www/node_modules /var/www/.npm /var/www/storage /var/www/bootstrap/cache \
 && chown -R www-data:www-data /var/www/vendor /var/www/node_modules /var/www/.npm /var/www/storage /var/www/bootstrap/cache \
 && chmod -R 775 /var/www/vendor /var/www/node_modules /var/www/.npm /var/www/storage /var/www/bootstrap/cache

# 使用 www-data 安裝（避免權限問題）
USER www-data

# 安裝 PHP 依賴 & 前端依賴 + 建構
RUN if [ -f composer.json ]; then composer install --optimize-autoloader --classmap-authoritative --no-dev; fi
RUN if [ -f package.json ]; then npm install && npm run build; fi

# 自動生成 .env & APP_KEY（若未提供）
RUN if [ ! -f .env ] && [ -f .env.example ]; then cp .env.example .env && php artisan key:generate; fi

# 清除快取（避免 config:cache 初始錯誤 - 尤其首次建置）
RUN php artisan config:clear && php artisan cache:clear && php artisan route:clear && php artisan view:clear

USER root

# 修正 nginx root 指向 public 目錄
RUN if [ -d /var/www/public ]; then sed -i 's|root /var/www;|root /var/www/public;|' /etc/nginx/sites-enabled/default; fi

CMD nginx; php-fpm;

EXPOSE 8080
