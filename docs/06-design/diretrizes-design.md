# Diretrizes de Design — adoção do Design System Linear

> **Padrão de design do projeto:** repositório `../design-system/linear` (`git@github.com:heitoroliveiro-dev/designsystem-linear.git`).
> **Versão adotada:** v1.0.0 (commit `9de9123`). Atualização é manual e deliberada — ver §6.
> Decisão de adoção: ADR-011 (a escrever; ver §7). Responde à Q-10.

## 1. O problema de encaixe (e a decisão proposta)

O design system foi construído para **Next.js + React + Radix + shadcn/ui**. Nosso produto é **Django + templates + HTMX**, sem SPA e sem Node no pipeline (ADR-004). Por isso adotamos o sistema **em camadas**, não por cópia:

| Camada do DS | Adota? | Como, no Django |
|---|---|---|
| **Tokens** (`tokens/` DTCG → `tokens.css`, `theme.css`) | **Sim, integral** | Copiar os arquivos **gerados** para `src/static/css/ds/` sem editar. Fonte da verdade continua no repositório do DS |
| **Tailwind v4 `@theme`** | **Sim** | Tailwind v4 via **CLI standalone** (sem Node), escaneando `templates/**/*.html`. Resolve a Q-10 |
| **Regras** (`AGENTS.md`, `docs/01–07`) | **Sim, integral** | Valem para todo template deste projeto (§3) |
| **Componentes React** (`src/components/ui`) | **Não diretamente** | Reimplementar como **componentes de template Django** com a mesma API (nome, variantes, tamanhos) e as mesmas classes das `cva` (§4) |
| **Radix** (teclado, foco, ARIA) | **Não existe aqui** | Preferir HTML nativo (`<dialog>`, `<select>`, `<details>`, `<input type=checkbox>`); comportamento além disso exige teste de acessibilidade (§5) |
| **Efeitos** (`GlowCard`, `BorderBeam`, `Background`) | **Não no app** | Só se houver página pública de apresentação; nunca em telas de trabalho |
| Páginas de documentação (`src/app`) | Não | Consultar no próprio DS (`npm run dev` lá) |

A cor de marca (`brand.hue`) e qualquer ajuste de token são feitos **no repositório do DS** (`npm run tokens`, que valida contraste WCAG) e os arquivos gerados são copiados para cá. Assim o Node fica só na máquina de quem mexe no DS, não no CI deste projeto.

⚠️ Verificar na feature 001: o `globals.css` do DS importa `tw-animate-css` (pacote npm). Confirmar se o CLI standalone resolve; se não, vendorizar o CSS do pacote ou dispensá-lo (só serve a animações de overlay).

## 2. Ajustes de produto ao estilo (decisões para o autor — entram no ADR-011)

O DS é denso e dark-first, pensado para ferramenta de trabalho em desktop. Nossas personas incluem síndico de 54 anos usando celular e proprietário de 68 anos (`visao-geral` §4), e o RNF-USA-03 exige WCAG AA. Propostas:

| Tema | Padrão do DS | Proposta para este produto | Por quê |
|---|---|---|---|
| Tema inicial | `class="dark"` fixo | **Seguir `prefers-color-scheme`**, com troca manual salva por pessoa | Público não técnico; light é completo no DS |
| Borda de input | `gray-7` (~1,7:1, trade-off documentado no DS 07) | **`gray-9`** (AA estrito, opção prevista pelo próprio DS) ou expor o modo `data-contrast="high"` | RNF-USA-03; usuários mais velhos |
| Densidade | corpo 13px, controles `h-8` | Painel do síndico em desktop: densidade do DS. Telas de morador no celular: `size="lg"` em controles principais e corpo `text-base` | Alvo de toque e legibilidade no celular (RNF-USA-01) |
| Atalhos ⌘K | Paleta de comandos | Fora do MVP | Público não é keyboard-first |
| Fontes | Inter + Geist Mono | Servidas **localmente** (sem Google Fonts) | Desempenho e não enviar IP do usuário a terceiros (LGPD) |
| Ícones | lucide-react | SVGs do Lucide servidos localmente (sprite ou include) | Sem React |

Mudança de token (borda de input, marca) é feita no DS e vale como versão **patch/minor** dele — ou num fork do DS para o produto, se a mudança não servir a outros projetos. Decidir no ADR-011.

## 3. Regras obrigatórias em todo template (do `AGENTS.md` do DS, adaptadas)

1. **Cores: só tokens semânticos** (`bg-background`, `bg-card`, `text-foreground`, `text-muted-foreground`, `border-border`, `bg-primary text-primary-foreground`, `bg-{success|warning|danger|info}-subtle text-{…}-text`). A paleta padrão do Tailwind não existe. **Nunca** hex/rgb literal em template ou CSS do projeto.
2. **Reutilize os componentes de template** (§4) antes de escrever markup novo.
3. **Uma ação primária por região** (`variant="default"`); o resto `secondary`; baixa ênfase `ghost`.
4. **Raio:** `rounded-md` em controles, `rounded-lg` em cards, `rounded-xl` em dialogs.
5. **Elevação:** só `shadow-raised` · `shadow-overlay` · `shadow-modal`.
6. **Movimento:** `transition-colors duration-(--duration-fast) ease-standard`; ≤ 200 ms em overlays; nunca animar width/height. Swaps do HTMX seguem os mesmos tokens.
7. **Acessibilidade:** botão só-ícone com `aria-label`; todo campo com `<label for>`; erro com `aria-invalid` + `aria-describedby`; foco visível nunca removido; **estado nunca só por cor** (status de cobrança e chamado sempre com texto).
8. **Status do domínio → variantes do Badge** (mapeamento fixo, para ser igual em todas as telas):

