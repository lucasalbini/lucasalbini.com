# ADR-0001: Reorganização do site como hub pessoal bilíngue

- **Status:** Aceito; parcialmente substituído pelo [ADR-0002](0002-casa-central-de-conteudo.md) (público, i18n, home e modelo de conteúdo)
- **Data:** 2026-07-28
- **Última atualização:** 2026-10-27 (marcado como parcialmente substituído pelo ADR-0002)
- **Autor:** Lucas Albini

## 1. Contexto e Problema

O site anterior era um CV vertical single-page com seções (hero, skills, experiência, etc.). Não servia bem três públicos distintos:

1. Recrutador/cliente vindo do LinkedIn — precisa entender quem é o autor em 5 segundos.
2. Leitor vindo do Google direto num post — nunca vê a home. Precisa saber quem escreveu, encontrar posts relacionados e ter links de saída.
3. Leitor recorrente — quer ver o que há de novo.

Além disso, o site era só em pt-BR. Um público relevante do LinkedIn é internacional, e boa parte do conteúdo de IA e game dev tem tração maior em inglês.

**Requisitos Funcionais:**
- RF01: Rotas prefixadas por idioma (`/pt`, `/en`) com segmentos de rota traduzidos (`/pt/projetos` ↔ `/en/projects`).
- RF02: Raiz `/` faz negociação por `Accept-Language`, com cookie `NEXT_LOCALE` persistindo escolha manual.
- RF03: Slug de conteúdo por locale (mesmo documento tem slug diferente em cada idioma).
- RF04: `LocaleSwitcher` navega para o equivalente da página atual — não para a home. Sem tradução → botão desabilitado com tooltip.
- RF05: Conteúdo sem tradução ainda aparece na listagem do outro idioma, com badge (não esconder).
- RF06: Home é hub curado — mostra `featured` items, não os mais recentes.
- RF07: Blog post tem `AuthorBio` e `PostsRelacionados` obrigatórios no rodapé.
- RF08: Coleção `lab` deliberadamente NÃO localizada (baixo atrito).

**Requisitos Não-Funcionais:**
- RNF01: SEO correto — `hreflang`, sitemap com `xhtml:link`, RSS por idioma, OG dinâmico com título e summary no idioma.
- RNF02: URLs legadas (`/blog`, `/projects`) redirecionam 301 para o novo prefixo default.
- RNF03: Sem novas deps de infraestrutura além do que já existe (postgres, docker, nginx).
- RNF04: Migração aditiva de dados — nada de perda no CMS.

## 2. Drivers de Decisão

1. **Tornar a página de post a landing mais importante.** A maior parte do tráfego orgânico cai direto em post — ela precisa ter bio, links, relacionados. Home vem depois.
2. **Bilíngue como requisito de arquitetura, não camada.** Afeta CMS, API, frontend e nginx. Introduzir depois seria refazer tudo.
3. **Curadoria manual > algoritmo na home.** O que aparece na home é `featured` + `featured_order`, definido pelo autor. Sem "mais recentes" automático.
4. **Fallback amigável.** Esconder itens sem tradução gera vitrine vazia no início do en. Mostrar com badge é mais honesto e escala melhor.
5. **Zero atrito para "notinha rápida".** A coleção `lab` existe pra reduzir a barreira de publicar algo curto. Sem cover, sem summary, sem tradução.

## 3. Arquitetura Proposta

### 3.1 Visão Geral

```
                       (browser)
                          |
                          v
                     +----------+
                     |  nginx   |  --- /uploads/*  --> volume (direto)
                     |  :80     |
                     +----+-----+
                          |
        +-----------------+-----------------+---------------+
        |                 |                 |               |
     /                /api/            /admin/         /_next/static
        |                 |                 |               |
        v                 v                 v               v
   +---------+       +---------+       +---------+   (cache immutable)
   | frontend|       | fastapi |       |  strapi |
   | Next 15 |<------| DTOs +  |<------|   CMS   |
   |[locale] |       | cache   |       | i18n on |
   +---------+       +---------+       +----+----+
        |                 |                 |
        |            (webhook)              |
        |                 |                 v
        |                 v            +---------+
        +----- POST ------+----------->| postgres|
              /api/                    | +vector |
              revalidate               +---------+
```

