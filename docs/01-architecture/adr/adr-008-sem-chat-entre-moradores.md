# ADR-008 — Chat entre moradores descartado; comunicação via comunicados e chamados

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §10.4, §16; changelog). Sem lacunas de motivo; ver Lacunas para o gatilho.

## Contexto

Moradores já conversam num grupo de WhatsApp. O produto precisa de canais oficiais: comunicados com confirmação de leitura (OE-04) e chamados com prova de resolução (OE-03).

## Decisão

Vamos descartar o chat entre moradores (individual e grupos); a comunicação oficial acontece por comunicados e chamados (§10.4; changelog de idealização, "Descartado").

## Alternativas consideradas

- **Chat entre moradores:** descartado porque o grupo de WhatsApp já existe, tem alto custo, risco de conflito e de moderação (§16).

## Consequências

- **Positivas:** sem custo de moderação nem retenção de conversa livre; foco no que gera prova.
- **Negativas / trade-offs:** moradores continuam no WhatsApp para conversa informal.
- **Riscos e mitigação:** pedido recorrente de "conversar pelo app" → apontar comunicados/chamados; o feed também não aceita posts nem comentários (ADR-010).
- **Impacto nos atributos de qualidade:** privacidade/LGPD (menos dado pessoal livre), manutenibilidade (+).

## Como verificar

Nenhuma rota de mensagem entre moradores; revisão de spec barra a funcionalidade (filtro anti-escopo de §16).

## Lacunas — o autor completa antes de "aceito"

- Decisão sem gatilho de revisão (§16 marca "—"). Confirmar que é definitiva.

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §2 (OE-03, OE-04), §16; `CHANGELOG.md` (Idealização).
