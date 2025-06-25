# 大學生課程交換平台

一個基於 Laravel + Vue.js + Inertia.js 的大學生課程交換網頁系統，讓學生可以發布自己的課程並與其他學生進行課程交換。

> [!NOTE]
> Vibe Coding!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## 🎯 專案特色

- **課程管理**: 學生可以發布、編輯、刪除自己的課程
- **交換申請**: 學生可以申請交換其他同學的課程
- **交換管理**: 管理自己的交換申請狀態
- **響應式設計**: 支援桌面和手機瀏覽
- **現代化 UI**: 使用 Tailwind CSS 打造美觀介面
- **用戶認證**: 完整的註冊、登入、登出功能

## 🛠 技術棧

### 後端
- **PHP 8.2+**
- **Laravel 11.x**
- **SQLite** (開發環境)
- **Inertia.js** (前後端橋接)

### 前端
- **Vue.js 3**
- **TypeScript**
- **Tailwind CSS**
- **Vite** (構建工具)

### 開發工具
- **Pest** (測試框架)
- **ESLint** (代碼檢查)
- **Composer** (PHP 依賴管理)
- **NPM** (前端依賴管理)

## 📋 功能特色

### 課程管理
- ✅ 發布課程（課程名稱、代碼、教師、時間、地點、學分、描述）
- ✅ 編輯課程資訊
- ✅ 刪除課程
- ✅ 查看課程狀態（可交換/已交換/已取消）

### 交換功能
- ✅ 瀏覽可交換的課程
- ✅ 申請課程交換
- ✅ 查看交換申請狀態
- ✅ 管理收到的交換申請

### 用戶系統
- ✅ 用戶註冊
- ✅ 用戶登入/登出
- ✅ 個人課程管理

### 響應式設計
- ✅ 手機友好的導航欄（漢堡選單）
- ✅ 響應式表單設計
- ✅ 適配各種螢幕尺寸

## 🚀 快速開始

### 環境需求

- PHP >= 8.2
- Composer
- Node.js >= 18.x
- NPM

### 安裝步驟

1. **克隆專案**
```bash
git clone <repository-url>
cd laravel_app
```

2. **安裝 PHP 依賴**
```bash
composer install
```

3. **安裝前端依賴**
```bash
npm install
```

4. **環境配置**
```bash
cp .env.example .env
php artisan key:generate
```

5. **資料庫設置**
```bash
# 建立 SQLite 資料庫
touch database/database.sqlite

# 執行遷移
php artisan migrate

# 建立範例資料
php artisan db:seed
```

6. **編譯前端資源**
```bash
# 開發模式
npm run dev

# 或生產模式
npm run build
```

7. **啟動開發伺服器**
```bash
php artisan serve
```

訪問 `http://localhost:8000` 即可使用系統。

## 📱 使用說明

### 首次使用

1. **註冊帳號**: 訪問註冊頁面建立新用戶
2. **登入系統**: 使用帳號密碼登入
3. **發布課程**: 在「發布交換課程」頁面新增您的課程
4. **瀏覽課程**: 在首頁瀏覽其他同學發布的課程
5. **申請交換**: 點擊「申請交換」提交交換申請
6. **管理交換**: 在「我的交換」頁面管理申請狀態

### 範例帳號

系統會自動建立以下測試帳號：

```
帳號: student1@example.com ~ student10@example.com
密碼: password
```

## 🏗 專案結構

```
laravel_app/
├── app/
│   ├── Http/Controllers/     # 控制器
│   ├── Models/              # 資料模型
│   └── ...
├── database/
│   ├── migrations/          # 資料庫遷移
│   ├── seeders/            # 資料種子
│   └── database.sqlite     # SQLite 資料庫
├── resources/
│   ├── js/
│   │   ├── components/     # Vue 元件
│   │   ├── pages/         # 頁面元件
│   │   └── ...
│   └── css/               # 樣式文件
├── routes/
│   ├── web.php           # 網頁路由
│   └── auth.php          # 認證路由
└── ...
```

## 🗄 資料庫設計

### 主要資料表

- **users**: 用戶資料
- **courses**: 課程資料
- **course_exchanges**: 課程交換申請

### 關聯關係

- 一個用戶可以擁有多個課程
- 一個課程交換涉及兩個用戶和兩個課程
- 課程交換有狀態管理（pending, accepted, rejected）

## 🚀 Zeabur 部署

本專案已部署至 Zeabur 雲端平台：**https://thu-exchange-course.zeabur.app**

### 部署需求

1. **環境變數設置**
```env
# 基本 Laravel 設置
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:your_app_key_here

# 資料庫設置（推薦使用 MySQL 或 PostgreSQL）
DB_CONNECTION=mysql
DB_HOST=your_db_host
DB_PORT=3306
DB_DATABASE=your_db_name
DB_USERNAME=your_db_user
DB_PASSWORD=your_db_password

# 快取和 Session 設置
CACHE_DRIVER=file
SESSION_DRIVER=file
QUEUE_CONNECTION=sync
```

