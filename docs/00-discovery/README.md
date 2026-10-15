# 00 — Discovery (fonte de verdade do produto)

Documentos de descoberta, movidos de `recref/` em 2026-10-15 (histórico preservado pelo `git mv`).

| Documento | Conteúdo |
|---|---|
| `visao-geral-da-solucao.md` | Problema, objetivos, personas, RF/RNF numerados, modelo de dados, estados, plano de testes, cronograma, riscos, fora de escopo, glossário |
| `spec-feed-transparencia.md` | Pré-especificação do feed — vira insumo do `/speckit-specify` na Sprint 10 |
| `questoes-em-aberto.md` | Questões Q-01 a Q-10 |

O antigo `recref/changelog.md` foi unificado no `/CHANGELOG.md`.

## Como estes documentos se ligam ao SDD

- Os IDs `RF-*`, `RNF-*`, `HU-*` e `CT-*` são citados em `spec.md`, `plan.md`, `tasks.md`, testes e código. Não renumerar.
- Cada feature do Spec Kit **recorta** um pedaço da visão geral; a `spec.md` da feature passa a ser o contrato dela. Se a feature mudar uma decisão da visão geral, a visão geral é atualizada no mesmo PR (e o `CHANGELOG` registra).
- A seção "Fora de escopo" (§16) é o filtro anti-escopo: ideia nova só entra com gatilho atendido.
