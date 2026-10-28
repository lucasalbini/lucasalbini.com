# ADR-0002: Site como casa central de conteúdo, só em português

- **Status:** Proposto
- **Data:** 2026-10-27
- **Última atualização:** 2026-10-28 (D1 resolvida: `/admin` restrito à Tailnet no Caddy)
- **Autor:** Lucas Albini

Substitui do ADR-0001 as decisões de público (§1), i18n (RF01–RF05, §4.1, §4.2), home curada como vitrine profissional (§4.7) e a separação post/projeto/lab. Continuam valendo: FastAPI como camada de agregação (§4.4), nginx servindo `/uploads` do volume, Strapi isolado, pgvector, nomes de campo e enums em inglês (§4.3).

## 1. Contexto e Problema

O ADR-0001 desenhou um hub profissional bilíngue para três públicos: recrutador, leitor do Google e leitor recorrente. Na prática, o site ficou vazio e o objetivo mudou:

- O foco profissional fica no **LinkedIn**. O site é para quem acompanha o Lucas: amigos, seguidores, recrutadores curiosos.
- O site é a **casa central** do que ele publica. O Instagram é a vitrine (reel curto), o YouTube é a versão em vídeo e o site guarda a versão completa e permanente: texto, fotos, mapas, lugares, restaurantes, links, downloads.
- Os assuntos são variados: viagens, projetos, ideias, vida, trabalho. Alguns conjuntos (ex.: viagens) podem virar livro físico no futuro, mas isso é opcional e não estrutura o site.
- Escrever cada texto em dois idiomas dobra o trabalho sem público que justifique. O site passa a ser só em português.
- Parte do conteúdo é pessoal: precisa existir conteúdo não listado (só por link) e privado (só no painel, guardado para o livro).

**Requisitos Funcionais:**
- RF01: Um único tipo de conteúdo (`post`) cobre viagem, projeto, ideia, vida e trabalho, diferenciados por `category`.
- RF02: O corpo do post é montado por blocos: texto, imagem, galeria, vídeo do YouTube, post/reel do Instagram, lugares com mapa, download, link e destaque.
- RF03: O post aponta para as versões correspondentes nas redes (`instagram_url`, `youtube_url`).
- RF04: Visibilidade por post: `public` (listado e indexado), `unlisted` (só por link, `noindex`) e `private` (nunca sai pela API pública).
- RF05: Lugares (restaurante, praia, cidade...) são entidades reutilizáveis entre posts, com coordenadas.
- RF06: Coleções opcionais agrupam posts (ex.: "Viagens") em ordem cronológica, como base para um livro.
- RF07: A home mostra quem é o Lucas, as redes, o que ele vive agora, os posts recentes e os últimos vídeos do YouTube (automático via RSS).
- RF08: URLs em português sem prefixo de idioma; links antigos (`/pt/...`, `/en/...`, `/blog/...`) redirecionam com 301.

**Requisitos Não-Funcionais:**
- RNF01: Nenhum serviço novo de infraestrutura.
- RNF02: Integração com o Instagram sem token nem app na Meta (embed oficial manual).
- RNF03: Conteúdo estruturado o bastante para, no futuro, gerar um PDF de impressão de uma coleção sem reescrever nada.
- RNF04: A reativação do inglês no futuro não exige refazer o roteamento (a infraestrutura do next-intl fica, com um locale só).

## 2. Drivers de Decisão

1. **Atrito de publicação baixo.** Se publicar Belém exigir pensar em tradução, tipo de conteúdo ou curadoria, o post não sai.
2. **O post é a unidade de valor.** É ele que circula pelo link na bio, no YouTube e no WhatsApp. Precisa ser rico (mídia, mapa, lugares) e funcionar sozinho.
3. **Conteúdo estruturado, não HTML.** Blocos tipados permitem trocar o visual, gerar PDF e reaproveitar lugares sem migrar texto.
4. **Privacidade é por post, explícita.** O padrão é público, mas privado e não listado precisam ser uma escolha de um clique no painel.
5. **Reversível.** Desligar o inglês não pode significar arrancar o i18n do código.

