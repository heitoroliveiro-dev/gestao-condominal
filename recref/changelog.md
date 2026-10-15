# Changelog

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/). Antes do código, registra decisões de produto e documentação.

## [Não lançado]

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
