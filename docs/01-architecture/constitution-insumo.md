<!--
Insumo para /speckit-constitution. NÃO copiar direto para .specify/memory/:
entregar este texto ao comando, revisar, e deixá-lo gerar o arquivo oficial
(com Sync Impact Report e checagem dos templates).
Depois de ratificada, qualquer mudança aqui vira emenda versionada e a linha
correspondente do CLAUDE.md é atualizada no mesmo commit.
-->

# Gestão de Condomínio Constitution

## Core Principles

### I. Isolamento entre condomínios (NON-NEGOTIABLE)
Toda entidade com dado de condomínio tem `condominio_id`. Nenhuma consulta da
aplicação retorna dado de outro condomínio: o acesso passa por queryset com
escopo obrigatório. Todo serviço e toda view que lê ou escreve dado
tenant-scoped tem teste de integração, com dois condomínios, provando que o
condomínio A não lê nem escreve dado do condomínio B.

**Rationale**: vazamento entre condomínios destrói a confiança no produto e é
irremediável — expõe finanças e dados pessoais de vizinhos (RNF-SEG-04).

### II. Prova imutável — append-only (NON-NEGOTIABLE)
Eventos de auditoria, linha do tempo de chamados, comprovantes, decisões,
recibos, comunicados e itens do feed nunca sofrem UPDATE nem DELETE pela
aplicação; correção gera novo registro vinculado ao anterior. A proteção
existe no código e no banco. Exceções nomeadas: reações do feed e o campo
`fixado` do item do feed. Evento de origem e item do feed são gravados na
mesma transação.

**Rationale**: é o posicionamento do produto ("transparência com prova"). Um
registro apagável não prova nada, nem para o morador nem para o síndico
honesto (RNF-AUD-01 a 04).

### III. Acesso por vínculo e papel, negado por padrão
Cada requisição verifica vínculo ou papel **ativo** no escopo do recurso
(condomínio e unidade). O padrão é negar; acesso é liberado explicitamente em
`permissions.py`. Recurso de terceiro responde 404, sem revelar existência.
Identificadores em URL são UUID. Todo guard é conferido contra os FRs da spec
atual — nunca copiado de módulo similar. Toda view nova tem teste de perfil
negado.

**Rationale**: dados financeiros e pessoais de vizinhos; IDOR é a falha mais
provável num sistema por unidade (RNF-SEG-03, RNF-SEG-05).

### IV. Privacidade por padrão (LGPD)
Coleta-se só o necessário a cada funcionalidade. Situação financeira por
unidade é visível apenas ao síndico (e ao conselho, se a convenção previr).
Feed, prestação de contas e resumos mostram apenas agregados. Log, Sentry e
mensagens de erro nunca contêm senha, token, conteúdo de comprovante, dado
financeiro por unidade ou dado pessoal além do necessário. Menores não têm
conta.

**Rationale**: o condomínio é controlador e a plataforma é operadora; o
síndico é um vizinho operando dados de vizinhos (RNF-LGPD-01 a 07).

### V. TDD com testes não mascarados (NON-NEGOTIABLE)
Red → green → refactor nas regras de domínio (transições de estado,
permissões, visibilidade do feed, cálculo de atraso). Critérios Gherkin das
histórias viram testes de aceitação. Proibido skip, xfail sem motivo
registrado, remoção de assert ou afrouxamento de expectativa para passar.
Teste falhou → corrige o código. Todo bug corrigido ganha teste de regressão
que falha antes do fix. Cobertura mínima: 90% no domínio, 80% no total.

**Rationale**: mascarar teste destrói a rede de segurança; é uma falha já
observada em agentes de IA (RNF-MAN-01).

### VI. Domínio no centro, módulos com fronteira
Cada contexto delimitado é um app Django. Regras de negócio ficam em
`domain.py` (puras) e `services.py` (casos de uso), nunca em views, forms ou
templates. Views são finas. Um módulo só usa outro pelo serviço público dele,
nunca pelos modelos internos. Portas/interfaces só onde há dependência externa
real (armazenamento, e-mail, PDF, pagamentos). Abstração exige segundo caso de
uso concreto.

