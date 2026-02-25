# FreePBX Docker with UNIMRCP

## 🇨🇳 中文版本

這是一個完整的 FreePBX + Asterisk + UNIMRCP 的 Docker 容器化解決方案。該項目將 FreePBX (開源 PBX 系統) 和 Asterisk 語音伺服器與 UNIMRCP (統一多模式 IVR 通訊平台) 整合在一起，支援語音識別和語音合成功能。

**主要特性：**

- Asterisk 16.30.0 + FreePBX 16.0
- UNIMRCP 客戶端與 Asterisk 整合
- MariaDB 資料庫支援
- Apache 2 Web 伺服器與 PHP 7.4
- SSL/TLS 加密通訊支援
- 聲音處理與多媒體支援

### 快速開始

1. **配置環境變數**
   編輯 `.env` 檔案，設定 UNIMRCP 認證與資料庫參數

2. **構建映像**

   ```bash
   ./build
   ```

3. **啟動容器**

   ```bash
   docker-compose up -d
   ```

4. **訪問 FreePBX**

   ```
   https://localhost/admin
   ```

---

## 🇬🇧 English Version

A complete containerized solution for FreePBX + Asterisk + UNIMRCP. This project integrates FreePBX (open-source PBX system), Asterisk voice server, and UNIMRCP (Unified Mobile IVR Communication Platform) together, supporting speech recognition and text-to-speech capabilities.

**Key Features:**

- Asterisk 16.30.0 + FreePBX 16.0
- UNIMRCP client integrated with Asterisk
- MariaDB database support
- Apache 2 web server with PHP 7.4
- SSL/TLS encryption support
- Audio processing and multimedia support

### Quick Start

1. **Configure Environment Variables**
   Edit the `.env` file to set UNIMRCP credentials and database parameters

2. **Build Image**

   ```bash
   ./build
   ```

3. **Start Containers**

   ```bash
   docker-compose up -d
   ```

4. **Access FreePBX**

   ```
   https://localhost/admin
   ```
