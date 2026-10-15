# Runbooks

> Runbook é escrito **antes** de precisar em produção, e ensaiado. Runbook nunca executado é hipótese, não procedimento.
> Nenhum runbook existe ainda — não há infraestrutura. Eles nascem na feature de produção (Sprint 6) e não podem descrever comandos que ninguém rodou.

| Runbook | Responde | Nasce em | Pronto quando |
|---|---|---|---|
| `deploy.md` | Como publicar uma versão e como voltar atrás | Sprint 6 | Deploy e rollback executados em homologação, com log colado |
| `backup-restore.md` | Onde está o backup, como restaurar | Sprint 6 | Restore em ambiente limpo feito (CT-10), com data e resultado |
| `teste-mensal-restore.md` | Registro dos testes mensais (RNF-BKP-02) | Após M1 | Uma linha por mês: data, duração, resultado |
| `incidente.md` | O que fazer quando `/health` cai ou o Sentry dispara | Sprint 6 | Simulação feita uma vez |
| `rotacao-de-segredos.md` | Trocar senha do banco, chave do storage, chave do Django | Sprint 6 | Rotação executada em homologação |
| `provisionar-condominio.md` | Cadastrar condomínio, ativar módulos, convidar síndico | Sprint 6 | Piloto provisionado seguindo o runbook |
| `vazamento-de-dados.md` | Contenção, avaliação e comunicação (LGPD) | Antes de M1 | Revisado à luz de Q-07/Q-08 |

Formato de cada runbook: **quando usar → pré-requisitos → passos com comando exato e saída esperada → como verificar que deu certo → rollback → a quem avisar.**
