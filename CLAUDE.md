# CLAUDE.md — Gestão de Condomínio (nome provisório)

> Hub de contexto lido pelo agente em toda sessão. **Máximo ~200 linhas e ~15 KB.** Este arquivo indexa, não duplica: detalhe vive em `docs/`, histórico em `CHANGELOG.md`, contrato de feature em `specs/`.

## O que é

Sistema web para condomínios pequenos (8–50 unidades) com síndico morador: cobrança com comprovante e recibo, chamados com prova de resolução, comunicados e feed de transparência.
**Norte:** *transparência com prova — toda ação relevante fica registrada com autor, data e prova, e ninguém consegue apagá-la.*
Fonte de verdade do produto: `recref/visao-geral-da-solucao.md` (mover para `docs/00-discovery/` ao criar o repositório — ver `docs/00-discovery/README.md`).

## Stack (imutável sem ADR)

- **Backend/UI:** Python 3.12+, Django 5.2 LTS, templates + HTMX (sem SPA) — ADR-004
- **Banco:** PostgreSQL 17 · **Arquivos:** object storage S3 privado (MinIO em dev)
- **Arquitetura:** monólito modular multi-tenant, um app Django por contexto delimitado — ADR-001/002/006
- **UI:** design system `../design-system/linear` v1.0.0 — tokens + Tailwind v4 (CLI standalone, sem Node no pipeline); componentes reimplementados como templates Django — ADR-011
- **Qualidade:** pytest, pytest-django, factory_boy, Playwright, Ruff, mypy, pip-audit
- **Infra:** Docker Compose, Caddy/Nginx, VPS, GitHub Actions

Versões confirmadas na doc oficial na Sprint 1 — nunca confiar em memória do agente.

## Regras imutáveis (hard constraints)

- NUNCA uma consulta retorna dado de outro condomínio. Todo modelo tenant-scoped tem `condominio_id` e teste de isolamento.
- NUNCA UPDATE/DELETE em auditoria, linha do tempo de chamado, comprovante, decisão, recibo ou item do feed. Correção = novo registro. (Única exceção: reações do feed e o campo `fixado`.)
- Acesso negado por padrão: toda view verifica vínculo/papel ativo **no escopo** (condomínio + unidade). Recurso de terceiro → 404.
- NUNCA SQL cru (`.raw()`, `.extra()`, `cursor`) nem `mark_safe`/`|safe` em dado de usuário sem ADR.
- NUNCA dado financeiro por unidade, chamado privado ou dado pessoal no feed, em log ou no Sentry.
- NUNCA commitar segredos (`.env`, chaves). Variáveis de ambiente.
- Dinheiro em centavos (inteiro). Datas com fuso `America/Sao_Paulo`, `USE_TZ=True`.
- Regra de negócio em `domain.py`/`services.py`, nunca em view ou template. Módulo só fala com outro pelo serviço público dele.
- UI: só tokens semânticos do design system (nunca hex/rgb nem paleta padrão do Tailwind); reutilizar componentes de template; uma ação primária por região; estado nunca só por cor. Regras: `docs/06-design/diretrizes-design.md`. Arquivos gerados do DS nunca são editados aqui.
- NUNCA commit direto ou force push em `main`. Branch + PR com CI verde. NUNCA `--no-verify`.
- Nenhuma feature não trivial sem o fluxo SDD.

Constituição: `.specify/memory/constitution.md` (após `/speckit-constitution`; insumo em `docs/01-architecture/constitution-insumo.md`) — manter coerente com esta lista **no mesmo commit**.

## Modo de autoria (OE-08)

O código de produção é **escrito pelo autor** (projeto de aprendizado de Python). O agente: especifica junto, planeja, quebra tarefas, revisa, explica, aponta bugs, roda testes e mostra evidência. Só escreve código de produção quando o autor pedir explicitamente para aquela tarefa — e isso fica registrado no PR.

## Fluxo SDD (GitHub Spec Kit)

**Constitution → Specify → Clarify → Plan → Checklist → Tasks → Analyze → Implement** → review por subagente contra `plan.md` → validação ao vivo (`quickstart.md`, celular e desktop) → PR com evidência.

