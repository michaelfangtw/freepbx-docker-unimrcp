# FreePBX Docker with UNIMRCP

A complete containerized solution for FreePBX + Asterisk + UNIMRCP.
這是一個完整的 FreePBX + Asterisk + UNIMRCP 的 Docker 容器化解決方案。

This project integrates FreePBX (open-source PBX system), Asterisk voice server, and UNIMRCP (Unified Mobile IVR Communication Platform) together, supporting speech recognition and text-to-speech capabilities.
該項目將 FreePBX (開源 PBX 系統) 和 Asterisk 語音伺服器與 UNIMRCP (統一多模式 IVR 通訊平台) 整合在一起，支援語音識別和語音合成功能。

## Features / 特性

- Asterisk 16.30.0 + FreePBX 16.0
- UNIMRCP client integrated with Asterisk / UNIMRCP 客戶端與 Asterisk 整合
- MariaDB database support / MariaDB 資料庫支援
- Apache 2 web server with PHP 7.4 / Apache 2 Web 伺服器與 PHP 7.4
- SSL/TLS encryption support / SSL/TLS 加密通訊支援
- Audio processing and multimedia support / 聲音處理與多媒體支援

## Quick Start / 快速開始

### 1. Configure Environment Variables / 配置環境變數

Edit the `.env` file to set UNIMRCP credentials and database parameters.
編輯 `.env` 檔案，設定 UNIMRCP 認證與資料庫參數。

### 2. Build Image / 構建映像

```bash
./build
```

### 3. Start Containers / 啟動容器

```bash
docker-compose up -d
```

This command launches two containers:
此命令會啟動兩個容器：

- `freepbx-pbx`: FreePBX + Asterisk + UNIMRCP
- `freepbx-db`: MariaDB database / MariaDB 資料庫

### 4. Access FreePBX / 訪問 FreePBX

Open your browser and navigate to:
開啟瀏覽器並導航至：

```text
https://localhost/admin
```

## Push to Docker Hub / 推送到 Docker Hub

1. Login to Docker Hub / 登入 Docker Hub

   ```bash
   docker login
   ```

2. Tag your image / 標記映像

   ```bash
   docker tag freepbx-docker-unimrcp:16.16.2 your-username/freepbx-docker-unimrcp:16.16.2
   ```

3. Push to Docker Hub / 推送到 Docker Hub

   ```bash
   docker push your-username/freepbx-docker-unimrcp:16.16.2
   ```

Replace `your-username` with your actual Docker Hub username.
將 `your-username` 替換為您的 Docker Hub 用戶名。
