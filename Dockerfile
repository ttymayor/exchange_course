# syntax=docker/dockerfile:1

# ARG PHP_VERSION=8.3
# FROM docker.io/library/php:${PHP_VERSION}-fpm

# LABEL "language"="php"
# LABEL "framework"="laravel"

# ENV APP_ENV=prod
# ENV APP_DEBUG=false

# WORKDIR /var/www

# # 安裝 PHP 擴展 & 必備環境
# ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
# RUN chmod +x /usr/local/bin/install-php-extensions && sync

# RUN set -eux \
#     && apt update \
#     && apt install -y cron curl gettext git grep libicu-dev nginx pkg-config unzip \
#     && rm -rf /var/www/html \
#     && curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh \
#     && bash nodesource_setup.sh \
#     && apt install -y nodejs \
#     && rm -rf /var/lib/apt/lists/*

# RUN install-php-extensions @composer apcu bcmath gd intl mysqli opcache pcntl pdo_mysql sysvsem zip

# # Nginx 標準設定，反代到 php-fpm
# RUN cat <<'EOF' > /etc/nginx/sites-enabled/default
# server {
#     listen 8080;
#     root /var/www;

#     add_header X-Frame-Options "SAMEORIGIN";
#     add_header X-Content-Type-Options "nosniff";

#     index index.php index.html;
#     charset utf-8;

#     location = /favicon.ico { access_log off; log_not_found off; }
#     location = /robots.txt  { access_log off; log_not_found off; }

#     error_page 404 /index.php;

#     location ~ \.php$ {
#         try_files $uri =404;
#         fastcgi_split_path_info ^(.+\.php)(/.*)$;
#         fastcgi_pass 127.0.0.1:9000;
#         fastcgi_index index.php;
#         include fastcgi_params;
#         fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
#         fastcgi_param DOCUMENT_ROOT $realpath_root;
#         fastcgi_param PATH_INFO $fastcgi_path_info;
#         fastcgi_hide_header X-Powered-By;
#     }

#     location / {
#         try_files $uri $uri/ /index.php$is_args$args;
#         gzip_static on;
#     }

#     location ~ /\.(?!well-known).* {
#         deny all;
#     }

#     error_log /dev/stderr;
#     access_log /dev/stderr;
# }
# EOF

# # 複製專案檔案
# COPY . /var/www

# RUN mkdir -p /var/www/resources/views /var/www/storage /var/www/bootstrap/cache \
#  && chown -R www-data:www-data /var/www \
#  && chmod -R 775 /var/www/storage /var/www/bootstrap/cache

# USER www-data

# RUN if [ -f composer.json ]; then composer install --optimize-autoloader --classmap-authoritative --no-dev; fi
# RUN if [ -f package.json ]; then npm install && npm run build; fi

# RUN if [ ! -f .env ] && [ -f .env.example ]; then \
#      cp .env.example .env && \
#      grep -q "^APP_KEY=" .env || echo "APP_KEY=" >> .env && \
#      php artisan key:generate \
# ; fi

# RUN php artisan config:clear || true && \
#     php artisan cache:clear || true && \
#     php artisan route:clear || true && \
#     php artisan view:clear || true

# USER root
# RUN if [ -d /var/www/public ]; then sed -i 's|root /var/www;|root /var/www/public;|' /etc/nginx/sites-enabled/default; fi

# CMD nginx; php-fpm;

# EXPOSE 8080


FROM alpine:latest

RUN apk update && apk upgrade && \
    apk add --no-cache \
    curl \
    bash \
    git \
    openssh \
    npm \
    nodejs \
    yarn \
    php8 \
    php8-curl \
    php8-dom \
    php8-ctype \
    php8-fileinfo \
    php8-json \
    php8-mbstring \
    php8-tokenizer \
    php8-openssl \
    php8-pdo \
    php8-pdo_mysql \
    php8-pecl-apcu \
    php8-phar \
    php8-session \
    php8-simplexml \
    php8-tokenizer \
    php8-xml \
    php8-xmlwriter \
    php8-zip

RUN ln -s /usr/bin/php8 /usr/bin/php && \
    php -v && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    . "$HOME/.nvm/nvm.sh" && \
    nvm install 22

COPY . /app
WORKDIR /app

RUN composer install --optimize-autoloader --no-dev && \
    npm install && \
    php artisan key:generate && \
    composer run dev

# 預設執行命令
CMD ["php", "artisan", "serve", "--host=0.0.0.0"]

EXPOSE 8000