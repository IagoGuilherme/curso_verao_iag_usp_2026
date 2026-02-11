# Curso de Verão IAG-USP 2026 --- Projeto Reprodutível

Projeto desenvolvido no contexto do Curso de Verão do IAG-USP (2026)
para demonstrar um workflow reprodutível: download de dados,
processamento, geração de figuras e compilação de um artigo em LaTeX.

## Estrutura

-   `code/` --- scripts de análise e geração de figuras\
-   `paper/` --- artigo em LaTeX\
-   `figuras/` --- figuras geradas automaticamente (não versionadas)\
-   `resultados/` --- saídas intermediárias (não versionadas)\
-   `dados/` --- dados baixados automaticamente (não versionados)\
-   `fonts/` --- fontes utilizadas no PDF (ver nota abaixo)\
-   `Makefile` --- orquestra o workflow completo

## Como reproduzir

### Requisitos

-   Python 3\
-   GNU Make\
-   Tectonic (LaTeX)

### Gerar todos os resultados e o PDF final

``` bash
make
```

### Limpar arquivos gerados

``` bash
make clean
```

## Fontes

O artigo utiliza fontes locais via `fontspec`.

-   Se a pasta `fonts/` estiver presente, o LaTeX deve encontrar as
    fontes automaticamente.
-   Caso as fontes não estejam versionadas no repositório, coloque os
    arquivos `.ttf` na pasta `fonts/` antes de compilar.

## Licença

Código distribuído sob licença MIT.
