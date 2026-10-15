# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e versionamento [SemVer](https://semver.org/lang/pt-BR/). Antes do código, registra também decisões de produto e de processo.

> Entradas anteriores (idealização v0.1 e feed v0.2, 2026-10-15): `recref/changelog.md` — unificar aqui ao mover `recref/` para `docs/00-discovery/` (ROADMAP, pendência nº 3).

## [Não lançado]

### 2026-10-15 — Constituição 1.0.0

#### Adicionado
- `.specify/memory/constitution.md` **v1.0.0**, ratificada a partir de `docs/01-architecture/constitution-insumo.md`: 7 princípios (I isolamento, II append-only e V TDD inegociáveis; III acesso negado por padrão, IV LGPD, VI domínio com fronteiras, VII DoD com evidência), restrições técnicas, fluxo de desenvolvimento e governança (Constitution Check antes e depois do design; `CLAUDE.md` coerente no mesmo commit de emenda).

#### Alterado
- `constitution-insumo.md` marcado como histórico; `CLAUDE.md` e `ROADMAP` apontam para a constituição ratificada.

### 2026-10-15 — Repositório e Spec Kit

#### Adicionado
- Repositório git em `github.com/heitoroliveiro-dev/gestao-condominal`, com `.gitignore` (segredos, caches, mídia, binário do Tailwind).
- GitHub Spec Kit **v1.2.0** (`specify init --here --integration claude --script sh`): `.specify/` (templates, scripts, workflow) e skills `/speckit-*` em `.claude/skills/`. `.specify/memory/constitution.md` ainda é o template vazio até o `/speckit-constitution`.

#### Decidido
- Spec Kit fixado na release v1.2.0 (não no `main` do repositório, que é versão dev). Na v1.2.0 a flag `--ai` virou `--integration`.
- Sem a extensão `git` do Spec Kit: o `/speckit-specify` não cria branch; o branch `feat/NNN-nome` é criado à mão (`CONTRIBUTING.md`).
- Proteção de `main` no GitHub não configurada: a regra "nada direto em `main`" segue por disciplina.

#### Corrigido
- `scripts/check-no-secrets.sh` acusava a si mesmo (`SECRET_PATTERN='...'`); variável renomeada para `PADRAO_SEGREDO`, sem abrir exceção na trava.

### 2026-10-15 — Estrutura de desenvolvimento SDD

#### Adicionado
- `CLAUDE.md`: hub de contexto (Norte, stack, regras imutáveis, modo de autoria, fluxo SDD, DoD, fase atual, índice).
- `docs/ATRIBUTOS-DE-QUALIDADE.md`: segurança, privacidade, integridade, desempenho, disponibilidade, manutenibilidade e usabilidade, cada um com RNF de origem, trava determinística e evidência; matriz de gates de CI/hooks.
- `docs/01-architecture/constitution-insumo.md`: insumo para `/speckit-constitution` com 7 princípios (3 inegociáveis: isolamento entre condomínios, prova imutável, TDD não mascarado).
- `docs/01-architecture/adr/`: template e índice dos ADR-001 a 011.
- `docs/02-security`, `03-testing`, `04-observability`, `05-runbooks`: estratégias de segurança/LGPD, testes, observabilidade e plano de runbooks.
- `docs/06-design/diretrizes-design.md`: adoção do design system `../design-system/linear` v1.0.0 em Django + HTMX.
- `docs/PLAYBOOK-CONDUCAO.md`, `docs/GUIA-DOCUMENTACAO.md`, `docs/ROADMAP.md`, `docs/checklists/` (DoD, triagem, sessão, revisão de artefatos).
- `CONTRIBUTING.md`, `.github/pull_request_template.md`.
- `scripts/check-no-secrets.sh` (pre-commit) e `scripts/context-reminder.sh` + `.claude/settings.json` (lembrete de regras a cada prompt do Claude Code).

#### Decidido
- Método: SDD com GitHub Spec Kit (`../sdd-method`), com triagem SDD × trilha rápida.
- Código de produção escrito pelo autor; IA especifica, planeja, revisa e mostra evidência (OE-08).
- Padrão de design: design system Linear — tokens e regras integralmente, componentes reimplementados como templates Django (ADR-011, proposto). Responde à Q-10 em favor do Tailwind v4 via CLI standalone.
- Specs em `specs/NNN-nome/` (Spec Kit) e ADRs em `docs/01-architecture/adr/`, no lugar de `docs/specs/` e `docs/adr/` citados na visão geral.

#### Segurança
- Padrão de detecção de segredos ajustado para não diferenciar maiúsculas e aceitar sufixos: o padrão original do método não detectava `SECRET_KEY = "..."` do Django.