## 3. Arquitetura Proposta

### 3.1 Visão Geral

A topologia do ADR-0001 não muda (nginx → Next / FastAPI → Strapi → Postgres). Mudam o modelo de conteúdo e o fluxo entre as redes:

```
   Instagram (reel curto)        YouTube (vídeo completo)
          |   ^                         |   ^
   link na bio / legenda        link na descrição
          v   |                         v   |
   +--------------------------------------------------+
   |  lucasalbini.com/viagem-a-belem                  |
   |   texto + galerias + mapa de lugares             |
   |   [embed do reel]   [embed do vídeo]             |
   |   downloads, links, restaurantes                 |
   +--------------------------------------------------+
          ^                                  |
          | Strapi (post em blocos)          | home lista os últimos
          |                                  v vídeos via RSS do canal
```

### 3.2 Conceitos centrais

- **Post:** a versão completa de qualquer coisa que o Lucas viveu ou fez. Tem uma `category` e uma `date` (a data do acontecimento, não da publicação).
- **Bloco:** componente de dynamic zone do Strapi (`blocks.text`, `blocks.gallery`...). O corpo do post é uma lista ordenada de blocos.
- **Lugar (`place`):** entidade com nome, tipo e coordenadas, reutilizada por qualquer post através do bloco `blocks.places`.
- **Coleção (`collection`):** agrupamento opcional (no máximo uma por post). Ordenada por `date` crescente: é o "livro".
- **Visibilidade:** `public` | `unlisted` | `private`. É diferente de rascunho: o Draft & Publish do Strapi continua controlando "pronto ou não"; a visibilidade controla "quem vê".

### 3.3 Fluxo de Dados — publicar o post de Belém

1. No painel, o Lucas cria os lugares "Ver-o-Peso" (`kind: attraction`, -1.4525, -48.5034) e "Restaurante X" (`kind: restaurant`).
2. Cria o post:

```json
{
  "title": "Cinco dias em Belém",
  "slug": "cinco-dias-em-belem",
  "category": "travel",
  "visibility": "public",
  "date": "2026-10-10",
  "summary": "Açaí de verdade, chuva das 15h e o Ver-o-Peso às 6 da manhã.",
  "instagram_url": "https://www.instagram.com/reel/ABC123/",
  "youtube_url": "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
  "collection": "viagens",
  "body": [
    { "__component": "blocks.text", "body": [ "...blocks do editor..." ] },
    { "__component": "blocks.gallery", "images": ["..."], "caption": "Ver-o-Peso, 6h" },
    { "__component": "blocks.places", "title": "Onde comi", "places": ["ver-o-peso", "restaurante-x"] },
    { "__component": "blocks.youtube", "url": "https://youtu.be/dQw4w9WgXcQ" },
    { "__component": "blocks.download", "file": "roteiro.pdf", "label": "Roteiro em PDF" }
  ]
}
```

3. Ao publicar, o webhook do Strapi chama `POST /hooks/strapi` na FastAPI, que invalida o cache `posts` e dispara `revalidateTag("posts")` e `revalidateTag("home")` no Next.
4. `GET /api/posts/cinco-dias-em-belem` devolve o DTO com os blocos normalizados (mídia com `url` absoluta resolvível e lugares com `latitude`/`longitude`).
5. `lucasalbini.com/cinco-dias-em-belem` renderiza cada bloco com o componente correspondente; o bloco de lugares vira um mapa (Leaflet + OpenStreetMap) com a lista ao lado.

### 3.4 Fluxo de Dados — visibilidade

| Visibilidade | `/posts` (listas, home, busca, tag) | `/posts/{slug}` | Sitemap / feed | `robots` |
|---|---|---|---|---|
| `public` | aparece | 200 | aparece | index |
| `unlisted` | não aparece | 200 | não aparece | `noindex` |
| `private` | não aparece | 404 | não aparece | — |