### 3.2 Conceitos centrais

- **Locale UI vs. locale API.** URL usa `pt` / `en` (curto, lowercase). API do Strapi usa `pt-BR` / `en`. `apiLocale()` mapeia entre os dois.
- **Documento vs. locale.** Strapi v5 usa `documentId` estável entre locales. Cada locale tem sua própria "entry" desse documento (com `title`, `slug`, `body` traduzidos).
- **Campos compartilhados vs. localizados.** `title/slug/summary/body` são por locale. `cover/status/kind/stack/urls/year/featured/featured_order/tags(relation)` são compartilhados — um post é `featured` nos dois idiomas ou em nenhum.
- **Cache tag por locale.** No FastAPI a chave de cache inclui locale. No Next, cada `fetch()` usa `next.tags: ["posts:pt", "home:pt"]`. Webhook do Strapi ao republicar dispara `revalidateTag("posts:pt")` só para o locale afetado.

### 3.3 Fluxo de Dados — leitura de post

```
GET /pt/blog/meu-post
  |
  v
Next Server Component
  |-- fetch(FastAPI /posts/meu-post?locale=pt-BR, tags: posts:pt:meu-post)
  |     |
  |     v
  |   FastAPI cache miss
  |     |-- GET Strapi /api/posts?locale=pt-BR&filters[slug]=meu-post&populate=cover,tags,localizations
  |     |-- normaliza DTO
  |     |-- extrai available_locales = ['pt-BR', 'en']
  |     v
  |   200 Post{title, body, cover, tags, available_locales}
  |
  |-- fetch(FastAPI /profile?locale=pt-BR, tags: profile:pt)  --> AuthorBio
  |-- fetch(FastAPI /posts?locale=pt-BR&pageSize=20)          --> RelatedPosts (client-side scoring)
  |-- fetch(FastAPI /translations/post/meu-post?locale=pt-BR) --> alternate slugs pro LocaleSwitcher
  v
render:
  <TranslationNotice/>  (só se locale != post.locale)
  <h1>{post.title}</h1> ... <PostBody blocks={post.body}/>
  <AuthorBio profile/>
  <RelatedPosts current={post} candidates={list.data}/>
  <script id="__locale_alternates__">{"pt":"meu-post","en":"my-post"}</script>
```

O `<script>` alimenta o `LocaleSwitcher` no client — ele lê o JSON no mount e usa o slug traduzido correto na navegação. Sem alternates, ele degrada para "mesmo path no outro locale" (que pode 404, esperado).

### 3.4 Fluxo de Dados — publicação com invalidação

```
Editor publica post em Strapi admin
  |
  v
Strapi dispara webhook -> POST http://fastapi:8000/hooks/strapi
                          Header: X-Webhook-Secret: <SHARED>
                          Body: { event: entry.publish, model: api::post.post, entry: {locale: pt-BR, ...} }
  |
  v
FastAPI
  |-- valida secret
  |-- invalidate("posts")               (drop cache local prefix posts::*)
  |-- call_next_revalidate(["posts:pt", "home:pt"])  (locale afetado + home)
       |
       v
    Next -> POST /api/revalidate?tag=posts:pt&secret=<...>
       |-- revalidateTag("posts:pt")
       v
    Próxima request de /pt/blog cai em fetch fresh
```

## 4. Decisões Técnicas

### 4.1 next-intl (frontend)

**Decisão:** next-intl v4 com `defineRouting` + `pathnames` para segmentos traduzidos.

**Justificativa:** É a lib padrão do ecossistema Next 15 App Router, com suporte nativo a Server Components, cookie automático, e mapping de segmentos de rota. Escrever middleware/routing manualmente é reinventar roda.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **next-intl v4** | Zero-config para o essencial, cookie auto, pathnames | Um novo mental model (`defineRouting` novo em v4) |
| next-i18next | Maduro, muita doc | Não suporta App Router bem |
| Middleware próprio | Controle total | Não vale o esforço para o que já existe |

