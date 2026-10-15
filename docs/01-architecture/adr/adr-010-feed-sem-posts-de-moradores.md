# ADR-010 — Feed sem posts de moradores nem comentários; só reações positivas

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Transcrição para o template do ADR-010 já escrito pelo autor em `spec-feed-transparencia.md` §7, complementado pelo changelog do feed (2026-10-15) e por `visao-geral` §15–16.

## Contexto

Desejo de um feed do condomínio (OE-07: tornar visível aos moradores o que é feito, por meio de um feed gerado pelas próprias ações registradas); chat entre moradores já descartado (ADR-008).

## Decisão

Vamos ter um feed de transparência gerado por eventos do sistema e por publicações do síndico; moradores apenas reagem com reações positivas (Apoio, Gostei, Parabéns); sem posts livres nem comentários. O síndico publica e fixa itens, mas não pode ocultar nem editar itens automáticos.

## Alternativas consideradas

- **Posts de moradores e comentários:** descartados — concorrência com o grupo de WhatsApp, conflitos públicos, moderação a cargo do síndico e retenção de conteúdo livre sob LGPD.
- **Reações negativas:** descartadas — discordância tem canal formal na contestação de chamados.

## Consequências

- **Positivas:** feed com baixo custo de moderação e alto valor de transparência.
- **Negativas / trade-offs:** só reações positivas exigem que o canal de contestação (chamados) seja visível e funcione bem, para o feed não parecer propaganda.
- **Riscos e mitigação:** feed percebido como propaganda do síndico → itens automáticos não ocultáveis; chamado com resolução contestada aparece no feed com esse status (§15; changelog do feed).
- **Impacto nos atributos de qualidade:** privacidade/LGPD (só agregados, sem conteúdo livre), integridade (itens append-only — ADR-005).

## Como verificar

CT-11 a CT-15 (`visao-geral` §13.2); teste genérico de que nenhum tipo de item do feed contém dado proibido (`ATRIBUTOS-DE-QUALIDADE` §2).

## Referências

`docs/00-discovery/spec-feed-transparencia.md` §7; `visao-geral` §2 (OE-07), §15, §16; `CHANGELOG.md` (Feed de transparência).
