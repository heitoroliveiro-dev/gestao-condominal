# 00 — Discovery (fonte de verdade do produto)

Os documentos de descoberta ainda estão em `recref/`. Ao criar o repositório (pendência nº 3 do ROADMAP), movê-los para esta pasta sem alterar o conteúdo:

| Hoje | Destino | Conteúdo |
|---|---|---|
| `recref/visao-geral-da-solucao.md` | `docs/00-discovery/visao-geral-da-solucao.md` | Problema, objetivos, personas, RF/RNF numerados, modelo de dados, estados, plano de testes, cronograma, riscos, fora de escopo, glossário |
| `recref/spec-feed-transparencia.md` | `docs/00-discovery/spec-feed-transparencia.md` | Pré-especificação do feed — vira insumo do `/speckit-specify` na Sprint 10 |
| `recref/questoes-em-aberto.md` | `docs/00-discovery/questoes-em-aberto.md` | Questões Q-01 a Q-10 |
| `recref/changelog.md` | unificar em `/CHANGELOG.md` | Decisões de produto de 2026-10-15 |

## Como estes documentos se ligam ao SDD

- Os IDs `RF-*`, `RNF-*`, `HU-*` e `CT-*` são citados em `spec.md`, `plan.md`, `tasks.md`, testes e código. Não renumerar.
- Cada feature do Spec Kit **recorta** um pedaço da visão geral; a `spec.md` da feature passa a ser o contrato dela. Se a feature mudar uma decisão da visão geral, a visão geral é atualizada no mesmo PR (e o `CHANGELOG` registra).
- A seção "Fora de escopo" (§16) é o filtro anti-escopo: ideia nova só entra com gatilho atendido.
