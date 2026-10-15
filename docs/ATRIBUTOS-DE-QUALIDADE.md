# Atributos de Qualidade — como cada um é garantido

> Para cada atributo: de onde vem (RNF), qual princípio da constituição o protege, **qual trava determinística o garante** e qual evidência fecha a entrega.
> Regra-mãe do SDD: **regra que precisa ser garantida vai em hook, CI ou teste — não só no `CLAUDE.md`.** Quando uma regra "de conselho" for violada uma vez, promova-a para uma camada mais forte.

## Camadas de trava (da mais fraca à mais forte)

| Camada | Garante | Pode ser ignorada? |
|---|---|---|
| `CLAUDE.md` + lembrete do hook do Claude Code | Contexto e regras | Sim — é conselho |
| Constituição + Constitution Check no `plan.md` | Todo plano responde a cada princípio | Só se o autor aprovar sem ler |
| Review por subagente contra `plan.md` | Afirmações dos artefatos são verdadeiras | Só se pulado |
| Pre-commit (segredos, Ruff, commit-msg) | Nada entra sem passar | Só com `--no-verify` (proibido) |
| Teste automatizado | Comportamento provado | Não, se o CI é obrigatório |
| CI obrigatório + branch protection em `main` | Nada chega em `main` quebrado | Não |

---

## 1. Segurança

**Origem:** RNF-SEG-01 a 10. **Princípios:** I (isolamento), III (acesso negado por padrão).

| Ameaça | Controle | Trava | Evidência |
|---|---|---|---|
| Vazamento entre condomínios | `condominio_id` em todo modelo tenant-scoped; manager/queryset padrão que exige escopo | Teste de isolamento com a fixture `dois_condominios` para **todo** serviço e view tenant-scoped (CT-02) | Teste "síndico de A lê B → vazio/404" verde |
| IDOR (recurso de outra unidade) | UUID em URL; busca sempre via helper com escopo, nunca `Model.objects.get(pk=...)` solto | Teste "unidade 101 acessa recibo da 102 → 404" (CT-01); review procura `.get(pk=` fora do helper | Output do teste |
| Permissão errada | `permissions.py` por módulo; nega por padrão; conferida contra os FRs da spec, nunca "copiada do molde" | Teste de **perfil negado** obrigatório por view nova (ex.: CT-06) | Output do teste |
| Injeção SQL | Só ORM | Ruff com regras `S` (bandit) e `DJ` (flake8-django); CI falha em `.raw(`, `.extra(`, `cursor(` fora de lista permitida por ADR | Job `lint` verde |
| XSS | Autoescape do Django; HTMX só troca HTML renderizado no servidor | CI falha em `mark_safe`/`\|safe` fora de lista permitida | Job `lint` verde |
| CSRF | Middleware ativo; token enviado pelo HTMX | `csrf_exempt` proibido sem ADR (grep no CI) | Job `lint` verde |
| Upload malicioso | Allowlist JPEG/PNG/PDF pelo **conteúdo**, máx. 10 MB, bucket privado, URL assinada com expiração, SHA-256 | Testes CT-05 (`.exe` renomeado → rejeitado) e "URL expirada → negado" | Output do teste |
| Senha / força bruta | Argon2; limite de tentativas em login e recuperação | Teste de configuração do hasher; teste "N+1ª tentativa → bloqueio" (N definido na spec) | Output do teste |
| Transporte | HTTPS + HSTS, cookies `Secure`/`HttpOnly`, `SESSION_COOKIE_SAMESITE` | `python manage.py check --deploy --fail-level WARNING` no CI com settings de produção | Job `security` verde |
| Segredo no repositório | `.env` fora do git | Pre-commit `scripts/check-no-secrets.sh` + gitleaks no CI | Commit com `.env` bloqueado (teste da trava) |
| Dependência vulnerável | Lockfile; atualização consciente | `pip-audit` bloqueante no CI | Job `security` verde |
| Conta de síndico comprometida | 2FA para síndico (v2, RNF-SEG-09) | Teste de fluxo 2FA | — (v2) |

Detalhe e modelo de ameaças: `docs/02-security/estrategia-seguranca.md`.

## 2. Privacidade e LGPD