**Notas:** Códigos de URL (`pt`, `en`) são diferentes dos códigos de API (`pt-BR`, `en`). `apiLocale()` centraliza a conversão.

### 4.2 Strapi i18n nativo

**Decisão:** Plugin `@strapi/i18n` (embutido em v5), com `pt-BR` como default e `en` como secundário. Cada content-type marca quais campos são localizados no `pluginOptions.i18n`.

**Justificativa:** Vem embutido, oferece Admin UI para traduzir, mantém `documentId` estável entre locales, expõe `localizations` populável — tudo que precisamos.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **@strapi/i18n** | Nativo, sem lock-in, `documentId` estável | UI de admin ainda pede clicar entre locales |
| String Storage separado por locale | Simples | Perde relação entre versões do mesmo doc |

**Notas:** `slug` também é localizado (`uid` com `pluginOptions.i18n.localized: true`), então o mesmo post pode ter `/pt/blog/meu-post` e `/en/blog/my-post`.

### 4.3 Renomeação de campos → inglês

**Decisão:** Todos os campos de content-type usam inglês (`title`, `body`, `summary`, `cover`, `short_bio`, `long_bio`, `avatar`, `cv_pdf`). Enums de negócio idem, com chaves estáveis: `status: active|paused|archived|experiment`, `kind: game|ai|tool|tutorial`. Labels traduzidos ficam nos messages do frontend, não no CMS.

**Justificativa:** Enum tem que ser estável no banco. Traduzir chave quebra migração. Consistência de idioma nos identificadores reduz atrito ao ler o schema.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Tudo em inglês** | Consistência, enums estáveis, DTOs previsíveis | Autor traduz mentalmente ao editar no admin |
| Nomes em pt-BR no CMS | Autor lê natural | Todos os DTOs e frontend em inglês → dissonância |

### 4.4 FastAPI como camada de agregação

**Decisão:** Manter FastAPI. Ele:
- Normaliza payload aninhado do Strapi v5 em DTOs Pydantic limpos.
- Adiciona `available_locales[]` em cada item.
- Faz cache in-memory com locale na chave.
- Agrega múltiplas queries em endpoints como `/cv`, `/tags/{slug}`.
- Recebe webhooks do Strapi e dispara `revalidateTag` no Next.
- É o ponto onde entram funcionalidades futuras (search com pgvector, RAG, contact form, etc.) sem poluir o CMS.

**Justificativa:** Chamar Strapi direto do Next funciona mas tem três problemas: (1) o payload v5 tem `data.attributes` mesmo depois do "flatten", com nested `data.data` para relações; (2) `available_locales` e outros derivativos exigem lógica; (3) endpoints como `/cv` precisam de 5 fetches paralelos que fica feio no frontend.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Manter FastAPI** | Ponto de extensão, DTOs limpos, cache central | Mais um serviço pra manter |
| Chamar Strapi direto do Next | Menos infra | DTOs esparramados, difícil evoluir |

### 4.5 pgvector desde já (extensão + tabela)

**Decisão:** Trocar imagem do Postgres para `pgvector/pgvector:pg16` e criar tabela `embeddings(kind, content_id, locale, chunk_index, content, embedding vector(1536), metadata)` com índice HNSW cosine no bootstrap. **Nenhum código consome ainda.**

**Justificativa:** Custo ~zero para deixar o terreno pronto. Quando implementarmos "posts relacionados por similaridade" ou `/chat` (RAG), a migration não precisa correr em produção.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **pgvector agora, sem consumo** | Zero custo, remove fricção futura | Nova imagem base do postgres |
| Só quando precisar | Menos surface area agora | Migration futura tem que ser tratada |

### 4.6 Lab não localizado

**Decisão:** Coleção `lab` deliberadamente sem `pluginOptions.i18n`. Cada nota tem enum `language: pt|en` só para exibir badge nas listagens dos dois locales.

**Justificativa:** O ponto do `lab` é baixo atrito. Forçar tradução para publicar cria fricção — resultado esperado: ninguém publica nada.

### 4.7 Home = featured, não recente

