# Playbook de Condução

> Sobre **como o autor dirige o projeto**, não sobre código. Ler no início de cada sessão junto com o `CLAUDE.md`.

## 1. Quem decide o quê

A IA **propõe, revisa e verifica**. O autor **decide, aprova e escreve o código de produção** (OE-08: o projeto é também estudo de Python).

| A IA faz | Só o autor decide / faz |
|---|---|
| Rascunhar spec, plano e tarefas a partir do que o autor descreveu | O que entra no escopo e o que fica fora |
| Fazer perguntas de clarificação e apontar ambiguidade | As respostas (decisões de produto) |
| Apresentar alternativas com recomendação | Qual alternativa seguir (vira ADR) |
| Revisar o diff contra o `plan.md`, apontar bug, sugerir correção | Escrever o código de produção |
| Rodar testes, lint, mostrar evidência, explicar código e conceitos | Aceitar mudança de estrutura, trocar stack ou lib |
| Escrever código quando o autor pedir para uma tarefa específica | Priorizar o backlog |

**Sinais de alerta:** decisão de arquitetura sem alternativas; escopo cresceu ("já que estava aqui…"); aprovar código que não entende; não saber dizer em uma frase o que a sessão entrega.

**Regra de ouro:** o autor consegue explicar cada decisão do projeto para outra pessoa — inclusive para o síndico, em linguagem de negócio.

## 2. As três alturas de visão

### Altura 1 — O Norte (raramente muda)
**"Transparência com prova: toda ação relevante fica registrada com autor, data e prova, e ninguém consegue apagá-la."**
Tarefa que não serve a isso justifica sua existência ou vai para o backlog. A lista "Fora de escopo" (`visao-geral` §16) é o filtro.

### Altura 2 — A Fase atual (muda a cada semanas)
Uma fase ativa por vez, registrada no `CLAUDE.md` → "Fase atual", com detalhe no `docs/ROADMAP.md`:
```
[ ] F0 — Discovery (Sprint 0)          ← aqui
[ ] F1 — Arquitetura (ADRs, constituição)
[ ] F2 — Fundação técnica (Sprint 1)
[ ] F3 — Features do MVP (Sprints 2–5)
[ ] F4 — Produção (Sprint 6)
[ ] ⭐ M1 — Piloto assistido
```

### Altura 3 — A tarefa de hoje (muda a cada sessão)
> "Hoje eu vou entregar ______ e vou saber que terminei quando ______."

Sem conseguir completar a frase, **não comece a codar**.

## 3. O loop de uma sessão

```
1. DEFINIR   → a frase da Altura 3. Uma tarefa, não cinco.
2. TRIAR     → SDD ou trilha rápida? (docs/checklists/triagem.md)
3. PLANEJAR  → fluxo SDD, ou plan mode na trilha rápida. Autor aprova.
4. EXECUTAR  → autor escreve teste (vermelho) → código (verde) → refatora.
5. VERIFICAR → evidência: output do pytest, comando + retorno, screenshot no celular.
6. ENTENDER  → o autor explica o que foi feito? Se não, pergunta até entender.
7. COMMITAR  → commit coeso; hooks protegem; branch + PR.
8. REGISTRAR → CHANGELOG, ADR se decidiu algo, fase se virou, achados no ROADMAP.
```

Com ~8 h/semana, uma feature SDD ocupa várias sessões. Tudo bem: cada sessão fecha uma ou mais fases (spec, plano, um bloco de tarefas).

## 4. Regras de escopo

- **Uma tarefa por vez.** Terminou, commitou, pega a próxima.
- **"Precisamos disso para o piloto?"** — mata overengineering (Celery, cache, microsserviço, app nativo…).
- **Módulo futuro só com gatilho atendido** (`visao-geral` §16).
- **Ideia nova no meio da tarefa** → `docs/ROADMAP.md § Backlog`, nunca no diff atual.

## 5. Freios de mão

- Vai mexer em estrutura que funciona → impacto, reversibilidade, rollback.
- Decisão com mais de um caminho → ADR; a IA apresenta opções, o autor escolhe.
- Diff grande demais para ler inteiro → quebrar.
- Pressa e vontade de aprovar sem ler → é aí que o bug entra.
- Mexeu em escopo de condomínio, permissão, append-only, dinheiro ou feed → parar e conferir os testes de invariante antes de seguir.

## 6. Ritmo de Sprint (Scrum adaptado a uma pessoa)

- **Planejamento** (início): escolher a feature do ROADMAP; rodar `/speckit-specify` se ainda não houver spec.
- **Durante:** sessões no loop acima.
- **Revisão** (fim): demonstrar ao síndico a entrega visível; feedback vira itens no ROADMAP (triados um a um).
- **Retrospectiva:** uma entrada curta no `CHANGELOG` — o que travou, que regra nova vira trava (hook/teste/checklist).

## 7. Mapa do projeto

| Pergunta | Onde |
|---|---|
| Qual o Norte, o que é o produto? | `docs/00-discovery/` |
| O que construir, em que ordem? | `docs/ROADMAP.md` |
| Em que fase estou? | `CLAUDE.md` → Fase atual |
| Por que decidimos X? | `docs/01-architecture/adr/` |
| Quais as regras invioláveis? | `CLAUDE.md` + constituição |
| Como cada atributo de qualidade é garantido? | `docs/ATRIBUTOS-DE-QUALIDADE.md` |
| Como as telas devem ser? | `docs/06-design/diretrizes-design.md` + `../design-system/linear` |
| O que já foi feito? | `CHANGELOG.md` |
| Checklists | `docs/checklists/` |
