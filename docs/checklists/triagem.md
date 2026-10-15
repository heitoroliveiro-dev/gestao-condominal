# Checklist de triagem (demanda nova)

Responda na ordem. O primeiro "sim" decide.

- [ ] Altera modelo de dados ou exige migration? → **SDD**
- [ ] Toca escopo de condomínio (`condominio_id`, queryset com escopo, multi-tenant)? → **SDD**
- [ ] Altera permissão, vínculo, papel ou autenticação? → **SDD**
- [ ] Toca registro com valor de prova (auditoria, comprovante, decisão, recibo, linha do tempo, feed)? → **SDD**
- [ ] Altera regra de negócio, fluxo de status ou cálculo de dinheiro/data? → **SDD**
- [ ] Muda o que aparece no feed, no e-mail ou para quem (privacidade/LGPD)? → **SDD**
- [ ] Altera contrato consumido por outro módulo (serviço público) ou formato de arquivo (recibo PDF)? → **SDD**
- [ ] Tem mais de um caminho com trade-off real? → **SDD** (+ ADR se arquitetural)
- [ ] O "pronto" não cabe numa frase checável? → **SDD**
- [ ] Atualização major do design system? → **SDD**
- [ ] É bug localizado (~1 arquivo) ou tela no padrão já existente? → **Trilha rápida**
- [ ] Nenhuma das anteriores / dúvida → **SDD**

## Trilha rápida (não é "sem processo")

1. Branch `fix/<nome>` ou `feat/<nome>`.
2. Plan mode: o que muda e em quais arquivos. Autor aprova.
3. Teste que reproduz o bug **antes** do fix (ou teste da ação nova).
4. Implementa. Suíte + lint verdes.
5. Contrato/doc que descreve o comportamento atualizado no mesmo PR.
6. PR com evidência, marcado "SDD dispensado propositalmente".

**Vire para SDD** se: o diff passou de ~5 arquivos; apareceu pergunta de produto; precisou de migration; entrou permissão nova.

## Registrar

- Origem: <uso real do síndico / morador / revisão técnica / bug em produção>
- Item no ROADMAP: <#>
- Trilha: <SDD `specs/NNN-...` | rápida `fix/...`>
- Fora do código? <síndico, convenção, jurídico, plano pago → marcar ⚠️>