**Origem:** RNF-LGPD-01 a 07, RNF-FEED-02. **Princípio:** IV (privacidade por padrão).

| Regra | Trava | Evidência |
|---|---|---|
| Inadimplência por unidade só para o síndico | Teste "morador comum abre painel → negado" (HU-04) | Output do teste |
| Feed só com agregados; nunca chamado privado | Teste CT-11 e CT-12 + teste genérico que gera todos os tipos de item e procura dados proibidos | Output do teste |
| Log/Sentry sem dado pessoal | Filtro de log que remove campos sensíveis + teste do filtro; Sentry com `send_default_pii=False` | Output do teste |
| Aceite de termos registrado | Teste "primeiro acesso sem aceite → redireciona" | Output do teste |
| Anonimização ao encerrar vínculo | ⚠️ bloqueada por Q-08 (consulta jurídica) — não implementar antes da resposta | Resposta registrada em `questoes-em-aberto.md` |

## 3. Integridade e confiabilidade (o coração do posicionamento)

**Origem:** RNF-AUD-01 a 04, RF-PAG-09, RF-CHA-06. **Princípio:** II (prova imutável).

| Regra | Controle | Trava |
|---|---|---|
| Append-only | Modelos sem caminho de update/delete na aplicação **e** proteção no banco (mecanismo decidido no ADR-005: trigger ou `REVOKE UPDATE, DELETE` para o papel da aplicação) | CT-08 (editar auditoria via aplicação → bloqueado) + teste de UPDATE/DELETE direto no banco com o papel da aplicação → falha (ADR-005) |
| Evento + item do feed atômicos | `transaction.atomic` no serviço de origem | Teste CT-15: falha no feed desfaz a resolução |
| Efeito colateral não quebra o fluxo | E-mail/notificação via `transaction.on_commit`; falha logada, nunca propagada | Teste "provedor de e-mail falha → cobrança confirmada mesmo assim" |
| Sem duplicidade | `UniqueConstraint` **no banco** (cobrança por unidade+competência, reação por pessoa+item, um comprovante pendente por cobrança, um responsável financeiro ativo) | Teste CT-03, CT-14 e testes de constraint |
| Dinheiro exato | Objeto de valor `Dinheiro` em centavos | Teste unitário; review procura `float`/`Decimal` solto em valor |
| Arquivo íntegro | SHA-256 gravado no upload | Teste "hash gravado = hash do conteúdo" |
| Status derivado não é digitado | "Atrasada" calculada de vencimento + hoje (fuso SP) | Teste unitário com relógio fixo na virada do dia |
| Auditoria | `EVENTO_AUDITORIA` em toda ação relevante, com antes/depois | Teste por ação listada no RNF-AUD-01 |

## 4. Desempenho

**Origem:** RNF-DES-01, RNF-DES-02, RNF-FEED-01.

| Regra | Trava | Evidência |
|---|---|---|
| Sem N+1 no painel, feed e históricos | Teste com `django_assert_max_num_queries` (pytest-django) em cada tela de lista, com 50 unidades (CT-09) | Output do teste |
| Paginação em listas que crescem | Spec/contrato define tamanho de página; teste da 2ª página | Output do teste |
| Índices para os filtros reais | `data-model.md` de cada feature lista índices (sempre começando por `condominio_id`) | Revisão do `plan.md` |
| p95 < 500 ms com 50 condomínios | Comando de seed com volume realista + medição antes da Sprint 6; em produção, p95 a partir dos logs | Relatório de medição anexado ao PR de produção |
| Cache | **Só com medição que justifique** (anti-overengineering) | ADR se adotado |

## 5. Disponibilidade e operação

**Origem:** RNF-DIS-01 (99%/mês no piloto), RNF-BKP-01/02, RNF-OBS-01.

