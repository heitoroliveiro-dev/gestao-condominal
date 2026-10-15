# ADR-009 — Clean Architecture pragmática

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §9). O que não estava escrito está em **Lacunas**.

## Contexto

O projeto aplica DDD (contextos delimitados, agregados, objetos de valor) e TDD sobre Django (§9). Regras de negócio precisam ser testáveis sem a camada web, e o autor trabalha sozinho com pouco tempo.

## Decisão

Vamos aplicar Clean Architecture com pragmatismo (§9):
- regras de negócio em métodos de domínio e em serviços de aplicação (`services.py`), nunca em views;
- views finas: recebem a requisição, chamam o serviço, retornam a resposta;
- interfaces (portas) apenas onde há dependência externa real: armazenamento de arquivos, e-mail, geração de PDF e, no futuro, pagamentos;
- dependências apontam para dentro: domínio não importa nada de views ou de infraestrutura.

## Alternativas consideradas

- **Clean Architecture completa sobre Django** (repositórios abstraindo o ORM, entidades duplicadas): gera muito código e briga com o framework (§9).

## Consequências

- **Positivas:** domínio testável e legível; menos código que a versão completa.
- **Negativas / trade-offs:** o domínio usa o ORM do Django diretamente — trocar de framework não é objetivo.
- **Riscos e mitigação:** regra de negócio vazar para view/template → princípio VI da constituição e review; abstração prematura → "sem segundo caso de uso concreto, sem abstração" (§9, Princípios).
- **Impacto nos atributos de qualidade:** manutenibilidade (+), testabilidade (+).

## Como verificar

Contratos de import no CI (domínio não importa views/infra); cobertura ≥ 90% no domínio (`ATRIBUTOS-DE-QUALIDADE` §6).

## Lacunas — o autor completa antes de "aceito"

- Nenhuma lacuna de motivo. Confirmar a ferramenta dos contratos de import (candidata: import-linter) na feature 001.

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §9; constituição, princípio VI.