| Domínio | Status | Badge |
|---|---|---|
| Cobrança | Em aberto | `outline` |
| Cobrança | Aguardando confirmação | `info` |
| Cobrança | Paga | `success` |
| Cobrança | Atrasada (derivado) | `danger` |
| Cobrança | Cancelada | `default` |
| Chamado | Aberto / Em análise / Em andamento | `info` |
| Chamado | Aguardando terceiro | `warning` |
| Chamado | Resolvido | `success` |
| Chamado | Resolução contestada | `warning` |
| Comprovante | Recusado | `danger` |

(Mapeamento proposto — validar com o síndico no primeiro UAT.)

## 4. Componentes de template

- Local: `src/templates/components/` (um arquivo por componente), usados via `{% include %}` com parâmetros ou template tags. Ferramenta exata (include puro, inclusion tags ou biblioteca de componentes) decidida na feature 001 — sem dependência nova sem necessidade.
- **Mesma API do DS:** `button` com `variant` (`default`, `secondary`, `outline`, `ghost`, `destructive`, `link`) e `size` (`xs`, `sm`, `default`, `lg`, `icon-*`); `badge`, `input`, `label`, `textarea`, `checkbox`, `select`, `card`, `alert`, `table`, `dialog`, `tabs`, `toast`, `skeleton`, `spinner`, `avatar`, `separator`.
- **Classes copiadas das `cva` do DS** (`src/components/ui/*.tsx`), com o arquivo de origem citado no topo do template — facilita comparar quando o DS mudar.
- Só se cria o componente **quando a primeira tela precisar** (anti-overengineering). Ordem provável: button, input/label, card, badge, alert, table (Sprints 1–4); dialog e toast (Sprint 4).
- Componente com regra de negócio (ex.: "linha de unidade no painel") fica em `src/<modulo>/templates/`, composto dos componentes base — nunca no nível base.
- Componente genérico usado em ≥ 2 contextos e sem regra de negócio é candidato a voltar para o DS (critério de governança do DS, doc 09).

## 5. Comportamento interativo sem Radix

| Componente | Base | Exigência |
|---|---|---|
| Dialog | `<dialog>` nativo + `showModal()` | Foco preso e devolvido ao fechar, `Esc` fecha — teste E2E de teclado |
| Select | `<select>` nativo | Estilizado com tokens; sem select customizado no MVP |
| Disclosure / acordeão | `<details>/<summary>` | — |
| Dropdown menu, Tabs, Tooltip | Só se necessário | Padrão ARIA do APG (W3C) implementado e testado por teclado |
| Toast | Região `aria-live="polite"` alimentada por HTMX/mensagens do Django | Não usar para erro que exige ação (usar Alert) |
| Confirmação irreversível (recusar comprovante, resolver chamado) | Dialog | Ação reversível usa toast, não dialog |

## 6. Governança da dependência

- A versão adotada do DS fica registrada no topo deste arquivo e em `src/static/css/ds/VERSION`.
- Atualizar o DS = PR próprio (`chore/ds-vX.Y.Z`): ler o `CHANGELOG` do DS, copiar os arquivos gerados, comparar os componentes de template com as `cva` alteradas, rodar E2E visual/teclado, anotar no `CHANGELOG` deste projeto.
- **Nunca editar** os arquivos gerados copiados do DS; mudança de token é feita no DS.
- Versão **major** do DS (token renomeado/removido) é tratada como trilha SDD (afeta muitas telas).

## 7. Travas (o que garante que isto é cumprido)

| Regra | Trava |
|---|---|
| Sem cor literal | CI falha em `#[0-9a-fA-F]{3,8}\b`, `rgb(` ou `hsl(` em `src/templates/**` e no CSS do projeto (fora de `static/css/ds/`) |
| Arquivos do DS intactos | CI compara o hash de `static/css/ds/*` com o registrado em `VERSION` |
| Contraste | Garantido no build do DS (`npm run tokens` falha abaixo de 4,5:1 / 3:1); aqui, checagem automatizada de acessibilidade nos E2E (candidato: axe-core no Playwright) |
| Teclado e foco | E2E Playwright por componente interativo (dialog, menus) |
| Celular e desktop | E2E dos fluxos críticos nos dois viewports, nos temas dark e light |
| Checklist por tela | `docs/checklists/definition-of-done.md` → seção UI |

## 8. Checklist por tela (do DS 07, para o review)

- [ ] Um `<h1>` por página; títulos sem saltos
- [ ] Todo controle com rótulo (visível ou `aria-label`)
- [ ] Erros com `aria-describedby` e `aria-invalid`
- [ ] Navegável só por teclado; ordem de foco lógica
- [ ] Nada depende só de hover
- [ ] Testado com zoom de 200%, em dark, light e alto contraste
- [ ] Testado em viewport de celular
- [ ] Só tokens semânticos; uma ação primária por região
