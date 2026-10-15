# ADR-006 — Núcleo + módulos ativáveis por condomínio

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §2, §10.1, §16; changelog). O que não estava escrito está em **Lacunas**.

## Contexto

Condomínios pequenos têm realidades diferentes: o prédio piloto não tem área comum nem portaria (§16: Reservas e Encomendas adiados por isso). OE-06: permitir que cada condomínio ative apenas os módulos compatíveis com sua realidade.

## Decisão

Vamos ter um núcleo fixo e módulos ativáveis por condomínio: a tabela `ModuloCondominio` indica quais módulos estão ativos em cada condomínio; rotas, menus e permissões consultam essa configuração (§10.1). Não é marketplace (changelog de idealização).

## Alternativas consideradas

- **Marketplace de módulos/prestadores:** descartado como produto distinto (changelog de idealização; §16).
- **Todos os módulos sempre ativos:** _lacuna — o autor descreve por que não._

## Consequências

- **Positivas:** cada condomínio vê só o que usa; módulos futuros (Reservas, Encomendas) entram sem afetar quem não precisa.
- **Negativas / trade-offs:** toda rota, menu e permissão precisa checar ativação.
- **Riscos e mitigação:** rota de módulo inativo acessível por URL direta → teste "módulo inativo → 404".
- **Impacto nos atributos de qualidade:** segurança (mais uma condição de acesso), manutenibilidade.

## Como verificar

Teste por módulo: condomínio sem o módulo ativo recebe 404 nas rotas dele; ativação gera evento de auditoria (RNF-AUD-01 cita "ativação de módulo").

## Lacunas — o autor completa antes de "aceito"

- Por que não deixar todos os módulos sempre ativos no MVP (precisamos disso hoje)?
- Quem ativa um módulo: síndico, plataforma ou ambos?

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §2 (OE-06), §6 (RNF-AUD-01), §10.1, §16.
