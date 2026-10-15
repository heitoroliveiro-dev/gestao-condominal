# Definition of Done

## Toda entrega (SDD ou trilha rápida)

**Testes e qualidade**
- [ ] Testes passando — output anexado com contagem
- [ ] Nenhum teste pulado, removido ou afrouxado (contagem antes/depois conferida)
- [ ] Bug corrigido tem teste de regressão que falhava antes
- [ ] Cobertura ≥ 90% no domínio e ≥ 80% no total
- [ ] Ruff (lint + formato) e mypy sem erros
- [ ] Código de produção entendido pelo autor (consegue explicar)

**Segurança e privacidade**
- [ ] Nenhum segredo hardcoded; nada sensível em log
- [ ] Validação de entrada nos pontos novos (form, UUID, allowlist de ordenação/filtro)
- [ ] Isolamento entre condomínios com teste (`dois_condominios`)
- [ ] Perfil negado e recurso de terceiro → 404 com teste
- [ ] Nenhum padrão proibido (`.raw`, `.extra`, `cursor`, `mark_safe`, `csrf_exempt`) sem ADR
- [ ] `pip-audit` e `check --deploy` verdes

**Integridade e desempenho**
- [ ] Registros com valor de prova continuam append-only (teste)
- [ ] Efeitos colaterais (e-mail) em `on_commit`, sem quebrar o fluxo principal
- [ ] Telas de lista tocadas sem N+1 (teste de nº de queries)
- [ ] Migração revisada, reversível e testada para frente e para trás

**UI (se houve tela)**
- [ ] Só tokens semânticos do design system; nenhuma cor literal
- [ ] Componentes de template reutilizados; uma ação primária por região
- [ ] Checklist por tela de `docs/06-design/diretrizes-design.md` §8
- [ ] Screenshot em celular e desktop, dark e light

**Fechamento**
- [ ] Doc/contrato que descreve o comportamento atualizado
- [ ] Nada fora do escopo alterado
- [ ] CI verde

## Adicional para feature SDD

- [ ] Todo FR da spec implementado, cada um com teste que o prova
- [ ] Edge cases da spec cobertos
- [ ] `tasks.md` 100% `[X]` (ou pendências ⚠️ explícitas)
- [ ] `/speckit-analyze` rodou antes da implementação; CRITICAL/HIGH resolvidos
- [ ] Review por subagente contra `plan.md`; achados corrigidos e suíte reexecutada
- [ ] Roteiros do `quickstart.md` validados ao vivo (celular e desktop), com evidência
- [ ] Artefatos refletem o código final (plan/research atualizados se o design mudou)
- [ ] ADR para decisão arquitetural nova
- [ ] Visão geral atualizada se a feature mudou uma decisão dela
- [ ] CHANGELOG + fase/ROADMAP atualizados após o merge