| Regra | Trava | Evidência |
|---|---|---|
| Health check reflete capacidade real | `/health` verifica conexão **e** migrations aplicadas; deploy só é promovido se passar (lição: health verde com banco vazio) | Teste do endpoint com migration pendente → falha |
| Migrations no deploy | Rodam de forma idempotente no deploy, antes de trocar o tráfego | Runbook de deploy + log do deploy |
| Imagem de produção válida | Job `build` faz build + run + `/health` da imagem Docker (lição: entrypoint movido em silêncio) | Job `build` verde |
| Rollback | Imagem anterior marcada; migration com `down` testado | Runbook de deploy com rollback ensaiado |
| Backup diário fora do servidor, 30 dias | Cron + verificação de que o arquivo do dia existe | Runbook de backup |
| Restore testado todo mês (CT-10) | Lembrete recorrente; registro de cada teste no runbook | Data + resultado do último restore |
| Saber que caiu antes do síndico | Monitor externo de uptime batendo em `/health` + Sentry | Alerta de teste recebido |

Detalhe: `docs/04-observability/` e `docs/05-runbooks/`.

## 6. Manutenibilidade

**Origem:** RNF-MAN-01 a 04. **Princípio:** VI (domínio no centro, módulos com fronteira).

| Regra | Trava |
|---|---|
| Cobertura ≥ 90% domínio / ≥ 80% total | `pytest --cov` com `fail-under` no CI |
| Lint e formatação | Ruff no pre-commit e no CI |
| Tipagem no domínio | mypy no CI para `*/domain.py` e `*/services.py` (ampliar gradualmente) |
| Fronteiras entre módulos e camadas | Contratos de import verificados no CI (candidato: import-linter — decidir na feature 001): domínio não importa views/infra; módulo não importa `models` de outro |
| Decisões rastreáveis | ADR antes de implementar; `FR-xxx` citado em comentário quando o porquê não é óbvio |
| Histórico legível | Conventional Commits no `commit-msg`; um PR por feature/fix |
| Código entendido pelo autor | Passo "ENTENDER" do loop de sessão; autor escreve o código de produção |

## 7. Usabilidade e compatibilidade

**Origem:** RNF-USA-01 a 05. **Padrão visual:** design system `../design-system/linear` (detalhe em `docs/06-design/diretrizes-design.md`).

| Regra | Trava |
|---|---|
| Consistência visual | Só tokens semânticos do DS: CI falha em cor literal (hex/rgb/hsl) em templates e CSS do projeto; hash dos arquivos gerados do DS conferido contra `VERSION` |
| Contraste | Validado no build do próprio DS (falha abaixo de 4,5:1 texto / 3:1 não texto); borda de input em AA estrito (decisão do ADR-011) |
| Celular primeiro | E2E Playwright dos fluxos críticos em viewport de celular **e** desktop, temas dark e light |
| Acessibilidade WCAG AA | Checagem automatizada (candidato: axe-core no Playwright) + checklist por tela do DS + teste de teclado nos componentes interativos (sem Radix aqui) |
| pt-BR, R$, datas BR, fuso SP | Teste de formatação; `LANGUAGE_CODE`/`TIME_ZONE` verificados por teste de configuração |
| PWA instalável | Roteiro manual no `quickstart.md` da feature de produção |

---

## Matriz de gates (alvo da feature 001 — fundação técnica)

| Gate | Ferramenta | Onde | Bloqueia |
|---|---|---|---|
| Segredos | `scripts/check-no-secrets.sh` / gitleaks | pre-commit / CI | commit / merge |
| Lint + formato + regras de segurança | Ruff (`S`, `DJ`, …) + greps de padrões proibidos | pre-commit / CI `lint` | commit / merge |
| Mensagem de commit | Conventional Commits | commit-msg | commit |
| Tipos | mypy | CI `types` | merge |
| Testes + cobertura | pytest + pytest-cov (`fail-under`) | CI `test` (Postgres real em serviço do CI) | merge |
| Segurança de config e deps | `check --deploy` + pip-audit | CI `security` | merge |
| Fronteiras | contratos de import | CI `lint` | merge |
| Design system | grep de cor literal + hash dos arquivos do DS | CI `lint` | merge |
| E2E | Playwright (celular + desktop) | CI `e2e` | merge |
| Imagem | docker build + run + `/health` | CI `build` | merge / deploy |
| Deploy | só a partir de `main`, após todos os gates | CI `deploy` | — |

**Pronto quando** (critério da feature 001): commit com `.env` é bloqueado; commit "ajustes" é rejeitado; PR com teste vermelho, cobertura abaixo da meta ou `pip-audit` com vulnerabilidade não consegue ser mergeado; teste de isolamento com dois condomínios roda no CI.
