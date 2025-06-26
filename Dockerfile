# 多階段構建 Dockerfile for Laravel + Vue.js 專案

# Node.js 階段 - 建置前端資源
FROM node:20-alpine AS frontend-builder

WORKDIR /app

# 複製 package 檔案
COPY package*.json ./

# 安裝依賴
RUN npm ci --only=production

# 複製前端源碼
COPY resources/ ./resources/
COPY public/ ./public/
COPY vite.config.ts ./
COPY tsconfig.json ./
COPY tailwind.config.js* ./
COPY postcss.config.js* ./
COPY components.json ./

# 建置前端資源
RUN npm run build

# PHP 生產階段
FROM php:8.3-fpm-alpine AS production

# 安裝系統依賴
RUN apk add --no-cache \
    nginx \
    supervisor \
    mysql-client \
    curl \
    zip \
    unzip \
    git \
    oniguruma-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    redis

# 安裝 PHP 擴展
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        mysqli \
        mbstring \
        xml \
        bcmath \
        pcntl \
        gd \
        zip

# 安裝 Redis 擴展
RUN pecl install redis && docker-php-ext-enable redis

# 安裝 Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 設置工作目錄
WORKDIR /var/www/html

# 複製 PHP 依賴文件
COPY composer.json composer.lock ./

# 安裝 PHP 依賴（不包含開發依賴）
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-progress

# 複製應用源碼
COPY . .

# 從前端建置階段複製建置好的資源
COPY --from=frontend-builder /app/public/build ./public/build

# 設置權限
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# 複製 Nginx 配置
COPY docker/nginx.conf /etc/nginx/nginx.conf

# 複製 Supervisor 配置
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 複製啟動腳本
COPY docker/start.sh /start.sh
RUN chmod +x /start.sh

# 暴露端口
EXPOSE 8080

# 啟動
CMD ["/start.sh"]