**Decisão:** Home mostra apenas items com `featured: true`, ordenados por `featured_order`. Não usar "N mais recentes".

**Justificativa:** Curadoria manual escala melhor para portfolio. Um post técnico bom vale mais na home do que um post recente mediano.

## 5. Infraestrutura

Compose (dev e prod):
- **postgres:** `pgvector/pgvector:pg16` com init script montado em `/docker-entrypoint-initdb.d/`.
- **strapi:** volume nomeado `strapi_uploads` em `/opt/app/public/uploads`.
- **nginx:** mesmo volume `strapi_uploads` em `/var/www/uploads:ro` — serve `/uploads/*` sem hop pelo Strapi.
- **Prod:** Strapi troca `ports: 8421:1337` por `expose: 1337`. Admin acessível só via nginx em `/admin/`.

Comandos:
```bash
docker compose -f docker-compose.dev.yml up -d --build      # dev com hot-reload
docker compose exec -T postgres pg_dump -U strapi -d strapi | gzip > backups/pre-<motivo>-$(date +%Y%m%d).sql.gz
```

## 6. Estrutura do Projeto

```
frontend/
  src/
    middleware.ts                # next-intl middleware (locale detect + redirect + cookie)
    app/
      layout.tsx                 # root: html + body + fontes
      not-found.tsx              # redirect pra /pt
      sitemap.ts robots.ts       # SEO
      api/
        revalidate/route.ts      # POST usado pelo webhook do FastAPI
        og/[locale]/[type]/[slug]/route.tsx  # OG image dinâmica
      [locale]/
        layout.tsx page.tsx not-found.tsx    # home hub
        feed.xml/route.ts        # RSS por locale
        about/ blog/ projects/ lab/ publications/ tags/[tag]/
    components/
      layout/  Header Footer Container LocaleSwitcher ThemeToggle
      cards/   PostCard ProjectCard LabItem
      post/    PostBody AuthorBio RelatedPosts TranslationNotice
      embeds/  ItchEmbed
      ui/      SectionHeading LanguageBadge
    lib/
      i18n/    routing.ts request.ts
      api.ts types.ts format.ts metadata.ts
    providers/Providers.tsx      # next-themes
  messages/ pt.json en.json      # UI strings (nunca conteúdo editorial)

fastapi/
  app/
    main.py config.py
    routers/ profile posts projects lab tags cv translations publications search contact webhooks chat
    schemas/ (DTOs Pydantic)
    services/ strapi_client rate_limit revalidate embeddings

strapi/
  src/
    index.ts                     # bootstrap: cria locales pt-BR/en e permissões públicas find/findOne
    api/
      post/ project/ profile/ tag/ lab/ experience/ education/ certification/ publication/ skill/
    components/shared/ position responsibility social-link

postgres/init/01-init.sql        # pgvector + tabela embeddings + índice HNSW
nginx/nginx.conf                 # roteamento + /uploads do volume + Vary + immutable
docker-compose.yml               # produção
docker-compose.dev.yml           # dev com hot-reload
```

## 7. Segurança

- Strapi API interna não acessível de fora em produção — `expose: 1337` sem `ports:`.
- Webhook do Strapi para FastAPI validado por shared secret (`STRAPI_WEBHOOK_SECRET` em ambos).
- `/api/revalidate` do Next protegido por shared secret (`REVALIDATE_SECRET` em FastAPI e Next).
- Bootstrap do Strapi concede apenas `find` e `findOne` publicamente (nunca `create/update/delete`).
- `/contact` com rate limit in-memory por IP (`CONTACT_MAX_PER_HOUR`).
- `nginx` bloqueia métodos não-GET/HEAD em `/uploads/`.
- `CORS` do FastAPI está `*` — aceitável em dev, apertar em prod (`allow_origins=[NEXT_PUBLIC_SITE_URL]`).

