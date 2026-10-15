# Guia de Documentação

> Documentação é parte de terminar cada coisa, não tarefa do fim do projeto. Regra-mãe: **documente a decisão e o porquê; o código já diz o quê.**

## 1. Camadas, lugar e gatilho

| Camada | Onde | Responde | Gatilho |
|---|---|---|---|
| Norte / produto | `docs/00-discovery/` | O que é, para quem, RF/RNF | Fase 0; revisar se o produto mudar |
| Questões abertas | `docs/00-discovery/questoes-em-aberto.md` | O que ainda não sabemos | Ao surgir; ao responder (data + fonte) |
| Decisões | `docs/01-architecture/adr/` | Por que assim | **No momento da decisão, antes de implementar** |
| Constituição | `.specify/memory/constitution.md` | Princípios inegociáveis | Emendas raras, versionadas, espelhadas no `CLAUDE.md` |
| Atributos de qualidade | `docs/ATRIBUTOS-DE-QUALIDADE.md` | Como segurança, desempenho etc. são garantidos | Quando uma trava nova entra ou muda |
| Segurança / testes / observabilidade | `docs/02` a `04` | Regras e estratégias | Ao decidir; revisar por fase |
| Runbooks | `docs/05-runbooks/` | Como operar | **Antes** de precisar em produção, e ensaiado |
| Design | `docs/06-design/` | Regras de UI sobre o design system | Antes de construir tela; ao atualizar o DS |
| Feature | `specs/NNN-nome/` | Contrato da feature | Fluxo SDD |
| Roadmap | `docs/ROADMAP.md` | Ordem, marcos, pendências | Fase/marco muda; pendência descoberta |
| Histórico | `CHANGELOG.md` | O que mudou | Todo merge relevante |
| Código | docstring / comentário | Porquês locais | No mesmo commit do código |
| Fase atual | `CLAUDE.md` | Onde estou | Virou de fase (poucas linhas!) |

## 2. ADR

- Quando: decisão com mais de um caminho e custo de reverter. Teste: *"daqui a 6 meses alguém vai perguntar por que foi assim?"*
- Formato: `docs/01-architecture/adr/adr-template.md`. **Alternativas** são a parte mais importante.
- Nunca reescreva ADR aceito: crie outro que o substitui.
- Número reservado sem arquivo é aceitável — não invente numeração para esconder lacuna.

## 3. Comentários no código

- Nome bom > comentário.
- Comente a **armadilha**, não a mecânica: `# gravar o item do feed na MESMA transação — RNF-AUD-04`.
- **Referência cruzada:** `# RF-PAG-04: recusa exige motivo` liga o código à intenção e ajuda o review.
- Docstring em serviço e regra de domínio não óbvia: o que faz, o que assume, casos de borda.
- Termos do glossário (linguagem ubíqua) em nomes de classe, função e variável: `Cobranca`, `Competencia`, `Vinculo`, `ItemFeed`.

## 4. Mantenha o `CLAUDE.md` curto

Máximo ~200 linhas **e** ~15 KB. Ele indexa, não duplica. Histórico de fase vai para `CHANGELOG`, `specs/` e PR — nunca para o `CLAUDE.md` (lição do método: arquivo chegou a 60 KB e degradou o seguimento de instruções). Conferir o tamanho em bytes a cada virada de fase.

## 5. CHANGELOG

[Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/). Seções: Adicionado, Alterado, Decidido, Descartado, Removido, Corrigido, Segurança. Antes do código, registra também decisões de produto.

## 6. IA escrevendo documentação

- **Bom:** "documente esta função a partir do código"; "formate minhas notas neste template de ADR".
- **Perigoso:** "escreva o ADR dessa decisão" — ela inventa contexto e alternativas.
- O **porquê sai do autor**. Leia toda doc gerada com a régua do código: o que o autor não decidiu ou não é verdade é ficção — corte.
- **Doc desatualizada é pior que ausente.** Se não vai manter, não escreva.

## 7. Não documente

Código óbvio; coisa que muda toda semana; procedimento feito uma vez só.