O filtro é aplicado **na FastAPI**: é a única porta pública para o Strapi (nginx não expõe `/api` do Strapi).

### 3.5 Rotas

| Rota | Conteúdo |
|---|---|
| `/` | Home |
| `/[slug]` | Post |
| `/arquivo` | Todos os posts públicos |
| `/arquivo/[categoria]` | `viagens`, `projetos`, `ideias`, `vida`, `trabalho` |
| `/colecoes/[slug]` | Posts de uma coleção, em ordem |
| `/tags/[tag]` | Posts com a tag |
| `/sobre` | Bio e lado profissional (link para o LinkedIn) |
| `/feed.xml` | RSS dos posts públicos |

Rotas estáticas vencem `[slug]` no App Router. Um post com slug igual a uma rota (ex.: `sobre`) fica inacessível; o painel avisa por convenção, não por validação.

## 4. Decisões Técnicas

### 4.1 Um tipo de conteúdo com categoria

**Decisão:** `post` passa a cobrir tudo, com `category: travel|project|idea|life|work`. Os content-types `project` e `lab` deixam de ser usados pelo frontend e ficam no Strapi até o conteúdo ser migrado (remoção em issue própria).

**Justificativa:** Driver 1. Para o Lucas, um projeto e uma viagem são "uma coisa que eu vivi e quero contar". A separação forçava escolher o tipo antes de escrever e duplicava páginas, cards e endpoints.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Post único + categoria** | Um fluxo de publicação, uma página, um card | Campos específicos de projeto (repo, demo) viram blocos `link` |
| Manter post/projeto/lab | Campos dedicados por tipo | Três fluxos para manter; a dúvida de "onde eu ponho isso?" |
| Content-type por categoria | Schema sob medida | Explosão de tipos e de código duplicado |

### 4.2 Corpo em dynamic zone de blocos

**Decisão:** `body` vira dynamic zone com os componentes `blocks.text` (editor rich text do Strapi), `blocks.image` (com `layout: column|wide|full`), `blocks.gallery`, `blocks.youtube`, `blocks.instagram`, `blocks.places`, `blocks.download`, `blocks.link` e `blocks.callout`.

**Justificativa:** Drivers 2 e 3. O editor de blocks do Strapi só tem parágrafo, título, lista, citação, código e imagem; galeria, mapa e vídeo exigiriam shortcodes no texto, frágeis e invisíveis no painel.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Dynamic zone** | Nativa no Strapi, tipada, ordenável no painel | Populate mais verboso na API |
| Markdown/MDX com componentes | Escrever é rápido | Embeds viram sintaxe mágica; o painel não ajuda |
| Só o editor de blocks | Zero mudança | Não comporta galeria, mapa, vídeo nem download |

**Notas:** O renderer do frontend ignora tipos desconhecidos em vez de quebrar, para que um bloco novo no Strapi não derrube páginas antigas.

### 4.3 Português apenas, com a infraestrutura de i18n desligada

**Decisão:** O Strapi deixa de localizar `post`, `profile`, `tag`, `place` e `collection` (o plugin continua instalado). O next-intl continua com um locale só (`pt`) e `localePrefix: "never"`; as pastas `[locale]` permanecem. O `LocaleSwitcher`, a rota `/translations` e o `available_locales` dos DTOs novos saem.

**Justificativa:** Drivers 1 e 5. Remover o next-intl tocaria todas as páginas e mensagens; com um locale e sem prefixo o custo é perto de zero e o inglês volta trocando a config.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **i18n desligado, infra mantida** | URLs limpas, volta barato | Um nível de pasta `[locale]` sem uso aparente |
| Remover next-intl e i18n do Strapi | Código mais simples | Reintroduzir depois é refazer o ADR-0001 |
| Manter bilíngue | Nada a mudar | Dobra o trabalho de escrita; o que travou o site vazio |

