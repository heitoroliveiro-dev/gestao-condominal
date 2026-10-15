# Contribuindo

## Branches (trunk-based)

- `main` — sempre deployável. Protegida: PR obrigatório, CI obrigatório, sem force push.
- `feat/NNN-nome` — feature SDD (mesmo número da pasta `specs/NNN-nome/`).
- `feat/<nome>` / `fix/<nome>` — trilha rápida.
- `docs/<nome>` — documentação.
- `chore/<nome>` — tooling, dependências, atualização do design system (`chore/ds-vX.Y.Z`).

Branches curtas: uma feature, um PR.

## Commits

[Conventional Commits](https://www.conventionalcommits.org/pt-br/v1.0.0/), validado no `commit-msg`:

```
<tipo>(<escopo opcional>): <descrição no imperativo, minúsculo, sem ponto final>
```

Tipos: `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`.
Escopo = módulo: `feat(pagamentos): exige motivo ao recusar comprovante`.

Versionamento do produto: SemVer, com tag a cada release (MVP = `v0.1.0`).

## Hooks (instalados na feature 001)

1. **pre-commit:** `scripts/check-no-secrets.sh` → Ruff (lint + formato) nos arquivos staged.
2. **commit-msg:** Conventional Commits.

Hook falhou? Conserte o problema. **Nunca** `--no-verify`.

## CI (obrigatório para merge)

`lint` · `types` · `test` (com cobertura) · `security` (pip-audit, `check --deploy`, gitleaks) · `e2e` · `build` (imagem + `/health`). Detalhe em `docs/ATRIBUTOS-DE-QUALIDADE.md` → Matriz de gates.

## Fluxo

- Toda demanda passa pela triagem: `docs/checklists/triagem.md`.
- Feature não trivial: SDD completo (ver `CLAUDE.md`).
- Bug de ~1 arquivo / tela no padrão existente: trilha rápida.

## Definition of Done

`docs/checklists/definition-of-done.md` e o template de PR. Evidência anexada é obrigatória.
