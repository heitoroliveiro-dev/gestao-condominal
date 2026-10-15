# ADRs — Registro de Decisões de Arquitetura

> Quando: decisão com mais de um caminho e custo de reverter. Teste: *"alguém pode perguntar daqui a 6 meses por que isso foi feito assim?"* → ADR agora, **antes** de implementar.
> Formato: `adr-template.md`. Nome do arquivo: `adr-NNN-titulo-curto.md` (numeração de 3 dígitos, já usada na visão geral).
> Nunca reescreva um ADR aceito: crie outro que o marca como "substituído por ADR-NNN".

## Índice

| ADR | Decisão | Status | Onde está o conteúdo hoje |
|---|---|---|---|
| ADR-001 | Monólito modular em vez de microsserviços | proposto | `visao-geral` §10.1 |
| ADR-002 | Multi-tenant com esquema compartilhado e `condominio_id` (alternativa: esquema por condomínio) | proposto | `visao-geral` §10.1 |
| ADR-003 | Aplicação web responsiva única com PWA, sem app nativo no MVP | proposto | `visao-geral` §8, `changelog` |
| ADR-004 | Django + HTMX renderizado no servidor em vez de API + SPA | proposto | `visao-geral` §8 |
| ADR-005 | Histórico append-only (auditoria, comprovantes, chamados, feed) — **inclui o mecanismo no banco** | proposto | `visao-geral` §6, §11 |
| ADR-006 | Núcleo + módulos ativáveis por condomínio | proposto | `visao-geral` §10.1 |
| ADR-007 | Sem integração bancária no MVP; pagamento comprovado por anexo | proposto | `changelog` |
| ADR-008 | Chat entre moradores descartado | proposto | `visao-geral` §16 |
| ADR-009 | Clean Architecture pragmática (serviços de aplicação; portas só para dependências externas) | proposto | `visao-geral` §9 |
| ADR-010 | Feed sem posts de moradores nem comentários; só reações positivas | proposto | `recref/spec-feed-transparencia.md` §7 |
| ADR-011 | Design system Linear como padrão de UI: tokens e regras integrais, Tailwind v4 via CLI standalone, componentes reimplementados como templates Django; ajustes de produto (tema inicial, borda de input AA, densidade no celular). Responde à Q-10 | proposto | `docs/06-design/diretrizes-design.md` §1–2 |

Os arquivos dos ADRs ainda não foram escritos de propósito: o **porquê** e as alternativas saem do autor; a IA só formata (ver `docs/GUIA-DOCUMENTACAO.md` §6). Pendência nº 5 do ROADMAP.
