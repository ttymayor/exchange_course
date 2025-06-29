# Node.js 階段 - 前端打包
FROM node:20-slim AS frontend-builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production
COPY resources/ ./resources/
COPY public/ ./public/
COPY vite.config.ts ./
COPY tsconfig.json ./
COPY tailwind.config.js* ./
COPY postcss.config.js* ./
COPY components.json ./
RUN npm run build

# PHP 生產環境
FROM php:8.3-fpm as production

# 安裝 composer 及系統/擴展（Debian 環境一行解決常見依賴）
RUN apt-get update && \
    apt-get install -y nginx supervisor git unzip zip libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev libzip-dev cron && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install pdo pdo_mysql mysqli mbstring xml bcmath pcntl gd zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress
COPY . .
COPY --from=frontend-builder /app/public/build ./public/build
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html/storage && \
    chmod -R 755 /var/www/html/bootstrap/cache

EXPOSE 8080
CMD ["php-fpm"]

