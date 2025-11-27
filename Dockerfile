FROM node:18-slim
WORKDIR /app

# 1. 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    libasound2 libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libcups2 \
    libdbus-1-3 libdrm2 libgbm1 libgtk-3-0 libnspr4 libnss3 libx11-6 \
    libx11-xcb1 libxcb1 libxcomposite1 libxdamage1 libxext6 libxfixes3 \
    libxrandr2 libxss1 libxtst6 xvfb \
    && rm -rf /var/lib/apt/lists/*

# 2. 复制依赖声明 + 安装包
COPY package*.json ./
RUN npm install --production

# 3. 复制应用代码
COPY unified-server.js black-browser.js models.json ./ 
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    mkdir -p ./auth && chown -R node:node /app

USER node

EXPOSE 7860
EXPOSE 9998

ENV CAMOUFOX_EXECUTABLE_PATH=/app/camoufox-linux/camoufox

ENTRYPOINT ["/entrypoint.sh"]
CMD ["node", "unified-server.js"]
