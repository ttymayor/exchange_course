#!/bin/bash

# 🧪 Zeabur 部署前本地測試腳本

echo "🐳 測試 Zeabur 部署配置..."

# 檢查必要文件
echo "1. 檢查部署文件..."
files=("Dockerfile" ".dockerignore" "zeabur.toml" "docker/nginx.conf" "docker/supervisord.conf" "docker/start.sh")
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✅ $file"
    else
        echo "   ❌ $file 缺失"
        exit 1
    fi
done

# 檢查 Docker
echo "2. 檢查 Docker..."
if command -v docker &> /dev/null; then
    echo "   ✅ Docker 已安裝"
else
    echo "   ❌ Docker 未安裝"
    exit 1
fi

# 建置 Docker 映像檔（測試）
echo "3. 測試 Docker 建置..."
if docker build -t laravel-zeabur-test . > /dev/null 2>&1; then
    echo "   ✅ Docker 建置成功"
    
    # 清理測試映像檔
    docker rmi laravel-zeabur-test > /dev/null 2>&1
else
    echo "   ❌ Docker 建置失敗"
    echo "   💡 檢查 Dockerfile 語法"
    exit 1
fi

# 檢查前端建置
echo "4. 檢查前端建置..."
if npm run build > /dev/null 2>&1; then
    echo "   ✅ 前端建置成功"
    rm -rf public/build
else
    echo "   ❌ 前端建置失敗"
    echo "   💡 檢查 package.json 和 vite.config.ts"
    exit 1
fi

echo ""
echo "🎉 Zeabur 部署配置檢查完成！"
echo ""
echo "📋 下一步："
echo "1. 推送代碼到 Git 倉庫："
echo "   git add ."
echo "   git commit -m 'Add Zeabur deployment config'"
echo "   git push origin main"
echo ""
echo "2. 前往 Zeabur 創建項目："
echo "   https://zeabur.com/"
echo ""
echo "3. 閱讀部署指南："
echo "   cat ZEABUR_DEPLOYMENT.md"
