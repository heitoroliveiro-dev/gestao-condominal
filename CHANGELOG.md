# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e versionamento [SemVer](https://semver.org/lang/pt-BR/). Antes do código, registra também decisões de produto e de processo.

## [Não lançado]

### 2026-10-15 — Rascunhos dos ADR-001 a 010

#### Adicionado
- `docs/01-architecture/adr/adr-001` a `adr-010`, status "proposto", montados só com o porquê já escrito pelo autor na visão geral, na spec do feed e no changelog; cada um lista as **Lacunas** que o autor precisa fechar antes de "aceito" (ex.: ADR-005 — trigger × `REVOKE`).

### 2026-10-15 — Discovery em `docs/00-discovery/`

#### Alterado
- `recref/` movido para `docs/00-discovery/` sem alteração de conteúdo (`visao-geral-da-solucao.md`, `spec-feed-transparencia.md`, `questoes-em-aberto.md`); entradas de `recref/changelog.md` unificadas neste arquivo (seções "Feed de transparência" e "Idealização", abaixo).
- `visao-geral` §1 (cabeçalho), §9 e §10.3/§10.4: specs em `specs/NNN-nome/` (Spec Kit), ADRs em `docs/01-architecture/adr/`, changelog único na raiz.

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

### 2026-10-15 — Feed de transparência (visão geral v0.2)

#### Adicionado
- `spec-feed-transparencia.md`: regras de negócio, RF-FEED-01 a 09, RNFs, modelagem (ITEM_FEED, REACAO), histórias de usuário com critérios de aceitação e ADR-010.
- Visão geral v0.2 incorporando o feed: objetivo OE-07, seção 5.5 de requisitos, RNF-LGPD-07 e RNF-AUD-04, fluxo "chamado de área comum até o feed", módulo Feed na arquitetura, entidades no modelo de dados, classe ItemFeed, casos de teste CT-11 a CT-15, Sprint 10 no cronograma e termos no glossário.

#### Alterado
- Tela inicial do morador passa a ser o feed (no MVP, lista de comunicados).
- Cronograma: v2 ganha o Sprint 10 (feed, jul/2027); v3 passa para ago–set/2027. Total estimado até v3: ~245 h (antes ~230 h).
- Princípio append-only estendido aos itens do feed; reações são a única exceção.

#### Decidido
- Feed gerado por eventos do sistema (chamados de área comum resolvidos, manutenções concluídas, documentos, comunicados, resumo agregado de adimplência) e por publicações do síndico.
- Síndico gerencia o feed: publica itens próprios e fixa itens; não pode ocultar nem editar itens automáticos.
- Moradores apenas reagem, com reações positivas: Apoio, Gostei, Parabéns.
- Chamado com resolução contestada aparece no feed com esse status.

#### Descartado
- Posts de moradores e comentários no feed.
- Reações negativas (discordância segue pela contestação de chamados).

#### Removido
- Visão geral v0.1 e changelog anterior apagados do Drive (conteúdo preservado nesta versão), a pedido do autor.

### 2026-10-15 — Idealização (visão geral v0.1)

#### Adicionado
- `visao-geral-da-solucao.md` v0.1: problema, objetivos, público-alvo, personas, RF/RNF, histórias de usuário, stack, metodologias, arquitetura, modelagem de dados, diagramas de classe e estados, plano de testes, cronograma, custos, riscos e fora de escopo.
- `questoes-em-aberto.md` com 10 questões pendentes para a Sprint 0.

#### Decidido
- Piloto no prédio do autor, escalando depois para outros condomínios.
- Posicionamento: transparência com prova (histórico imutável, chamados fecham com registro).
- Pagamentos sem integração bancária no MVP: cobrança + comprovante + confirmação + recibo.
- Modelagem Pessoa / Unidade / Vínculo, com papéis no condomínio separados; cadastro por convite ou aprovação do síndico.
- Inadimplência por unidade visível apenas ao síndico.
- Painel do síndico como lista de ação, com entidade Cobrança para saber quem falta pagar.
- Aplicação web responsiva única (PWA) para todos os perfis; sem restrição por dispositivo e sem app nativo no MVP.
- Monólito modular multi-tenant com núcleo + módulos ativáveis por condomínio (não é marketplace).
- Stack proposta: Python + Django 5.2 LTS + HTMX + PostgreSQL.

#### Descartado
- Chat entre moradores (individual e grupos).
- Microsserviços.
- Emissão de nota fiscal para condôminos (taxa condominial é rateio, não prestação de serviço).
