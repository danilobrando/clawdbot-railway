FROM node:22-bookworm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    socat \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar binarios opcionales para integraciones
# Gmail CLI
RUN curl -L https://github.com/steipete/gog/releases/latest/download/gog_Linux_x86_64.tar.gz \
    | tar -xz -C /usr/local/bin && chmod +x /usr/local/bin/gog

# WhatsApp CLI
RUN curl -L https://github.com/steipete/wacli/releases/latest/download/wacli_Linux_x86_64.tar.gz \
    | tar -xz -C /usr/local/bin && chmod +x /usr/local/bin/wacli

# Crear directorio de trabajo
WORKDIR /app

# Clonar OpenClaw
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .

# Instalar pnpm y dependencias
RUN corepack enable
RUN pnpm install --frozen-lockfile

# Build del proyecto
RUN pnpm build
RUN pnpm ui:install
RUN pnpm ui:build

# Crear directorios de persistencia
RUN mkdir -p /home/node/.openclaw/workspace
RUN chown -R node:node /home/node/.openclaw

ENV NODE_ENV=production
ENV HOME=/home/node

# Puerto del Gateway (Railway asigna PORT dinámicamente)
EXPOSE 18789

# Comando de inicio - Railway inyecta $PORT
CMD ["sh", "-c", "node dist/index.js gateway --bind lan --port ${PORT:-18789}"]
