# CLAUDE.md — lucasalbini.com

Instruções específicas deste projeto. Sobrepõe `~/.claude/CLAUDE.md` quando houver conflito.

## Visão

Hub pessoal bilíngue (pt-BR default, en). Três públicos:

1. Recrutador vindo do LinkedIn — a home responde "quem é o Lucas?" em 5s.
2. Leitor do Google caindo direto num post — a página de post é a landing mais crítica.
3. Leitor recorrente — quer ver o que há de novo.

A home é hub curado (não é blog, não é portfólio).

## Stack

- Next.js 15 App Router + TypeScript + Tailwind 4 + next-intl
- FastAPI + Pydantic v2 (agregação sobre Strapi, normalização de payloads, cache com locale na chave)
- Strapi v5.36 com i18n nativo, Draft & Publish
- Postgres 16 + pgvector
- nginx como edge

## Convenções

### Nomes de campo
Todos os content-types e DTOs usam **inglês** consistentemente. `title`, `body`, `summary`, `cover`, `short_bio`, `long_bio`, `avatar`, `cv_pdf`. Enums de negócio idem: `status: active|paused|archived|experiment`, `kind: game|ai|tool|tutorial`.

### i18n
- Prefixo obrigatório: `/pt/...` e `/en/...`. A raiz `/` faz redirect 307 baseado em Accept-Language, com cookie `NEXT_LOCALE` persistindo a escolha manual (cookie vence header).
- Segmentos de rota são traduzidos: `/pt/projetos`, `/en/projects`.
- Slugs de conteúdo vêm do Strapi por locale (não geramos por transliteração).
- Fallback quando tradução não existe: **não esconder**. Item aparece na listagem do outro idioma com badge; clique leva à versão existente com aviso oferecendo tradução do navegador.
- Exceção: coleção `lab` **não** é localizada — cada nota aparece nos dois locales no idioma em que foi escrita.
- LocaleSwitcher navega para o equivalente da página atual (via `/translations/{type}/{slug}` na API), nunca para a home. Se não existe tradução, fica desabilitado com tooltip.

### FastAPI
- Cache key sempre inclui `locale`.
- DTOs expõem `available_locales: string[]` por item.
- `publicationState=live` em toda leitura pública.
- Novos endpoints entram em routers dedicados (`profile, posts, projects, lab, cv, tags, search, contact, webhooks, chat`).

### Frontend
- Data fetching **sempre** em Server Components com `fetch` + `next.revalidate` + cache tags que incluem o locale.
- Nada de `useEffect` buscando dado no cliente.
- `AutorBio` e `PostsRelacionados` são **obrigatórios** no rodapé de `blog/[slug]`.
- Todo card de projeto tem imagem. Jogos usam GIF de gameplay, não screenshot estático.

### Direção visual
- Coluna única, largura de leitura 65-75ch, centralizada. Sem sidebar.
- Duas famílias tipográficas: uma para texto, uma monoespaçada.
- Uma cor de destaque (link + tag ativa). Resto: preto, branco, dois cinzas.
- Separação por espaço vertical, não por bordas/caixas.
- Dark mode via `prefers-color-scheme` + toggle persistido.
- Sem gradiente, sombra decorativa ou animação de entrada.

## Comandos

```bash
# subir stack de dev
docker compose -f docker-compose.dev.yml up -d --build

# gerar tipos TS a partir do OpenAPI do FastAPI (após rodar)
cd frontend && npx openapi-typescript http://localhost:8000/openapi.json -o src/lib/api/types.ts

# rodar migration do Strapi manualmente (dentro do container)
docker compose -f docker-compose.dev.yml exec strapi npm run strapi -- database:migrate

# backup
docker compose -f docker-compose.dev.yml exec -T postgres pg_dump -U strapi -d strapi | gzip > backups/pre-<motivo>-$(date +%Y%m%d-%H%M%S).sql.gz
```

## Content-types

**Localizados** (mesmo documento, versão por locale):
- `profile` (single) — name (shared), role, company (shared), location, short_bio, long_bio, avatar (shared), cv_pdf (por locale), social_links (shared)
- `post` — title, slug, body, summary. cover/tags/featured/featured_order/reading_time compartilhados
- `project` — title, slug, body, summary. cover/status/kind/stack/urls/year/featured/featured_order compartilhados
- `tag` — label, slug
- `experience`, `education`, `certification`, `publication`, `skill` — só campos de texto localizados

**Não-localizado:**
- `lab` — title, slug, date, body, external_link, language enum (pt|en para badge)

## Variáveis de ambiente
Ver `.env.example`. As chaves críticas do Strapi (APP_KEYS, JWT_SECRET, ADMIN_JWT_SECRET, API_TOKEN_SALT, TRANSFER_TOKEN_SALT) precisam existir antes do primeiro `up` — senão o container não sobe.

## Não-fazer

- **Não** esconder conteúdo sem tradução — usar badge de fallback.
- **Não** popular strings editoriais nos arquivos `messages/pt.json` ou `messages/en.json` — só UI/labels. Conteúdo vem do Strapi.
- **Não** fazer proxy do `/uploads` pro Strapi — nginx serve direto do volume.
- **Não** expor a API `/api/*` interna do Strapi pro mundo externo — só o FastAPI acessa, pela rede do compose.
- **Não** transliterar slugs — vêm do Strapi.
