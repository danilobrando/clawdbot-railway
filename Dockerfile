FROM node:22-bookworm

# Instalar dependencias del sistema mínimas requeridas
RUN apt-get update && apt-get install -y \
    socat \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio de trabajo
WORKDIR /app

# Clonar OpenClaw
RUN git clone --depth 1 https://github.com/openclaw/openclaw.git .

# Copiar y ejecutar el parche para proxies
COPY patch.js .
RUN node patch.js

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

# Comando de inicio
CMD ["sh", "-c", "node dist/index.js gateway --bind 0.0.0.0 --port ${PORT:-18789} --allow-unconfigured"]
