# OpenClaw on Railway

Deploy [OpenClaw](https://openclaw.ai/) (formerly moltbot/clawdbot) - a personal AI assistant - on Railway.

## Quick Deploy

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/openclaw)

## Manual Setup

1. Fork this repo or clone it to your GitHub
2. Create a new project on [Railway](https://railway.app)
3. Connect your GitHub repo
4. Add environment variables (see below)
5. Deploy!

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | Your Anthropic API key for Claude |
| `OPENCLAW_GATEWAY_TOKEN` | Secure token for Gateway auth (generate with `openssl rand -hex 32`) |

## Optional Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENAI_API_KEY` | Alternative to Anthropic API key |
| `TELEGRAM_BOT_TOKEN` | Telegram bot token for Telegram integration |
| `GOG_KEYRING_PASSWORD` | Password for Gmail keyring |

## Post-Deployment

1. Generate a public domain in Railway for your service
2. Access the Gateway UI at your Railway URL
3. Connect your preferred messaging channel (Telegram, WhatsApp, etc.)

## Security Notes

- The `OPENCLAW_GATEWAY_TOKEN` protects access to your Gateway
- By default, DMs from unknown users require approval (pairing)
- Railway provides automatic HTTPS

## Resources

- [OpenClaw Documentation](https://docs.openclaw.ai/)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [Railway Documentation](https://docs.railway.app/)
