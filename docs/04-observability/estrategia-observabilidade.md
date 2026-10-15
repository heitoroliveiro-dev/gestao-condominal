# Estratégia de Observabilidade

> Objetivo: saber que algo quebrou **antes do síndico**, e conseguir diagnosticar sem expor dado pessoal. Origem: RNF-OBS-01, RNF-DIS-01, RNF-DES-01.

## 1. Logs

- **Estruturados (JSON)** em produção; legíveis em dev.
- Todo log de requisição carrega: `request_id`, `condominio_id` (UUID), rota, status, duração em ms. **Não** carrega nome, e-mail, telefone, corpo da requisição, conteúdo de arquivo, valores por unidade, senha ou token.
- Filtro de log central que remove campos sensíveis, **com teste**.
- Exceção inesperada: logada com stack trace antes de virar mensagem genérica ao usuário.
- Ações de negócio relevantes vão para a **auditoria** (banco, append-only), não só para log. Log é para operar; auditoria é prova.

## 2. Rastreamento de erros

- Sentry (plano gratuito) ou equivalente, com `send_default_pii=False` e scrubbing de campos sensíveis.
- Release = hash do commit, para ligar erro ao deploy.

## 3. Health check

`/health` responde 200 **somente** se:
1. a conexão com o PostgreSQL funciona;
2. não há migrations pendentes;
3. (opcional) o storage responde.

Resposta inclui a versão (hash do commit) — permite confirmar que o processo roda o código atual (lição: build antigo rodando gera falso negativo). Sem dado sensível na resposta.

## 4. Métricas mínimas (piloto)

| Métrica | Fonte | Uso |
|---|---|---|
| p95 de duração por rota | Logs | RNF-DES-01 (< 500 ms) |
| Taxa de 5xx | Logs / Sentry | Alerta |
| Uptime mensal | Monitor externo em `/health` | RNF-DIS-01 (99%) |
| Último backup bem-sucedido | Log do job de backup | Alerta se > 26 h |
| Tarefas agendadas | Log de cada execução do cron | Alerta se não rodou |

Sem Prometheus/Grafana no piloto — só se o volume justificar (anti-overengineering).

## 5. Alertas (para o autor)

| Condição | Canal |
|---|---|
| `/health` falhou 2 checagens seguidas | Monitor externo → e-mail/push |
| Erro novo no Sentry | E-mail |
| Backup não rodou em 26 h | E-mail |
| Cron de atrasos/lembretes não rodou | E-mail |

Cada alerta tem um runbook correspondente em `docs/05-runbooks/`.