2. **建構設置**
```json
{
  "buildCommand": "npm run build && composer install --no-dev --optimize-autoloader",
  "startCommand": "php artisan config:cache && php artisan route:cache && php artisan view:cache && php-fpm",
  "installCommand": "composer install && npm install"
}
```

3. **部署後執行**
```bash
# 生成應用金鑰
php artisan key:generate

# 執行資料庫遷移
php artisan migrate --force

# 建立範例資料（可選）
php artisan db:seed --force

# 清除快取
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

### 常見部署問題排除

#### 🔧 登入頁面顯示不出來

**症狀**: 伺服器回傳 200 狀態碼但頁面空白或無法載入

**可能原因與解決方案**:

1. **前端資源未正確編譯**
```bash
# 確保在部署前執行
npm run build
```

2. **Vite 資源路徑問題**
檢查 `vite.config.ts` 設置：
```typescript
export default defineConfig({
    // ...existing code...
    build: {
        manifest: true,
        outDir: 'public/build',
        rollupOptions: {
            input: 'resources/js/app.ts',
        },
    },
    // ...existing code...
});
```

3. **Laravel Mix/Vite 快取問題**
```bash
php artisan view:clear
php artisan config:clear
rm -rf public/build/*
npm run build
```

4. **環境變數檢查**
```bash
# 確保 APP_URL 正確設置
APP_URL=https://thu-exchange-course.zeabur.app
```

5. **Inertia.js SSR 問題**
檢查 `resources/js/ssr.ts` 是否正確設置：
```bash
# 如果使用 SSR，確保建構 SSR 版本
npm run build:ssr
```

#### ⚠️ 關鍵修復：app.blade.php Vite 載入問題

**發現的問題**: `resources/views/app.blade.php` 中的 `@vite` 指令不正確

**錯誤的寫法**:
```php
@vite(['resources/js/app.ts', "resources/js/pages/{$page['component']}.vue"])
```

**正確的寫法**:
```php
@vite(['resources/js/app.ts'])
```

這個錯誤會導致 Vite 試圖載入不存在的檔案路徑，造成前端資源載入失敗。

## ✅ 問題已解決

**根本原因**: `resources/views/app.blade.php` 中的 `@vite` 指令載入了錯誤的檔案路徑，導致前端資源無法正確載入。

**修復步驟**:
1. ✅ 修正 `app.blade.php` 中的 Vite 指令
2. ✅ 重新建構前端資源 (`npm run build`)
3. ✅ 確保 `public/build/` 目錄包含正確的資源檔案

**部署到 Zeabur 後的檢查清單**:
- [ ] 確保環境變數正確設置
- [ ] 執行 `php artisan migrate --force`
- [ ] 執行 `php artisan db:seed --force`（可選）
- [ ] 清除快取並重新設置

現在您的應用程式應該可以正常顯示登入頁面了！

## 🧪 測試

```bash
# 執行所有測試
php artisan test

# 或使用 Pest
vendor/bin/pest
```

## 📝 開發注意事項

### 代碼風格
- 遵循 PSR-12 PHP 編碼標準
- 使用 TypeScript 進行前端開發
- 遵循 Vue.js 3 Composition API 最佳實踐

### 響應式設計
- 使用 Tailwind CSS 的響應式類別
- 手機優先的設計原則
- 確保所有功能在不同裝置上都能正常使用

### 安全性
- 使用 Laravel 的內建 CSRF 保護
- 用戶認證和授權
- 資料驗證和過濾

## 🤝 貢獻

歡迎提交 Issue 和 Pull Request！

## 📄 授權

此專案採用 MIT 授權條款。

## 📞 聯絡

如有問題或建議，請建立 Issue 或聯絡開發團隊。

---

**快樂交換課程！** 🎓✨

### 🚨 緊急修復：登入頁面顯示問題

基於您的 Zeabur 部署日誌，以下是立即解決方案：

#### 1. 檢查 Vite 建構輸出
```bash
# 確保前端資源正確編譯
npm run build

# 檢查 public/build 目錄是否存在且有檔案
ls -la public/build/
```

#### 2. 檢查 Laravel 視圖檔案
確保 `resources/views/app.blade.php` 正確載入 Vite 資源：
```php
<!DOCTYPE html>
<html>
<head>
    <!-- ...existing code... -->
    @vite(['resources/js/app.ts'])
    @inertiaHead
</head>
<body>
    @inertia
</body>
</html>
```

#### 3. 立即部署修復
在 Zeabur 中設置以下建構指令：
```bash
# 建構指令
npm install && npm run build && composer install --no-dev --optimize-autoloader

# 啟動指令
php artisan config:cache && php artisan view:cache && php-fpm
```

#### 4. 環境變數確認
確保在 Zeabur 中設置：
```env
APP_URL=https://thu-exchange-course.zeabur.app
VITE_APP_URL=https://thu-exchange-course.zeabur.app
```

#### 5. 快速除錯指令
```bash
# 清除所有快取
php artisan config:clear
php artisan cache:clear
php artisan view:clear
php artisan route:clear

# 重新建構前端
rm -rf public/build
npm run build

# 重新設置快取
php artisan config:cache
php artisan view:cache
```