Triagem obrigatória antes de qualquer código: `docs/checklists/triagem.md`. Tocou em modelo de dados, escopo de condomínio, permissão, append-only, dinheiro, visibilidade do feed ou LGPD → **SDD**. Bug de ~1 arquivo ou UI no padrão existente → trilha rápida (plan mode + teste + evidência). Na dúvida, SDD.

Brownfield dentro do próprio projeto: todo `/speckit-plan` lista os **consumidores atuais** do que vai mudar.

## Definition of Done (resumo — completo em `docs/checklists/definition-of-done.md`)

- [ ] Testes passando (output com contagem); nenhum skip/assert removido
- [ ] Cobertura ≥ 90% domínio / ≥ 80% total
- [ ] Ruff + mypy + pip-audit + `check --deploy` verdes
- [ ] Isolamento entre condomínios e perfil negado com teste
- [ ] Append-only preservado; migração reversível e revisada
- [ ] Sem N+1 nas telas tocadas (teste de nº de queries)
- [ ] Doc atualizada (ADR/CHANGELOG/contrato/runbook)
- [ ] Review por subagente contra `plan.md` (feature SDD)
- [ ] Evidência anexada no PR

## Verificação: evidência, não afirmação

Critérios checáveis ("recibo da unidade 102 acessado pela 101 → 404"), nunca interpretáveis ("está seguro"). Proibido `skip`, assert removido ou teste afrouxado. Todo bug corrigido ganha teste de regressão que falha antes do fix.

## Comandos

```
# (definidos na feature 001-fundacao-tecnica, Sprint 1)
# dev:     docker compose up
# test:    pytest
# e2e:     pytest tests/e2e
# lint:    ruff check . && ruff format --check .
# types:   mypy src
# audit:   pip-audit
# migrate: python manage.py migrate
```

## Fase atual

- **Fase:** F0 — Discovery (Sprint 0, out–dez/2026). Sem código até jan/2027.
- **Próximo:** responder Q-01 (síndico aceita o piloto) e rodar `/speckit-constitution` com o insumo.
- Histórico: `docs/ROADMAP.md` e `CHANGELOG.md` (não duplicar aqui).

## Índice de documentação (carregar sob demanda)

| Preciso de... | Vá para |
|---|---|
| Como conduzo o projeto | `docs/PLAYBOOK-CONDUCAO.md` |
| Segurança, desempenho, disponibilidade… e como cada um é garantido | `docs/ATRIBUTOS-DE-QUALIDADE.md` |
| O que/onde/quando documentar | `docs/GUIA-DOCUMENTACAO.md` |
| Fases, marcos, pendências | `docs/ROADMAP.md` |
| O produto (RF/RNF, modelo, personas) | `docs/00-discovery/README.md` → `recref/` |
| Decisões de arquitetura | `docs/01-architecture/adr/` |
| Segurança e LGPD | `docs/02-security/estrategia-seguranca.md` |
| Testes | `docs/03-testing/estrategia-testes.md` |
| Logs, health, alertas | `docs/04-observability/estrategia-observabilidade.md` |
| Operação (deploy, backup, restore) | `docs/05-runbooks/` |
| Telas, componentes, tokens | `docs/06-design/diretrizes-design.md` → `../design-system/linear` (`AGENTS.md`, `docs/`) |
| Checklists (sessão, triagem, gates, DoD) | `docs/checklists/` |
| Branches, commits, hooks | `CONTRIBUTING.md` |

## Papel do agente neste projeto

- Pedido vago recebe pergunta antes de qualquer artefato.
- Não assumir comportamento de Django/HTMX/libs — consultar doc oficial da versão em uso.
- Sinalizar overengineering ("precisamos disso hoje?"), abstração sem segundo caso de uso, desvio de SOLID/DRY/KISS.
- Antes de mexer em estrutura existente: impacto, mudança pequena e reversível, rollback.
- Decisão com mais de um caminho: alternativas + recomendação; o autor decide e vira ADR.
- Usar a linguagem ubíqua do glossário (`recref/visao-geral-da-solucao.md` §17) em código, specs e conversa.
- Ideia nova no meio de uma tarefa → `docs/ROADMAP.md`, não o diff atual.
