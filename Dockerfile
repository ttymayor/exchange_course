# Node.js 階段產生前端資源
FROM node:20-alpine AS frontend-builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY resources/ ./resources/
COPY public/ ./public/
COPY vite.config.ts ./
COPY tsconfig.json ./
COPY tailwind.config.js* ./
COPY postcss.config.js* ./
COPY components.json ./
RUN npm run build

# PHP 生產階段
FROM php:8.3-fpm-alpine AS production
RUN apk add --no-cache nginx supervisor mysql-client curl zip unzip git oniguruma-dev libxml2-dev libpng-dev libjpeg-turbo-dev freetype-dev redis
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) pdo_mysql mysqli mbstring xml bcmath pcntl gd zip
RUN pecl install redis && docker-php-ext-enable redis
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress
COPY . .
COPY --from=frontend-builder /app/public/build ./public/build
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html/storage && \
    chmod -R 755 /var/www/html/bootstrap/cache
COPY docker/nginx.conf /etc/nginx/nginx.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 8080
CMD ["/start.sh"]
