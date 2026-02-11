# Curso de Verão IAG-USP 2026 — Projeto Reprodutível

Repositório desenvolvido durante o Curso de Verão do IAG-USP (2026) com foco em organização, automação e reprodutibilidade de análises científicas.

Este projeto demonstra como estruturar um artigo científico de forma que todos os resultados — da obtenção dos dados até o PDF final — possam ser gerados automaticamente.

---

## Estrutura

code/ Scripts de análise
dados/ Dados brutos (gerados automaticamente)
resultados/ Resultados intermediários
figuras/ Figuras produzidas pelos scripts
paper/ Documento LaTeX
fonts/ Fontes utilizadas no artigo
Makefile Orquestra o workflow completo


---

## Reproduzir o projeto

Requisitos:

- Python 3
- Make
- Tectonic
- Git

Para gerar todos os resultados e o PDF final:

```bash
make
Para remover arquivos gerados:

make clean
Dados
Os dados de temperatura são baixados automaticamente pelo pipeline.
Eles não são versionados no repositório.

Licença
Código sob licença MIT.