**Notas:** Ao desligar a localização de um content-type, o Strapi v5 mantém só as entradas do locale padrão (`pt-BR`). O conteúdo em `en` é descartado: fazer backup antes (comando no `CLAUDE.md`).

### 4.4 Visibilidade aplicada na FastAPI

**Decisão:** Enum `visibility` no post, com default `public`. A FastAPI filtra `public` nas listagens e aceita `public|unlisted` no detalhe. O Next marca `unlisted` com `robots: noindex` e o exclui do sitemap e do feed.

**Justificativa:** Driver 4. A FastAPI já é a única porta pública para o Strapi, então um filtro ali cobre home, arquivo, tags, busca e feed de uma vez.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Enum + filtro na FastAPI** | Um ponto de controle, testável | Esquecer o filtro em endpoint novo vaza o post (mitigado por teste) |
| Usar só Draft & Publish | Nada novo | Não existe "publicado mas não listado" |
| Login para posts privados | Privado de verdade para amigos | Auth, sessão, senha: fora da proporção agora |

**Notas:** `private` não é segurança forte contra quem tem acesso ao servidor; é só "não sai pelo site". Mídia de post privado continua acessível em `/uploads/` para quem souber a URL (nomes têm hash).

### 4.5 Lugares e coleções como content-types

**Decisão:** `place` (name, slug, kind, latitude, longitude, address, city, country, url, note, photo) e `collection` (title, slug, description, cover). O post tem `collection` manyToOne; o bloco `blocks.places` referencia lugares.

**Justificativa:** RF05 e RF06. O mesmo restaurante aparece em mais de um post; coordenadas digitadas uma vez alimentam todos os mapas e, no futuro, um mapa geral.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Content-types próprios** | Reuso, mapa geral possível | Mais um passo no painel antes de escrever |
| Lugar como componente inline no post | Tudo na mesma tela | Duplicação e coordenadas divergentes |

### 4.6 Integrações com redes

**Decisão:**
- **YouTube:** embed por `youtube-nocookie.com/embed/<id>`. A home lê o feed Atom público do canal (`/feeds/videos.xml?channel_id=...`) na FastAPI, com cache. O channel ID fica em `profile.youtube_channel_id`.
- **Instagram:** embed oficial (`blockquote.instagram-media` + `embed.js`), colando a URL do post/reel. Nada automático por enquanto.

**Justificativa:** RNF02. A API do Instagram exige conta profissional e app na Meta; o feed do YouTube é público e sem chave.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **RSS do YouTube + embed manual do Instagram** | Zero credencial | Instagram exige colar o link por post |
| YouTube Data API | Mais metadados | Chave de API e cota |
| Instagram Graph API | Feed automático | Conta profissional, app Meta, token que expira |

### 4.7 Mapa com Leaflet e OpenStreetMap

**Decisão:** Componente client que carrega Leaflet sob demanda, com tiles do OpenStreetMap e atribuição visível.

**Justificativa:** Sem chave nem custo; o volume de um site pessoal cabe na política de uso dos tiles do OSM.

**Alternativas consideradas:**

| Opção | Prós | Contras |
|---|---|---|
| **Leaflet + OSM** | Sem chave, leve | Visual básico dos tiles |
| Google Maps / Mapbox | Visual melhor | Chave, faturamento |
| Só link para o Google Maps | Zero JS | Não "mostra" a viagem |

## 7. Segurança

- `private` nunca sai da FastAPI; coberto por teste de regressão em listagem, detalhe, busca e tag.
- Os embeds de terceiros (YouTube nocookie, Instagram) carregam scripts externos só nas páginas que os usam.
- O RSS do YouTube é XML externo: parse com `defusedxml` e falha silenciosa (lista vazia).
- O acesso ao painel `/admin` em produção é feito exclusivamente via Tailscale (`http://100.116.16.90/admin/` ou `http://vps-hostinger.tail4e77a8.ts.net/admin/`), filtrado por `client_ip 100.64.0.0/10` no `edge-caddy` (`/srv/edge/sites/lucasalbini.caddy`). No domínio público (`lucasalbini.com`), `/admin` e rotas administrativas retornam 404.

