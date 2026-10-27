# lucasalbini.com

Site pessoal do Lucas Albini — hub bilíngue (pt-BR / en) para blog, projetos, laboratório e publicações.

## Stack

- **Frontend** — Next.js 15 (App Router), TypeScript, Tailwind v4, next-intl
- **API** — FastAPI (Python 3.12), Pydantic v2, camada de agregação sobre o Strapi
- **CMS** — Strapi v5.36 (i18n nativo, Draft & Publish, Postgres)
- **Banco** — Postgres 16 com extensão pgvector (preparo para busca semântica)
- **Proxy** — nginx roteando `/`, `/api/`, `/admin`, `/uploads`

## Rodando localmente

Pré-requisito: Docker Engine + Compose v2.

```bash
# subir tudo (dev, com hot-reload)
docker compose -f docker-compose.dev.yml up -d --build

# ver logs de um serviço
docker compose -f docker-compose.dev.yml logs -f strapi

# derrubar preservando dados
docker compose -f docker-compose.dev.yml down

# derrubar apagando volume postgres (recomeça do zero)
docker compose -f docker-compose.dev.yml down -v
```

URLs:

| Serviço | URL |
|---|---|
| Site (via nginx) | http://localhost |
| Frontend direto | http://localhost:3000 |
| FastAPI / Swagger | http://localhost:8000/docs |
| Strapi Admin | http://localhost:1337/admin |
| Postgres | localhost:5432 (user/db `strapi`) |

Variáveis de ambiente: copie `.env.example` para `.env` e preencha. Secrets do Strapi são obrigatórios — sem eles o CMS não sobe.

## Restaurar backup do Postgres

```bash
gunzip -c backups/<arquivo>.sql.gz | docker compose -f docker-compose.dev.yml exec -T postgres psql -U strapi -d strapi
```

## Estrutura

Ver `CLAUDE.md` local para convenções de código e organização.

```
frontend/   Next.js App Router com [locale] segment
fastapi/    Camada de agregação/normalização + rotas públicas
strapi/     CMS (content-types em src/api/, componentes em src/components/)
nginx/      Configuração do proxy
backups/    Dumps do Postgres (versionados)
docs/adr/   Architecture Decision Records
```

## Branches

- `main` — trabalho ativo
- `dev` — integração (todas as PRs vão pra cá)
- `prod` — produção (merge manual do dev pelo mantenedor)

## Licença

MIT — veja `LICENSE`.
