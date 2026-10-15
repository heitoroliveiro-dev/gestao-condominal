# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e versionamento [SemVer](https://semver.org/lang/pt-BR/). Antes do código, registra também decisões de produto e de processo.

> Entradas anteriores (idealização v0.1 e feed v0.2, 2026-10-15): `recref/changelog.md` — unificar aqui ao mover `recref/` para `docs/00-discovery/` (ROADMAP, pendência nº 3).

## [Não lançado]

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