**Rationale**: um autor só, poucas horas por semana; o código precisa ser
legível e mudável sem medo, e Clean Architecture completa brigaria com o
Django (ADR-009).

### VII. Definition of Done com evidência
Nada é concluído por afirmação. Critérios checáveis; evidência anexada ao PR
(output de teste com contagem, comando + retorno, screenshot em celular e
desktop). Todo diff de feature SDD passa por review de subagente contra o
`plan.md`. Documentação (ADR, CHANGELOG, contrato, runbook) faz parte do DoD.

**Rationale**: revisar evidência é mais rápido e confiável que confiar em quem
implementou — inclusive um agente.

## Restrições técnicas

- **Banco:** só ORM do Django. `.raw()`, `.extra()` e `cursor` proibidos, salvo
  exceção registrada em ADR. Ordenação e filtros dinâmicos via allowlist.
  Unicidade e invariantes estruturais garantidas por constraint no banco, não
  só em Python.
- **Web:** CSRF sempre ativo; `csrf_exempt`, `mark_safe` e `|safe` em dado de
  usuário proibidos sem ADR. HTTPS + HSTS; `check --deploy` sem avisos.
- **Uploads:** allowlist JPEG/PNG/PDF por conteúdo, máx. 10 MB, bucket privado,
  URL assinada com expiração, SHA-256 gravado.
- **Segredos:** só em variáveis de ambiente; pre-commit e CI bloqueiam.
- **Dinheiro e tempo:** valores em centavos (inteiro); `USE_TZ=True`, fuso
  `America/Sao_Paulo`; status derivados ("atrasada") são calculados, nunca
  gravados à mão.
- **Efeitos colaterais:** e-mail e notificação via `transaction.on_commit`;
  falha neles é logada e nunca desfaz nem bloqueia o fluxo principal.
- **Desempenho:** telas de lista sem N+1, com teste de número de consultas;
  listas que crescem são paginadas.
- **Operação:** migrations rodam no deploy de forma idempotente; `/health`
  verifica banco e migrations; backup diário fora do servidor com restore
  testado mensalmente.
- **Interface:** padrão visual é o design system Linear (`designsystem-linear`).
  Templates usam só tokens semânticos (nunca cor literal), reutilizam os
  componentes de template e cumprem o checklist de acessibilidade por tela
  (WCAG AA). Estado nunca é comunicado só por cor.
- **Stack:** Python + Django 5.2 LTS + HTMX + PostgreSQL. Troca de stack, lib
  estrutural ou padrão estabelecido exige ADR.

## Fluxo de desenvolvimento

Feature não trivial: Constitution → Specify → Clarify → Plan → Checklist →
Tasks → Analyze → Implement → review por subagente → validação ao vivo.
Mudança em modelo de dados, escopo de condomínio, permissão, append-only,
dinheiro, visibilidade do feed ou dado pessoal sempre passa pelo fluxo
completo. Trilha rápida só para bug de ~1 arquivo ou UI no padrão existente,
sem dispensar teste, evidência, hooks e CI.

Código de produção é escrito pelo autor; o agente especifica, planeja, revisa
e mostra evidência, e só escreve código de produção quando o autor pedir para
a tarefa específica (registrado no PR).

## Governance

Esta constituição prevalece sobre convenções que a contradigam. Emendas exigem
registro do que mudou e por quê, nova versão e checagem de impacto em
`.specify/templates/`, `CLAUDE.md` e `plan.md` de features em andamento.

Versionamento: MAJOR = remover ou afrouxar princípio; MINOR = princípio novo ou
expansão material; PATCH = redação.

Complexidade que viole um princípio exige justificativa no `plan.md`
(Complexity Tracking), não só no código.

**Version**: 1.0.0 | **Ratified**: AAAA-MM-DD | **Last Amended**: AAAA-MM-DD
