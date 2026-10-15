# ADR-003 — Aplicação web responsiva única com PWA, sem app nativo no MVP

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §6, §8, §16; changelog de idealização). O que não estava escrito está em **Lacunas**.

## Contexto

Os perfis (síndico, moradores, proprietário não residente) usam celular e computador; o morador prioriza celular, o síndico aproveita tela grande no painel (RNF-USA-01). A aplicação precisa ser instalável (RNF-USA-02) e mandar notificações.

## Decisão

Vamos entregar uma aplicação web responsiva única (PWA) para todos os perfis, sem restrição por dispositivo e sem app nativo no MVP (changelog de idealização, "Decidido"). PWA com manifest + service worker simples, para instalação na tela inicial e notificações web (§8).

## Alternativas consideradas

- **App nativo (lojas):** adiado; "PWA atende o MVP" (§16).

## Consequências

- **Positivas:** uma base de código e um deploy para todos os perfis e dispositivos.
- **Negativas / trade-offs:** notificações e instalação via PWA dependem do navegador.
- **Riscos e mitigação:** baixa adoção de notificações via PWA → gatilho para reconsiderar app nativo (§16); e-mail como canal de reserva.
- **Impacto nos atributos de qualidade:** usabilidade (celular primeiro), manutenibilidade (+).

## Como verificar

E2E Playwright em viewport de celular e desktop; roteiro manual de instalação PWA no `quickstart.md` da feature de produção (`ATRIBUTOS-DE-QUALIDADE` §7).

## Lacunas — o autor completa antes de "aceito"

- Houve outra alternativa (ex.: app separado para o síndico)? Por que não?
- Restrição conhecida de PWA no iOS afeta o piloto (quais aparelhos os moradores usam)?

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §6 (RNF-USA-01/02), §8, §16; `CHANGELOG.md` (Idealização).
