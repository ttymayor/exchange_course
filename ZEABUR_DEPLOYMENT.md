# 🚀 Zeabur 部署指南

## 📋 專案概述
本指南將幫助您將 Laravel + Vue.js + Inertia.js 專案部署到 Zeabur 平台。

## 🛠️ 準備工作

### 1. 推送代碼到 Git 倉庫
確保您的代碼已推送到 GitHub、GitLab 或 Bitbucket：

```bash
git add .
git commit -m "Add Zeabur deployment configuration"
git push origin main
```

### 2. 檢查必要文件
確保以下文件存在：
- ✅ `Dockerfile` - Docker 建置配置
- ✅ `.dockerignore` - Docker 忽略文件
- ✅ `zeabur.toml` - Zeabur 配置
- ✅ `docker/` 文件夾 - 包含 nginx.conf, supervisord.conf, start.sh

## 🔧 Zeabur 部署步驟

### 1. 創建 Zeabur 項目
1. 前往 [Zeabur](https://zeabur.com/)
2. 登入或註冊帳號
3. 點擊 "New Project"
4. 選擇您的 Git 倉庫

### 2. 配置數據庫
在 Zeabur 項目中添加數據庫服務：

#### MySQL 數據庫
1. 點擊 "Add Service" 
2. 選擇 "MySQL"
3. 記錄數據庫連接信息

#### PostgreSQL 數據庫（可選）
1. 點擊 "Add Service"
2. 選擇 "PostgreSQL" 
3. 記錄數據庫連接信息

### 3. 配置 Redis（可選）
1. 點擊 "Add Service"
2. 選擇 "Redis"
3. 記錄 Redis 連接信息

### 4. 配置環境變數
在 Zeabur 應用設定中添加以下環境變數：

#### 基本配置
```env
# 應用配置
APP_NAME=課程交換系統
APP_ENV=production
APP_DEBUG=false
APP_URL=https://your-app.zeabur.app

# 應用金鑰（重要！）
APP_KEY=base64:your-generated-key

# 數據庫配置（使用 Zeabur 提供的值）
DB_CONNECTION=mysql
DB_HOST=${MYSQL_HOST}
DB_PORT=${MYSQL_PORT}
DB_DATABASE=${MYSQL_DATABASE}
DB_USERNAME=${MYSQL_USERNAME}
DB_PASSWORD=${MYSQL_PASSWORD}

# 或使用 PostgreSQL
DB_CONNECTION=pgsql
DB_HOST=${POSTGRES_HOST}
DB_PORT=${POSTGRES_PORT}
DB_DATABASE=${POSTGRES_DATABASE}
DB_USERNAME=${POSTGRES_USERNAME}
DB_PASSWORD=${POSTGRES_PASSWORD}

# Redis 配置（如果使用）
REDIS_HOST=${REDIS_HOST}
REDIS_PASSWORD=${REDIS_PASSWORD}
REDIS_PORT=${REDIS_PORT}

# 郵件配置
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="your-email@gmail.com"
MAIL_FROM_NAME="課程交換系統"

# Session 配置
SESSION_DRIVER=database
SESSION_LIFETIME=120

# 快取配置
CACHE_STORE=redis
QUEUE_CONNECTION=redis

# 檔案存儲
FILESYSTEM_DISK=local
```

#### 重要安全配置
```env
# 生產環境安全設定
APP_DEBUG=false
APP_ENV=production
BCRYPT_ROUNDS=12
```

### 5. 自動生成 APP_KEY
如果您還沒有 APP_KEY，可以在本地生成：

```bash
php artisan key:generate --show
```

然後將生成的金鑰添加到 Zeabur 環境變數中。

## 🌐 域名配置

### 1. 使用 Zeabur 提供的域名
Zeabur 會自動為您的應用分配一個 `.zeabur.app` 域名。

### 2. 使用自定義域名
1. 在 Zeabur 項目設定中點擊 "Domains"
2. 添加您的自定義域名
3. 按照指示配置 DNS 記錄

## 🔍 部署後檢查

### 1. 檢查應用狀態
- 確保應用成功啟動（狀態為 "Running"）
- 檢查日誌是否有錯誤訊息

### 2. 測試功能
- ✅ 主頁是否正常載入
- ✅ 用戶註冊/登入功能
- ✅ 課程創建和編輯
- ✅ 郵件發送功能
- ✅ 資料庫連接

### 3. 性能優化
在生產環境中，確保啟用了：
- ✅ 配置快取 (`config:cache`)
- ✅ 路由快取 (`route:cache`)
- ✅ 視圖快取 (`view:cache`)
- ✅ Composer 優化 (`--optimize-autoloader`)

## 🚨 常見問題

### 1. 應用金鑰錯誤
```
錯誤: The application key is missing
解決: 確保在 Zeabur 環境變數中設定了正確的 APP_KEY
```

### 2. 數據庫連接失敗
```
錯誤: Database connection failed
解決: 檢查數據庫環境變數是否正確配置
```

### 3. 靜態文件載入失敗
```
錯誤: CSS/JS 文件 404
解決: 確保 Vite 建置配置正確，檢查 public/build 目錄
```

### 4. 權限問題
```
錯誤: Storage permission denied
解決: 檢查 start.sh 中的權限設定
```

## 🔄 更新部署

### 自動部署
Zeabur 支援自動部署，當您推送代碼到主分支時會自動觸發部署。

### 手動部署
1. 在 Zeabur 控制台中點擊 "Redeploy"
2. 等待建置完成

## 📊 監控和日誌

### 查看應用日誌
1. 在 Zeabur 控制台中點擊您的應用
2. 選擇 "Logs" 標籤
3. 監控實時日誌輸出

### 監控資源使用
- CPU 使用率
- 記憶體使用量
- 網路流量

## 💰 費用估算

Zeabur 提供：
- 免費計劃：適合小型項目和測試
- 付費計劃：根據資源使用量計費

建議從免費計劃開始，根據需要升級。

## 🛡️ 安全建議

1. **環境變數安全**：
   - 不要在代碼中硬編碼敏感信息
   - 使用強密碼和安全的 APP_KEY

2. **HTTPS**：
   - Zeabur 自動提供 HTTPS
   - 確保 `APP_URL` 使用 https://

3. **定期更新**：
   - 保持依賴更新
   - 定期檢查安全漏洞

---

🎉 **恭喜！您的 Laravel + Vue.js 應用現在已經成功部署到 Zeabur！**

如有問題，請參考：
- [Zeabur 官方文檔](https://zeabur.com/docs)
- [Laravel 部署指南](https://laravel.com/docs/deployment)
