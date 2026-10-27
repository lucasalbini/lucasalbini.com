# CLAUDE.md — lucasalbini.com

Instruções específicas deste projeto. Sobrepõe `~/.claude/CLAUDE.md` quando houver conflito.

## Visão

Casa central do que o Lucas publica, só em português. O Instagram é a vitrine, o YouTube a versão em vídeo e o site a versão completa e permanente: texto, fotos, mapas, lugares, links, downloads. Público: quem acompanha o Lucas (amigos, seguidores, recrutadores curiosos). O foco profissional fica no LinkedIn. Racional em `docs/adr/0002-casa-central-de-conteudo.md`.

## Stack

- Next.js 15 App Router + TypeScript + Tailwind 4 + next-intl (um locale só, sem prefixo)
- FastAPI + Pydantic v2 (agregação sobre Strapi, normalização de payloads, filtro de visibilidade, cache)
- Strapi v5.36, Draft & Publish
- Postgres 16 + pgvector
- nginx como edge

## Convenções

### Nomes de campo
Todos os content-types e DTOs usam **inglês**. Enums também: `category: travel|project|idea|life|work`, `visibility: public|unlisted|private`. Labels em português ficam em `messages/pt.json`.

### Idioma e rotas
- Só português. O next-intl continua com locale único `pt` e `localePrefix: "never"`, para o inglês poder voltar trocando a config. As pastas `[locale]` ficam.
- URLs sem prefixo: `/`, `/[slug]` (post), `/arquivo`, `/arquivo/[categoria]`, `/colecoes/[slug]`, `/tags/[tag]`, `/sobre`, `/feed.xml`.
- Links antigos (`/pt/...`, `/en/...`, `/blog/...`, `/projetos/...`) redirecionam com 301 em `next.config.ts`. Não remover.
- Rota fixa vence `[slug]`: não criar post com slug igual a uma rota.
- Slugs vêm do Strapi (não transliteramos).

### Visibilidade
- `public`: listado, indexado, no sitemap e no feed.
- `unlisted`: só por link direto, com `noindex`.
- `private`: nunca sai pela API pública.
- O filtro é aplicado **na FastAPI**, com helper central e teste. Endpoint novo que lista posts precisa usá-lo.

### FastAPI
- `publicationState=live` em toda leitura pública.
- Novos endpoints entram em routers dedicados.
- Cache key inclui todos os parâmetros da query.

### Frontend
- Data fetching **sempre** em Server Components com `fetch` + `next.revalidate` + cache tags.
- Nada de `useEffect` buscando dado no cliente. Componente client só para interação (mapa, tema).
- O corpo do post é uma lista de blocos (`blocks.*`). Cada tipo tem um renderer; tipo desconhecido é ignorado, nunca quebra a página.
- `AuthorBio` e posts relacionados são obrigatórios no rodapé do post.
- O post mostra os links para a versão no Instagram e no YouTube quando existem.

### Direção visual
- Uma grade só: header, páginas e rodapé usam `Container size="wide"` (max-w-5xl), com a mesma margem esquerda no desktop. Nada de colunas estreitas centralizadas.
- Post no desktop (`lg`): coluna de informações fixa à esquerda (`PostMeta`) e conteúdo à direita. No celular, tudo numa coluna, com as informações sob o título.
- Mídia (imagem, galeria, mapa, vídeo) nunca é mais larga que o texto. Única exceção: `layout: full` vai de ponta a ponta no celular.
- Listas (home, arquivo, tags, coleções): card de destaque e depois grade de cards iguais (3 colunas no desktop).
- Corpo do texto de 17px (celular) a 20px (desktop).
- Duas famílias tipográficas: uma para texto, uma monoespaçada.
- Uma cor de destaque (link + tag ativa). Resto: preto, branco, dois cinzas.
- Separação por espaço vertical, não por bordas/caixas.
- Dark mode via `prefers-color-scheme` + toggle persistido.
- Sem gradiente, sombra decorativa ou animação de entrada.

## Comandos

```bash
# subir stack de dev
docker compose -f docker-compose.dev.yml up -d --build

# gerar tipos TS a partir do OpenAPI do FastAPI (após stack rodando)
cd frontend && npm run gen:api

# rodar migration do Strapi manualmente (dentro do container)
docker compose -f docker-compose.dev.yml exec strapi npm run strapi -- database:migrate

# backup
docker compose -f docker-compose.dev.yml exec -T postgres pg_dump -U strapi -d strapi | gzip > backups/pre-<motivo>-$(date +%Y%m%d-%H%M%S).sql.gz
```

## Content-types

- `post` — title, slug, summary, cover, category, visibility, date (do acontecimento), instagram_url, youtube_url, tags, collection, featured, `body` (dynamic zone de `blocks.*`)
- `blocks.*` (componentes) — text, image, gallery, youtube, instagram, places, download, link, callout
- `place` — name, slug, kind, latitude, longitude, address, city, country, url, note, photo
- `collection` — title, slug, description, cover. Posts de uma coleção são ordenados por `date` crescente.
- `profile` (single) — name, role, location, short_bio, long_bio, now, avatar, cv_pdf, social_links, youtube_channel_id
- `tag` — label, slug
- `experience`, `education`, `certification`, `publication`, `skill` — alimentam `/sobre`; ainda localizados (só pt-BR é usado)
- `project`, `lab` — legados, fora do frontend. Remoção depende de migrar o conteúdo (ADR-0002, D2).

## Variáveis de ambiente
Ver `.env.example`. As chaves críticas do Strapi (APP_KEYS, JWT_SECRET, ADMIN_JWT_SECRET, API_TOKEN_SALT, TRANSFER_TOKEN_SALT) precisam existir antes do primeiro `up` — senão o container não sobe.

## Não-fazer

- **Não** servir post `private` por nenhum endpoint público.
- **Não** popular strings editoriais nos arquivos `messages/pt.json` ou `messages/en.json` — só UI/labels. Conteúdo vem do Strapi.
- **Não** fazer proxy do `/uploads` pro Strapi — nginx serve direto do volume.
- **Não** expor a API `/api/*` interna do Strapi pro mundo externo — só o FastAPI acessa, pela rede do compose.
- **Não** transliterar slugs — vêm do Strapi.

## Decisões
Ver `docs/adr/0002-casa-central-de-conteudo.md` (modelo atual) e `docs/adr/0001-i18n-e-arquitetura-do-hub.md` (agregação FastAPI, nginx, pgvector; a parte de i18n foi substituída). Toda decisão arquitetural nova entra como ADR novo (consultar `~/.claude/CLAUDE.md` seção "ADRs" e template).
