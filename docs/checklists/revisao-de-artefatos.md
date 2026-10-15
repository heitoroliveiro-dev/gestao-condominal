# Checklist de revisão dos artefatos (gates do autor)

## spec.md (após specify/clarify)
- [ ] Nenhuma tecnologia mencionada (nada de "view", "tabela", "HTMX")
- [ ] User stories priorizadas, cada uma testável e valiosa sozinha
- [ ] FRs numerados, verificáveis; referenciam os `RF-*` da visão geral de onde vieram
- [ ] Quem vê cada dado novo está explícito (síndico, responsável financeiro, morador, todos)
- [ ] Success Criteria mensuráveis
- [ ] Edge cases listados (vínculo encerrado, competência duplicada, virada do mês, arquivo inválido…)
- [ ] Fora de escopo explícito
- [ ] Zero `[NEEDS CLARIFICATION]`; clarificações com data e FR afetado

## plan.md e companheiros (após plan)
- [ ] Constitution Check: **cada** princípio (I–VII) com *como* é atendido, não só "✅"
- [ ] Consumidores atuais de tudo que muda foram listados (serviços, views, templates, feed)
- [ ] Reaproveita mecanismos existentes (queryset com escopo, helpers de permissão, componentes de template)
- [ ] `research.md` com alternativas descartadas e por quê
- [ ] `data-model.md`: `condominio_id`, constraints no banco, índices, migração up/down e efeito em dados existentes
- [ ] `contracts/`: serviço público do módulo (entradas, saídas, erros) e permissão por rota
- [ ] `quickstart.md`: roteiros checáveis (ação → resultado esperado), incluindo perfil negado e outro condomínio
- [ ] Telas novas citam os componentes do design system que usarão
- [ ] Decisão arquitetural nova tem ADR
- [ ] Toda afirmação ("teste X existe", "função Y já faz Z") é verdadeira — conferir

## tasks.md (após tasks)
- [ ] Toda tarefa tem caminho de arquivo e cabe numa sessão curta
- [ ] Foundational contém só o bloqueante real (ex.: a migration)
- [ ] Todo FR aparece em pelo menos uma tarefa
- [ ] Teste antes da implementação em toda lógica não trivial
- [ ] Testes de invariante presentes: isolamento, perfil negado, append-only, N+1
- [ ] Tarefas que dependem de ação externa marcadas com ⚠️
- [ ] Checkpoints ao fim de cada fase

## Prompt do review por subagente (após implement)

```
Revise o diff desta branch contra specs/NNN/plan.md, spec.md, tasks.md e a constituição.
Reporte com arquivo:linha e severidade:
1. Todo FR tem implementação E teste que o prova.
2. Toda afirmação do plan.md sobre testes/arquivos é verdadeira.
3. Cada princípio da constituição é atendido no código — em especial isolamento
   entre condomínios, append-only e acesso negado por padrão.
4. Edge cases da spec têm teste.
5. Arquivos tocados fora do escopo do plano.
6. Testes pré-existentes removidos, pulados ou afrouxados (compare a contagem).
7. Templates: cor literal, componente do design system ignorado, falta de label/aria.
Não corrija; só reporte.
```