## 8. Estratégia de Evolução

| Fase | Escopo | Critério de sucesso |
|---|---|---|
| MVP | Modelo de blocos, visibilidade, rotas pt, home nova, RSS do YouTube | O post de Belém publicado com galeria, mapa, reel e vídeo |
| Depois | Mapa geral de lugares, busca na UI, migração de `project`/`lab` | Lugares de mais de uma viagem num mapa só |
| Livro | Exportar uma coleção para PDF de impressão (Paged.js ou CSS de impressão) | PDF de "Viagens" aceito por uma gráfica sob demanda |

## 10. Riscos e Mitigações

| Risco | Impacto | Probabilidade | Mitigação |
|---|---|---|---|
| Desligar o i18n descarta o conteúdo em `en` | Médio | Alta | Backup antes; prod está vazio |
| Endpoint novo esquece o filtro de visibilidade e vaza post privado | Alto | Média | Filtro centralizado num helper e teste por endpoint |
| Slug de post colide com rota fixa | Baixo | Baixa | Rotas fixas em português e poucas; documentado |
| Embed do Instagram muda ou quebra | Baixo | Média | O bloco sempre mostra o link "ver no Instagram" como fallback |
| Feed do YouTube fora do ar | Baixo | Baixa | Lista vazia; a home esconde a seção |
| Bloco desconhecido no frontend após mudança no Strapi | Médio | Média | O renderer ignora tipos desconhecidos |

## 11. Decisões em Aberto

| # | Decisão | Opções | Prazo |
|---|---|---|---|
| D1 ✅ | Acesso ao `/admin` em produção | Resolvido (#17): Tailscale (`100.64.0.0/10`) no Caddy (`http://100.116.16.90/admin/`) | 2026-10-28 |
| D2 | Destino do conteúdo de `project` e `lab` | Migrar para `post` / descartar | Antes de remover os content-types |
| D3 | Comentários | Nenhum / Giscus / próprio | Fora do escopo por decisão do Lucas |
| D4 | Ferramenta de PDF para coleção | Paged.js / CSS de impressão / LaTeX | Quando a primeira coleção estiver madura |

## 12. Glossário

- **Casa central:** o papel do site em relação às redes: a versão completa e permanente.
- **Bloco:** item da dynamic zone `body` do post.
- **Não listado (`unlisted`):** acessível por link direto, fora de listas, busca e índice.
- **Coleção:** conjunto opcional e ordenado de posts que pode virar livro.

## 13. Referências

- [Strapi v5 — Dynamic zones](https://docs.strapi.io/cms/features/content-type-builder#dynamic-zones)
- [Strapi v5 — Populate de dynamic zones](https://docs.strapi.io/cms/api/rest/populate-select)
- [next-intl — localePrefix](https://next-intl.dev/docs/routing/configuration#locale-prefix)
- [YouTube — feed por canal](https://www.youtube.com/feeds/videos.xml?channel_id=CHANNEL_ID)
- [Instagram — embed](https://help.instagram.com/620154495870484)
- [Leaflet](https://leafletjs.com/) e [política de tiles do OSM](https://operations.osmfoundation.org/policies/tiles/)
- Craig Mod — exemplo de caminhadas registradas que viram livros físicos

## 14. Estado da Implementação

### 14.1 Entregue ✅

- Nada ainda. Issues #1–#8.

### 14.2 Pendente dentro deste ADR

- #3 modelo no Strapi · #4 e #5 FastAPI · #6, #7 e #8 frontend.

### 14.3 Fora de escopo

- Remoção de `project`/`lab` (D2), acesso ao admin (D1), exportação para PDF, comentários e Instagram automático.
