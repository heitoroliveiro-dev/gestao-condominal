## O quê e por quê

<!-- O que muda e o motivo. Feature SDD: link para specs/NNN/spec.md e plan.md. Pendência: item do ROADMAP. Requisitos: RF-/RNF-/HU-/CT- atendidos. -->

## Como testar

<!-- Passos para validar localmente. Feature SDD: "roteiros N–M do quickstart.md". -->

## Evidência

<!-- Output do pytest (com contagem antes/depois), comando + retorno, screenshots em celular e desktop. Não basta afirmar que funciona. -->

## Checklist (Definition of Done — completo em docs/checklists/definition-of-done.md)

- [ ] Testes passando; nenhum skip/assert removido; cobertura ≥ 90% domínio / ≥ 80% total
- [ ] Ruff, mypy, pip-audit e `check --deploy` verdes
- [ ] Nenhum segredo hardcoded; nada sensível em log
- [ ] Isolamento entre condomínios e perfil negado com teste
- [ ] Append-only preservado; migração reversível
- [ ] Sem N+1 nas telas tocadas
- [ ] UI: só tokens do design system, checklist por tela, celular + desktop
- [ ] Doc atualizada (ADR/CHANGELOG/contrato/runbook) quando aplicável
- [ ] Review por subagente contra o plan.md (feature SDD) — achados abaixo
- [ ] Nada fora do escopo alterado

## Escopo

- [ ] Feature não trivial — passou pelo fluxo SDD completo
- [ ] Mudança trivial — SDD dispensado propositalmente (motivo: …)

## Autoria

- [ ] Código de produção escrito pelo autor
- [ ] Trechos escritos pela IA a pedido do autor: <arquivos/tarefas>

## Achados de review / decisões durante a implementação

<!-- O que o analyze/review encontrou e o que foi feito. Decisões que mudaram o plano e onde foram registradas. -->
