# ADR-004 — Django + HTMX renderizado no servidor em vez de API + SPA

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §2, §8). O que não estava escrito está em **Lacunas**.

## Contexto

Projeto de portfólio escrito pelo autor em Python (OE-08). O objetivo pessoal atual é dominar Python para o trabalho (robôs). Um autor só precisa reduzir código de infraestrutura e focar no domínio (§8).

## Decisão

Vamos usar Python 3.12+, Django 5.2 LTS e templates Django + HTMX: páginas renderizadas no servidor com interatividade pontual (ex.: reagir a item do feed sem recarregar), sem frontend separado — um único deploy e uma única base de código (§8).

## Alternativas consideradas

- **Next.js/NestJS (stack do CigMenu), API + SPA:** não escolhida porque (§8, "Por que não Next.js/NestJS?"):
  - o objetivo pessoal atual é dominar Python para o trabalho;
  - Django entrega autenticação, admin e permissões prontos, reduzindo o volume de código para uma pessoa só;
  - aplicação server-side elimina a complexidade de API + SPA + duas bases de código, coerente com KISS.

## Consequências

- **Positivas:** autenticação, permissões, ORM, migrações, formulários, CSRF e admin prontos; versão LTS com suporte longo (§8).
- **Negativas / trade-offs:** o design system adotado (`../design-system/linear`) é React; os componentes precisam ser reimplementados como templates Django (ADR-011).
- **Riscos e mitigação:** interatividade crescer além do que HTMX atende → só com ADR novo.
- **Impacto nos atributos de qualidade:** segurança (CSRF e autoescape nativos), manutenibilidade (+).

## Como verificar

Sem pipeline Node no build; CSRF ativo e `csrf_exempt`/`mark_safe` bloqueados no CI (`ATRIBUTOS-DE-QUALIDADE` §1).

## Lacunas — o autor completa antes de "aceito"

- Outro framework Python considerado (ex.: FastAPI + templates)? Por que Django?
- Versões confirmadas na doc oficial na Sprint 1 (§8): registrar aqui com link.

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §2 (OE-08), §8.
