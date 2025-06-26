# 📧 郵件功能設定指南

## 功能概述
已完成忘記密碼功能的開發和美化，包括：
- ✅ 美化忘記密碒頁面 (ForgotPassword.vue)
- ✅ 美化重設密碼頁面 (ResetPassword.vue)
- ✅ 自定義密碼重設通知 (ResetPasswordNotification.php)
- ✅ 中文化郵件內容
- ✅ 統一設計風格

## 📋 郵件服務配置

### 1. Gmail SMTP 設定 (推薦)

在 `.env` 檔案中設定以下配置：

```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS="your-email@gmail.com"
MAIL_FROM_NAME="課程交換系統"
```

### 2. Gmail App Password 設定

1. 登入您的 Google 帳戶
2. 前往 [Google 帳戶安全性設定](https://myaccount.google.com/security)
3. 啟用 2FA (兩步驟驗證)
4. 生成應用程式密碼：
   - 選擇「應用程式密碼」
   - 選擇「郵件」和您的裝置
   - 複製生成的 16 位密碼
   - 將此密碼填入 `MAIL_PASSWORD`

### 3. 其他郵件服務選項

#### Outlook/Hotmail
```env
MAIL_HOST=smtp.live.com
MAIL_PORT=587
MAIL_ENCRYPTION=tls
```

#### Yahoo Mail
```env
MAIL_HOST=smtp.mail.yahoo.com
MAIL_PORT=587
MAIL_ENCRYPTION=tls
```

#### Mailtrap (開發測試用)
```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=your-mailtrap-username
MAIL_PASSWORD=your-mailtrap-password
MAIL_ENCRYPTION=tls
```

## 🧪 測試郵件功能

### 1. 清除配置快取
```bash
php artisan config:clear
php artisan cache:clear
```

### 2. 測試密碼重設
1. 前往登入頁面
2. 點擊「忘記密碼？」
3. 輸入註冊的電子郵件
4. 檢查郵箱是否收到重設密碼郵件

### 3. 檢查郵件日誌
如果使用 `MAIL_MAILER=log`，郵件會記錄在：
```
storage/logs/laravel.log
```

## 📝 自定義功能

### 郵件範本自定義
- 通知類別：`app/Notifications/ResetPasswordNotification.php`
- 郵件範本：`resources/views/vendor/notifications/email.blade.php`

### 郵件內容特色
- 🎨 支援 HTML 格式
- 📱 響應式設計
- 🇹🇼 完整中文化
- 🔒 安全的重設連結
- ⏰ 60 分鐘連結過期時間

## 🚨 故障排除

### 常見問題
1. **Authentication failed**: 檢查帳號密碼和應用程式密碼
2. **Connection timeout**: 檢查防火牆和網路設定
3. **SSL/TLS errors**: 確認 `MAIL_ENCRYPTION` 設定正確

### 除錯模式
開啟除錯模式來查看詳細錯誤：
```env
APP_DEBUG=true
LOG_LEVEL=debug
```

## 🎨 頁面設計特色

### 忘記密碼頁面
- 漸層背景 (藍色系)
- 現代化卡片設計
- 圖示和視覺回饋
- 一致的輸入框樣式

### 重設密碼頁面
- 漸層背景 (綠色系)
- 密碼確認功能
- 即時錯誤提示
- 友善的用戶體驗

### 設計統一性
- 與登入/註冊頁面一致的設計語言
- 統一的色彩方案和動畫效果
- 響應式設計支援各種裝置

## 📧 郵件內容範本

發送的郵件包含：
- 友善的問候語
- 清楚的說明文字
- 醒目的重設密碼按鈕
- 安全提醒資訊
- 專業的署名

---

**提醒：請記得將 `.env` 檔案中的範例郵箱和密碼替換為您的實際設定！**
