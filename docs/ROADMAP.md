# Roadmap — Gestão de Condomínio

> Mantenha "Onde estou agora" curto e sempre verdadeiro. O detalhe de cada entrega vive em `specs/`, no PR e no `CHANGELOG.md`, não aqui.
> Cronograma e esforço detalhados: `docs/00-discovery/visao-geral-da-solucao.md` §14.

## Onde estou agora

**Fase atual:** F0 — Discovery (Sprint 0) · **Próximo marco:** M1 — primeira competência paga com recibo pelo sistema
**Próxima ação:** conversar com o síndico (Q-01); escrever os ADRs (pendências 5 a 7).
**Bloqueios:** Q-01 bloqueia todo o MVP; Q-08 bloqueia o piloto.

## O Norte

Transparência com prova: toda ação relevante fica registrada com autor, data e prova, e ninguém consegue apagá-la.

## Etapas até o produto

| # | Etapa | O que entrega | Depende de | Pronto quando | Status |
|---|---|---|---|---|---|
| F0 | Discovery (Sprint 0, out–dez/2026) | Visão geral, questões respondidas, backlog do MVP, termo de dados | — | Q-01, Q-02, Q-04, Q-07 respondidas; "fora do v1" revisado com o síndico | em andamento |
| F1 | Arquitetura (dez/2026) | Spec Kit instalado, constituição 1.0.0, ADR-001 a 009 aceitos | F0 | Todo ADR crítico "aceito" com alternativas; constituição ratificada | |
| F2 | Fundação técnica (Sprint 1, jan/2027) — `specs/001-fundacao-tecnica` | Repo, Docker, CI, hooks, settings por ambiente, auth, modelo de tenant com teste de isolamento | F1 | Matriz de gates de `ATRIBUTOS-DE-QUALIDADE.md` funcionando (commit com `.env` bloqueado, PR vermelho não merge) | |
| F3.1 | Estrutura do condomínio (Sprint 2) — `002` | Unidades, pessoas, vínculos, papéis, convites, aprovação | F2 | HU-06, HU-07, HU-09 com teste de aceitação | |
| F3.2 | Cobranças (Sprint 3) — `003` | Competência, comprovante, upload seguro | F3.1 | HU-01, HU-02; CT-03, CT-05 | |
| F3.3 | Decisão e recibo (Sprint 4) — `004` | Confirmar/recusar, recibo PDF, histórico, auditoria | F3.2 | HU-03, HU-05; CT-01, CT-04, CT-08 | |
| F3.4 | Painel e comunicados (Sprint 5) — `005` | Painel do síndico, tela inicial com proto-feed, leitura, e-mail | F3.3 | HU-04, HU-08; CT-09 | |
| F4 | Produção (Sprint 6, abr/2027) — `006` | Hardening, LGPD, backup testado, deploy VPS, PWA, runbooks | F3.4, Q-08 | Restore testado (CT-10); deploy com rollback ensaiado; `check --deploy` limpo | |
| ⭐ M1 | **Piloto assistido** | Primeira competência real gerada, paga e com recibo emitido pelo sistema | F4, Q-01 | Recibo real emitido; síndico não emitiu recibo fora do sistema naquele mês | |
| ⭐ M2 | **Piloto validado** | Métrica de sucesso do piloto | M1 | 3 meses com 100% das cobranças no sistema e ≥ 70% das unidades com responsável ativo | |
| F5 | v2 — Chamados (Sprints 7–9) e Feed (Sprint 10) | Chamados com prova e contestação, 2FA síndico, feed completo | M1 | HU-10 a HU-12, HU-FEED-01 a 04; CT-11 a CT-15 | |
| F6 | v3 — Obrigações e documentos (Sprints 11–13) | Agenda de obrigações, documentos, itens no feed | F5 | RF-OBR, RF-DOC com teste | |

Numeração das features (`specs/NNN-nome`, branch `feat/NNN-nome`) é atribuída pelo Spec Kit na hora do `/speckit-specify`; os números acima são a intenção.

## Pendências antes do próximo marco

| # | Item | Origem | Triagem | Status / PR |
|---|---|---|---|---|
| 1 | Instalar Spec Kit (`specify init --here --integration claude --script sh`, v1.2.0) e `git init` | adoção SDD 2026-10-15 | chore | ✅ feito — `chore/speckit-init` |
| 2 | Rodar `/speckit-constitution` com o insumo e ratificar 1.0.0 | adoção SDD | chore | ✅ feito — `docs/constituicao` |
| 3 | Mover `recref/` para `docs/00-discovery/` e unificar `recref/changelog.md` no `CHANGELOG.md` | adoção SDD | chore | ✅ feito — `chore/mover-discovery` |
| 4 | Atualizar `visao-geral` §9 e §10.3: specs em `specs/` (Spec Kit) e ADRs em `docs/01-architecture/adr/` | divergência com o método | docs | ✅ feito — `chore/mover-discovery` |
| 5 | Escrever ADR-001 a 009 a partir das decisões da visão geral (o autor dá o porquê; a IA formata) | `visao-geral` §10.4 | docs | rascunhos 001–010 em `docs/adrs-rascunho`; falta o autor fechar as Lacunas |
| 6 | ADR-005 deve escolher o mecanismo de append-only no banco (trigger vs. `REVOKE`) | `ATRIBUTOS-DE-QUALIDADE` §3 | ADR | |
| 7 | Escrever ADR-011 (adoção do design system) decidindo os ajustes de `docs/06-design` §2; marcar Q-10 como respondida | design system 2026-10-15 | ADR | |
| 8 | Feature 001: confirmar Tailwind v4 CLI standalone com o `globals.css` do DS (import `tw-animate-css`) | `docs/06-design` §1 | dentro da 001 | |

## Pendências técnicas (achados de revisão)

| Prioridade | Achado | Risco | Status / PR |
|---|---|---|---|
| — | (nenhuma ainda — sem código) | | |

## Pendências fora do código (⚠️)

| Item | Bloqueado por | O que desbloqueia | Impede o quê |
|---|---|---|---|
| ⚠️ Q-01 síndico aceita ser piloto | Conversa com o síndico | Resposta do síndico | Todo o MVP |
| ⚠️ Q-07 quem formaliza o termo de dados | Síndico + convenção | Termo assinado | M1 |
| ⚠️ Q-08 histórico imutável × direito de exclusão | Consulta jurídica | Parecer registrado | F4 / M1 (RNF-LGPD-06) |
| ⚠️ Q-02, Q-04, Q-05 (aluguel, rateio, conselho) | Síndico / convenção | Respostas registradas | F3.1, F3.2, F3.4 |
| ⚠️ Tempo do autor | TCC até dez/2026 | Janeiro/2027 | Início do código |

## Backlog futuro (fora do escopo atual)

Ver `docs/00-discovery/visao-geral-da-solucao.md` §16 (fora de escopo, com motivo e gatilho de cada item). Ideia nova que surgir no meio de uma tarefa entra aqui com motivo e gatilho, não no diff atual.
