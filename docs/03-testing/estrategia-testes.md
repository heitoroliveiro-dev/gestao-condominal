# Estratégia de Testes

> O objetivo não é cobertura por cobertura: é rede de segurança para mudar sem medo e **prova** de que as regras de negócio, o isolamento e a imutabilidade funcionam.
> Casos críticos da visão geral (CT-01 a CT-15): `docs/00-discovery/visao-geral-da-solucao.md` §13.2.

## Pirâmide

| Nível | Ferramenta | Escopo | Meta |
|---|---|---|---|
| Unidade (maioria) | pytest | `domain.py`: transições de estado da cobrança e do chamado, objetos de valor (`Competencia`, `Dinheiro`, `Periodo`), cálculo de atraso, regras de visibilidade do feed | 90% de cobertura no domínio |
| Integração | pytest-django + PostgreSQL real | `services.py` com banco: isolamento, permissões, constraints, transações, uploads, recibo, append-only | Todo caso de uso |
| Aceitação | pytest, um teste por cenário Gherkin | Cada história de usuário da feature | 100% das HUs do MVP |
| E2E | Playwright | Fluxos críticos em viewport de celular **e** desktop: convite, envio de comprovante, confirmação, painel, feed | Fluxos críticos |
| Segurança | Testes dedicados + pip-audit + `check --deploy` | IDOR, entre condomínios, upload malicioso, força bruta, vazamento no feed | Sem falha crítica |
| UAT | Sessão com o síndico piloto | Uso real ao fim de cada sprint | Feedback registrado no ROADMAP |

Banco de teste: **PostgreSQL de verdade** (o mesmo do Compose em dev; serviço no CI). Nunca SQLite — constraints, transações e triggers precisam ser os de produção.

## Cobertura mínima (gate no CI)

| Camada | Mínimo |
|---|---|
| `*/domain.py` | 90% de linhas |
| Total | 80% de linhas |

## Regras invioláveis

1. **Nenhum teste mascarado:** proibido `skip`, `xfail` sem motivo registrado, assert removido, expectativa afrouxada.
2. **Bug corrigido = teste de regressão** que falha antes do fix.
3. **Invariante crítico tem teste próprio:** isolamento, append-only, atomicidade do feed, constraints de unicidade. Não "confiar no framework".
4. **Caminho real de dados:** comportamento crítico tem pelo menos um teste sem mock no meio (mock só na borda: e-mail, storage, relógio).
5. **Teste de ação, não só de estado:** botão HTMX novo → teste do clique → efeito (resposta + estado no banco).
6. **Não remover teste existente** sem justificativa no PR; o review compara a contagem antes/depois.
7. **Relógio fixo** em todo teste que depende de data (vencimento, atraso, expiração de convite), incluindo a virada do dia em `America/Sao_Paulo`.

## Testes obrigatórios por tipo de mudança

| Mudança | Teste obrigatório |
|---|---|
| Modelo tenant-scoped novo | Isolamento com `dois_condominios` (ler e escrever) |
| View nova | Perfil negado + recurso de terceiro → 404 |
| Registro com valor de prova | Tentativa de UPDATE/DELETE → falha (app e banco) |
| Evento que gera item do feed | Atomicidade: falha no feed desfaz o evento |
| Tela de lista | `django_assert_max_num_queries` com volume realista |
| Upload | Tipo falso, tamanho excedido, URL expirada |
| Envio de e-mail/notificação | Falha do provedor não quebra o fluxo principal |
| Migration | `migrate` para frente e para trás em banco com dados |

## Fixtures

- **factory_boy:** uma factory por entidade (`CondominioFactory`, `UnidadeFactory`, `PessoaFactory`, `VinculoFactory`, `CobrancaFactory`…).
- **`dois_condominios`:** cria condomínios A e B com síndico, unidades e moradores em cada; usado em todo teste de isolamento.
- **Perfis prontos:** `sindico`, `responsavel_financeiro`, `morador_sem_ve_pagamentos`, `proprietario_nao_residente`, `vinculo_encerrado`.
- **Relógio:** fixture para congelar data/hora (ferramenta decidida na feature 001).
- **Storage e e-mail:** dublês na borda; MinIO real nos testes de integração de upload.

## Rastreabilidade

Nome do teste ou docstring cita o requisito: `test_recusa_sem_motivo_e_bloqueada  # RF-PAG-04, CT-04`. O review por subagente usa isso para conferir que todo FR tem teste.

## Antes de começar qualquer feature

Registre o estado da suíte na `main` (contagem e falhas). Falha pré-existente vira pendência própria no ROADMAP — não é "consertada" dentro de outra feature nem ignorada em silêncio.
