# Estratégia de Segurança e Privacidade

> Regras e modelo de ameaças. A tabela de controles × travas está em `docs/ATRIBUTOS-DE-QUALIDADE.md` §1–2; este documento explica o **porquê** e o que revisar em cada feature.

## 1. O que estamos protegendo

| Ativo | Por que importa | Quem pode ver |
|---|---|---|
| Situação financeira por unidade | Expõe vizinhos; gera conflito | Síndico (e conselho, se a convenção previr — Q-05) |
| Comprovantes e recibos | Prova de pagamento; contém dados bancários | Responsável financeiro e quem tem `ve_pagamentos` na unidade; síndico |
| Chamados privados | Problemas pessoais da unidade | Autor e síndico |
| Histórico append-only | É a prova; a adulteração destrói o produto | Leitura conforme papel; escrita só por inserção |
| Dados pessoais (nome, e-mail, telefone) | LGPD | Mínimo necessário por funcionalidade |
| Conta do síndico | Decide pagamentos e publica no feed | — (2FA na v2) |

## 2. Modelo de ameaças (STRIDE resumido)

| Ameaça | Cenário concreto | Controle principal |
|---|---|---|
| **S**poofing | Alguém se vincula a uma unidade que não é sua | Vínculo só ativo após convite ou aprovação do síndico (RF-NUC-03/04); token de convite com hash e expiração |
| **T**ampering | Síndico edita ou apaga uma decisão para esconder erro | Append-only no código e no banco (princípio II); SHA-256 nos arquivos |
| **R**epudiation | "Eu não recusei esse comprovante" | Auditoria com autor, data/hora, antes/depois (RNF-AUD-01) |
| **I**nformation disclosure | Morador troca o UUID na URL e vê o recibo do vizinho; item do feed vaza inadimplência | Escopo obrigatório + 404; teste de dados proibidos no feed |
| **D**enial of service | Força bruta no login; upload gigante | Limite de tentativas; máx. 10 MB; limites no proxy reverso |
| **E**levation of privilege | Morador acessa painel do síndico; síndico de A age em B | Permissão negada por padrão; papel verificado no escopo do condomínio; teste de perfil negado |

## 3. Regras de implementação

1. **Escopo antes de tudo.** Toda busca de objeto tenant-scoped passa por um helper que recebe a pessoa/condomínio atual. `Model.objects.get(pk=...)` solto em view é bug de segurança.
2. **404, não 403**, para recurso de terceiro — não revela que existe.
3. **Permissão conferida contra a spec.** Ao copiar estrutura de outro módulo, os guards são reescritos a partir dos FRs da spec atual (lição do método: RBAC copiado do molde).
4. **Entrada validada** por form/serializer em toda mutação; IDs como UUID; ordenação e filtros por allowlist.
5. **Uploads**: tipo pelo conteúdo (não pela extensão), tamanho máximo, bucket privado, nome de arquivo gerado pelo sistema, URL assinada de curta duração, hash SHA-256.
6. **Sessão e cookies**: `Secure`, `HttpOnly`, `SameSite`; HSTS; `check --deploy` sem avisos.
7. **Erros**: exceção inesperada é logada (sem dado sensível) antes de virar mensagem genérica. Engolir exceção sem log é proibido.
8. **Admin do Django**: só para o administrador da plataforma, em rota não óbvia, com 2FA quando disponível; nunca exposto a síndicos.
9. **Dependências**: lockfile versionado; `pip-audit` bloqueante; atualização consciente, com changelog lido.

## 4. LGPD — papéis e pendências

- Condomínio = **controlador**; plataforma = **operadora** (RNF-LGPD-05). Formalizar em termo (⚠️ Q-07).
- Aceite de política e termos no primeiro acesso, com registro (RNF-LGPD-04).
- Menores não têm conta (RNF-LGPD-03).
- **Conflito aberto:** histórico imutável × direito de exclusão (RNF-LGPD-06). ⚠️ Q-08 exige consulta jurídica antes do piloto. Até a resposta, nenhuma feature implementa exclusão ou anonimização — a spec que tratar disso cita o parecer.

## 5. O que revisar em toda feature (entra no `/speckit-checklist security`)

- [ ] Todo dado novo tenant-scoped tem `condominio_id` e teste de isolamento com dois condomínios?
- [ ] Toda view nova tem teste de perfil negado e de recurso de terceiro → 404?
- [ ] A spec diz quem vê cada dado novo? O feed, o log ou o e-mail podem expô-lo?
- [ ] Algum registro novo tem valor de prova? Então é append-only.
- [ ] Algum upload novo segue as regras do item 5 de §3?
- [ ] Algum padrão proibido (`.raw`, `mark_safe`, `csrf_exempt`) entrou? Tem ADR?

## 6. Antes da produção (feature de hardening, Sprint 6)

- [ ] `check --deploy` limpo com settings de produção
- [ ] gitleaks no histórico inteiro; segredo achado → **rotacionar** (apagar do histórico não basta)
- [ ] Checklist OWASP Top 10 percorrido, achados no ROADMAP
- [ ] Backup criptografado em repouso, fora do servidor
- [ ] Acesso SSH à VPS só por chave; firewall com portas mínimas
