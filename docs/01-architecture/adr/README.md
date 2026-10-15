# ADRs — Registro de Decisões de Arquitetura

> Quando: decisão com mais de um caminho e custo de reverter. Teste: *"alguém pode perguntar daqui a 6 meses por que isso foi feito assim?"* → ADR agora, **antes** de implementar.
> Formato: `adr-template.md`. Nome do arquivo: `adr-NNN-titulo-curto.md` (numeração de 3 dígitos, já usada na visão geral).
> Nunca reescreva um ADR aceito: crie outro que o marca como "substituído por ADR-NNN".

## Índice

| ADR | Decisão | Status | Origem do porquê |
|---|---|---|---|
| [ADR-001](adr-001-monolito-modular.md) | Monólito modular em vez de microsserviços | proposto | `visao-geral` §10.1 |
| [ADR-002](adr-002-multi-tenant-esquema-compartilhado.md) | Multi-tenant com esquema compartilhado e `condominio_id` (alternativa: esquema por condomínio) | proposto | `visao-geral` §10.1 |
| [ADR-003](adr-003-web-responsiva-pwa.md) | Aplicação web responsiva única com PWA, sem app nativo no MVP | proposto | `visao-geral` §8, `changelog` |
| [ADR-004](adr-004-django-htmx.md) | Django + HTMX renderizado no servidor em vez de API + SPA | proposto | `visao-geral` §8 |
| [ADR-005](adr-005-historico-append-only.md) | Histórico append-only (auditoria, comprovantes, chamados, feed) — **inclui o mecanismo no banco** | proposto | `visao-geral` §6, §11 |
| [ADR-006](adr-006-nucleo-modulos-ativaveis.md) | Núcleo + módulos ativáveis por condomínio | proposto | `visao-geral` §10.1 |
| [ADR-007](adr-007-sem-integracao-bancaria-mvp.md) | Sem integração bancária no MVP; pagamento comprovado por anexo | proposto | `changelog` |
| [ADR-008](adr-008-sem-chat-entre-moradores.md) | Chat entre moradores descartado | proposto | `visao-geral` §16 |
| [ADR-009](adr-009-clean-architecture-pragmatica.md) | Clean Architecture pragmática (serviços de aplicação; portas só para dependências externas) | proposto | `visao-geral` §9 |
| [ADR-010](adr-010-feed-sem-posts-de-moradores.md) | Feed sem posts de moradores nem comentários; só reações positivas | proposto | `docs/00-discovery/spec-feed-transparencia.md` §7 |
| ADR-011 | Design system Linear como padrão de UI: tokens e regras integrais, Tailwind v4 via CLI standalone, componentes reimplementados como templates Django; ajustes de produto (tema inicial, borda de input AA, densidade no celular). Responde à Q-10 | proposto | `docs/06-design/diretrizes-design.md` §1–2 |

ADR-001 a 010 são **rascunhos** montados só com texto já escrito pelo autor (visão geral, spec do feed, changelog); nada foi inventado. Cada um tem uma seção **Lacunas** com o que falta o autor decidir ou justificar — resolvidas as lacunas, a seção sai e o status vira "aceito" (ver `docs/GUIA-DOCUMENTACAO.md` §6). ADR-011 ainda não tem arquivo: depende das decisões de `docs/06-design/diretrizes-design.md` §2. Pendências 5 a 7 do ROADMAP.
