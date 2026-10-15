# ADR-005 — Histórico append-only (auditoria, comprovantes, chamados, feed)

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §3, §6, §11; `spec-feed-transparencia`; changelog). **A escolha do mecanismo no banco ainda não foi feita** — ver Lacunas.

## Contexto

O posicionamento do produto é "transparência com prova": histórico imutável, chamados fecham com registro (changelog de idealização). RNF-AUD-01 exige auditoria de toda ação relevante com autor, data/hora e dados anteriores e novos; RNF-AUD-02, que auditoria, linhas do tempo e itens do feed sejam somente inserção; RNF-AUD-04, que item automático do feed seja escrito na mesma transação do evento de origem. Há tensão com o direito de exclusão da LGPD (RNF-LGPD-06, Q-08).

## Decisão

Vamos tratar auditoria, linha do tempo de chamados, comprovantes, decisões, recibos, comunicados e itens do feed como append-only: correção gera novo registro vinculado ao anterior. Exceções nomeadas: reações do feed (sem valor de prova — RNF-AUD-02) e o campo `fixado` do item do feed (§11). A proteção existe no código **e no banco**.

## Alternativas consideradas

- **Registros editáveis com auditoria de alterações:** _lacuna — o autor descreve por que não._
- **Mecanismo no banco** (a escolher):
  - **Trigger** que rejeita UPDATE/DELETE nas tabelas protegidas (permite a exceção `fixado` por coluna).
  - **`REVOKE UPDATE, DELETE`** para o papel do banco usado pela aplicação (simples; exceção de `fixado` exige tabela separada ou outro papel).

## Consequências

- **Positivas:** prova que nem o síndico consegue apagar; base do feed de transparência.
- **Negativas / trade-offs:** correção gera ruído (novo registro); dado pessoal no histórico conflita com exclusão (Q-08).
- **Riscos e mitigação:** anonimização ao encerrar vínculo bloqueada até a resposta jurídica de Q-08 (`ATRIBUTOS-DE-QUALIDADE` §2).
- **Impacto nos atributos de qualidade:** integridade (+++), privacidade (tensão, Q-08), desempenho (crescimento contínuo das tabelas — paginação).

## Como verificar

CT-08: editar evento de auditoria via aplicação → operação inexistente/bloqueada; teste novo, deste ADR: UPDATE/DELETE direto no banco, com o papel da aplicação, nas tabelas protegidas → falha; CT-13: síndico não oculta nem edita item automático do feed; CT-15: falha no feed desfaz a resolução do chamado (`ATRIBUTOS-DE-QUALIDADE` §3).

## Lacunas — o autor completa antes de "aceito"

- **Escolher o mecanismo no banco: trigger ou `REVOKE`** (pendência 6 do ROADMAP), e por quê.
- Por que não "editável com auditoria"?
- Como as migrations rodam se o papel da aplicação não tem UPDATE/DELETE (papel separado para migração)?

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §6 (RNF-AUD-01 a 04, RNF-LGPD-06), §11; `questoes-em-aberto.md` (Q-08); constituição, princípio II.