## 8. Riscos e Mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|---|---|---|---|
| Editor publica sem `cover` — post quebra em card com Image obrigatório | Médio | Alta | `cover.required: true` no schema Strapi |
| Slug muda no admin, quebra link antigo | Alto | Média | Draft antes de publicar; futura migration criando redirect 301 automático |
| next-intl v4 breaking change | Médio | Baixa | Pin `^4.13`; docs claras de upgrade |
| Volume `strapi_uploads` corrompe entre migrations | Alto | Baixa | Backup regular via pg_dump + snapshot do volume |
| Fallback de tradução mostra conteúdo estrangeiro sem contexto | Baixo | Alta | `TranslationNotice` sempre no topo quando `post.locale != current` |
| Webhook do Strapi não configurado em prod | Médio | Alta | Docs no README; smoke test manual após deploy |

## 9. Decisões em Aberto

| # | Decisão | Opções | Prazo |
|---|---|---|---|
| D1 | Provider de email pro `/contact` | SES / Resend / Mailgun / SMTP direto | Antes de expor form em prod |
| D2 | Provider de embeddings | OpenAI / Voyage / Local (Ollama) | Quando começar RAG |
| D3 | Analytics | Plausible / Umami / self-hosted | Antes de ir pra prod |
| D4 | CDN na frente do nginx | Cloudflare / Bunny / nenhum | Se tráfego justificar |
| D5 | Search: manter Strapi `$containsi` ou migrar pra tsvector? | Depende de volume de conteúdo | Quando lentidão for perceptível |

## 10. Glossário

- **documentId:** identificador estável do Strapi v5, o mesmo entre locales.
- **available_locales:** lista dos locales em que um documento está publicado, calculada pelo FastAPI a partir de `localizations`.
- **featured / featured_order:** flags de curadoria que decidem o que aparece na home.
- **hub:** a home. Não é blog, não é portfólio — é o índice curto e curado.
- **lab:** coleção de baixo atrito para notas rápidas. Não é localizada.

## 11. Referências

- [Strapi v5 i18n plugin](https://docs.strapi.io/dev-docs/plugins/i18n)
- [next-intl v4 App Router](https://next-intl.dev/docs/getting-started/app-router)
- [pgvector](https://github.com/pgvector/pgvector)
- [Google hreflang guidelines](https://developers.google.com/search/docs/specialty/international/localized-versions)

## 12. Estado da Implementação

### 12.1 Entregue ✅

- Strapi: schemas rework + tag + lab + pgvector bootstrap — `strapi/src/{api,index.ts}`
- FastAPI: routers + DTOs + webhook + cache com locale — `fastapi/app/{routers,schemas,services}`
- Frontend: `[locale]`, home hub, componentes, SEO, RSS, OG dinâmica — `frontend/src/{app,components,lib}`
- Nginx: `/uploads` via volume, `/admin/`, `_next/static` immutable, `Vary` — `nginx/nginx.conf`
- Compose dev + prod: pgvector, volumes compartilhados, prod sem exposição de 1337
- Docs base: `README.md`, `CLAUDE.md` local, `LICENSE`, backup pre-rework

### 12.2 Pendente dentro deste ADR

- Popular conteúdo real via admin do Strapi (profile em pt-BR e en; posts featured; projetos featured; algumas notas de lab).
- Gerar `frontend/src/lib/api-types.ts` a partir do OpenAPI depois do primeiro deploy.
- CI (`.github/workflows/ci.yml`) rodando lint + typecheck em PR pra `dev`.
- Pre-commit hooks (linter + formatter + detect-secrets).

### 12.3 Fora de escopo

- **Embeddings/RAG:** ADR próprio quando começar (usar D2).
- **Analytics:** ADR próprio (usar D3).
- **Contact provider:** ADR próprio se escolher algo além do MVP log-only (usar D1).
- **CDN:** ADR próprio quando volume justificar (usar D4).

### 12.4 Follow-ups de calibração

- Verificar se o cache TTL de 5min do FastAPI + revalidateTag do Next dá boa experiência (posts publicados aparecem rápido).
- Ao publicar primeiros posts em en, revisar se hreflang aponta pra slug correto (LocaleSwitcher usa `<script id="__locale_alternates__">` — validar em real).
- Se `Vary: Accept-Language, Cookie` reduzir hit rate do cache demais na frente (CDN), considerar cachear versões por-cookie separadas apenas quando cookie estiver setado.
