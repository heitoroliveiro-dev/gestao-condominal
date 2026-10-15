# ADR-002 — Multi-tenant com esquema compartilhado e `condominio_id`

- **Status:** proposto
- **Data:** 2026-10-15
- **Decisores:** Heitor Oliveiro (autor)

> Rascunho montado só com texto já escrito pelo autor (`visao-geral` §6, §10.1, §15, §16). O que não estava escrito está em **Lacunas**.

## Contexto

O piloto é um prédio, mas o plano é escalar para outros condomínios (changelog de idealização: "Piloto no prédio do autor, escalando depois para outros condomínios"). Vazamento entre condomínios expõe finanças e dados pessoais de vizinhos: RNF-SEG-04 exige que nenhuma consulta retorne dados de outro condomínio, com testes automatizados obrigatórios.

## Decisão

Vamos usar banco compartilhado e esquema compartilhado: toda tabela de dados de condomínio tem `condominio_id`, o filtro por condomínio é aplicado por um gerenciador de consultas padrão e reforçado por testes (§10.1).

## Alternativas consideradas

- **Um esquema PostgreSQL por condomínio:** mais isolamento, porém mais complexidade operacional (§10.1).

## Consequências

- **Positivas:** uma só migração, um só backup, operação simples numa VPS.
- **Negativas / trade-offs:** o isolamento depende do código (manager com escopo) e de testes, não do banco.
- **Riscos e mitigação:** consulta esquecida sem escopo → princípio I da constituição (NON-NEGOTIABLE), teste com dois condomínios para todo serviço e view tenant-scoped (CT-02), índices sempre começando por `condominio_id`.
- **Impacto nos atributos de qualidade:** segurança (risco concentrado no código, mitigado por teste), desempenho (índices compostos), disponibilidade/operação (+).

## Como verificar

Fixture `dois_condominios` e teste de isolamento obrigatório (CT-02); revisão procura `Model.objects` sem escopo (`ATRIBUTOS-DE-QUALIDADE` §1).

## Lacunas — o autor completa antes de "aceito"

- Banco separado por condomínio foi considerado? Por que não?
- Row-Level Security do PostgreSQL como reforço no banco: considerar agora, adiar ou descartar?
- Gatilho para reavaliar (ex.: cliente que exija isolamento físico)?

## Referências

`docs/00-discovery/visao-geral-da-solucao.md` §6 (RNF-SEG-04), §10.1; constituição, princípio I.
