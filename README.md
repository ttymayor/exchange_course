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
