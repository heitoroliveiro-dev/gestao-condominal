# ADR-001 — Monólito modular em vez de microsserviços

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §8, §9, §10.1; changelog de 2026-10-15). O que não estava escrito está em **Lacunas**.

## Contexto

Um autor só, com pouco tempo (TCC até dez/2026, código a partir de jan/2027 — `visao-geral` §15), construindo um sistema com vários contextos delimitados (Identidade e Acesso, Estrutura do Condomínio, Pagamentos, Chamados, Comunicação, Feed, Obrigações, Documentos — §9). O público inicial é um único prédio piloto de 8–50 unidades.

## Decisão

Vamos construir um monólito modular: um único deploy, em que cada contexto delimitado é um app Django com modelos, serviços e testes próprios, e módulos se comunicam apenas pelos serviços públicos uns dos outros (§10.1).

## Alternativas consideradas

- **Microsserviços:** descartado no changelog de idealização (2026-10-15). Motivo registrado de forma geral: complexidade de várias bases de código e deploys, incoerente com KISS para uma pessoa só (§8, "Por que não Next.js/NestJS").

## Consequências

- **Positivas:** um deploy, uma base de código, transações locais entre módulos (necessárias para RNF-AUD-04: evento e item do feed na mesma transação).
- **Negativas / trade-offs:** fronteiras entre módulos não são forçadas pela rede; dependem de disciplina e de checagem automática.
- **Riscos e mitigação:** módulos se acoplarem pelos modelos internos → contratos de import no CI (`ATRIBUTOS-DE-QUALIDADE` §6).
- **Impacto nos atributos de qualidade:** manutenibilidade (+), disponibilidade (um ponto único de falha, aceitável para 99%/mês no piloto — RNF-DIS-01).

## Como verificar

Contratos de import no CI: um módulo não importa `models` de outro; domínio não importa views/infra (gate "Fronteiras" da matriz de gates).

## Lacunas — o autor completa antes de "aceito"

- Outra alternativa considerada além de microsserviços (ex.: monólito sem fronteiras explícitas)? Por que não?
- Gatilho para reavaliar (ex.: módulo com carga ou ciclo de deploy muito diferente dos demais)?

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §8, §9, §10.1; `CHANGELOG.md` (Idealização, "Descartado").
