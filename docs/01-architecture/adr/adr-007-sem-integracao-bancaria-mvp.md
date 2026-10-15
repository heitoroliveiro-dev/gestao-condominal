# ADR-007 — Sem integração bancária no MVP; pagamento comprovado por anexo

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §2, §16; changelog). O que não estava escrito está em **Lacunas**.

## Contexto

Hoje o fluxo é "Pix + comprovante no WhatsApp + recibo manual" (OE-01). O objetivo é torná-lo rastreável: cobrança, comprovante, confirmação e recibo.

## Decisão

Vamos operar sem integração bancária no MVP: o morador anexa o comprovante, o síndico confirma ou recusa, e o sistema emite o recibo (changelog de idealização: "Pagamentos sem integração bancária no MVP: cobrança + comprovante + confirmação + recibo").

## Alternativas consideradas

- **Integração Pix/boleto com conciliação automática (PSP com webhook):** adiada porque exige integração bancária e responsabilidade financeira; gatilho: piloto estável e 3+ condomínios pagando (§16).
- **Emissão de nota fiscal para condôminos:** descartada — taxa condominial é rateio, não prestação de serviço (changelog de idealização).

## Consequências

- **Positivas:** sem dependência de PSP nem custo por transação; o dinheiro não passa pela plataforma.
- **Negativas / trade-offs:** confirmação manual pelo síndico; risco de comprovante falso.
- **Riscos e mitigação:** comprovante adulterado → SHA-256 no upload (RNF-AUD-03), decisão do síndico registrada e imutável (ADR-005); pagamento futuro entra por porta/interface (ADR-009).
- **Impacto nos atributos de qualidade:** segurança (sem credencial bancária), integridade.

## Como verificar

Testes de HU-01 a HU-03, CT-03 (sem duplicidade) e CT-05 (upload malicioso rejeitado).

## Lacunas — o autor completa antes de "aceito"

- O síndico do piloto concorda com a confirmação manual (relaciona com Q-01)?

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §2 (OE-01), §6 (RNF-AUD-03), §16; `CHANGELOG.md` (Idealização).
