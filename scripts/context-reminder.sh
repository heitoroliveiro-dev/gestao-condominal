#!/usr/bin/env bash
# Hook UserPromptSubmit do Claude Code: injeta um lembrete curto das regras a cada prompt.
# É reforço, não fonte — a fonte é o CLAUDE.md e a constituição. Mantenha < 10 linhas.
cat << 'EOF'
[LEMBRETE — Gestão de Condomínio]
- Stack: Django 5.2 + HTMX + PostgreSQL; UI pelo design system ../design-system/linear (só tokens semânticos). Fase: ver CLAUDE.md.
- Invariantes: nenhuma consulta cruza condominio_id; registros de prova são append-only; acesso negado por padrão (terceiro -> 404).
- Proibido: segredo commitado, SQL cru, mark_safe/csrf_exempt sem ADR, dado por unidade no feed/log, commit em main, --no-verify.
- Autor escreve o código de produção; a IA especifica, planeja, revisa e mostra evidência (só escreve código se pedido).
- Fluxo SDD: specify -> clarify -> plan -> checklist -> tasks -> analyze -> implement -> review. Triagem antes de codar.
- DoD: testes + cobertura + lint + isolamento + perfil negado + doc + EVIDÊNCIA (não afirmação).
EOF
exit 0
