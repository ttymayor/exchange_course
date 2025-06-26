#!/bin/sh

# 啟動腳本 for Laravel 應用

echo "🚀 Starting Laravel application..."

# 等待數據庫連接
echo "⏳ Waiting for database connection..."
until php artisan migrate:status >/dev/null 2>&1; do
    echo "Waiting for database..."
    sleep 2
done

# 運行 Laravel 初始化
echo "🔧 Running Laravel initialization..."

# 生成應用金鑰（如果不存在）
if [ ! -f .env ]; then
    cp .env.example .env
fi

# 快取配置
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 運行資料庫遷移
php artisan migrate --force

# 創建符號連結
php artisan storage:link

# 設置權限
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache

echo "✅ Laravel application initialized successfully!"

# 啟動 Supervisor
echo "🔄 Starting services..."
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
