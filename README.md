# 🌍🪨 Curso de Verão IAG-USP 2026 - Trabalho Final

Projeto desenvolvido no contexto do **Curso de Verão do IAG-USP (2026)**
com foco em organização, automação e reprodutibilidade de análises
científicas.

Este repositório demonstra um workflow completo e automatizado que
permite:

-   📥 Baixar dados
-   🧮 Processar e analisar informações
-   📊 Gerar figuras automaticamente
-   📝 Compilar um artigo em LaTeX com fonte personalizável
-   🔁 Garantir reprodutibilidade computacional

------------------------------------------------------------------------

## 🗂 Estrutura do Repositório

    .
    ├── code/              # Scripts de análise em Python
    ├── paper/             # Documento LaTeX do artigo
    ├── dados/             # Dados brutos (gerados automaticamente)
    ├── resultados/        # Resultados intermediários (não versionados)
    ├── figuras/           # Figuras geradas automaticamente (não versionadas)
    ├── fonts/             # Fontes locais usadas no PDF (não versionadas)
    ├── Makefile           # Orquestra todo o workflow
    ├── environment.yml    # Ambiente reprodutível Conda
    └── README.md

------------------------------------------------------------------------

## ⚙️ Requisitos

Recomendado utilizar **Miniforge / Conda**.

Softwares utilizados:

-   🐍 Python 3.11
-   🧮 NumPy
-   🐼 Pandas
-   📈 Matplotlib
-   🛠 GNU Make
-   📄 Tectonic (compilador LaTeX)

------------------------------------------------------------------------

## 🧪 Criando o Ambiente Reprodutível

### 1️⃣ Instale o Miniforge (caso ainda não tenha)

👉 https://conda-forge.org/download/

### 2️⃣ Crie o ambiente

``` bash
conda env create -f environment.yml
```

### 3️⃣ Ative o ambiente

``` bash
conda activate curso-verao-iag-2026
```

------------------------------------------------------------------------

## 🚀 Gerar Todo o Projeto

Após ativar o ambiente:

``` bash
make
```

Isso irá:

-   📥 Baixar os dados
-   🧮 Executar a análise
-   📊 Gerar as figuras
-   📝 Compilar o PDF final

------------------------------------------------------------------------

## 🧹 Limpar Arquivos Gerados

``` bash
make clean
```

------------------------------------------------------------------------

## 🖋 Fontes

O artigo utiliza fontes locais via `fontspec`.

⚠ A fonte **Gilroy** não é versionada no repositório devido a possíveis
restrições de licença.

Caso deseje utilizá-la:

1.  Crie uma pasta chamada `fonts/`
2.  Coloque os arquivos `.ttf` dentro dela
3.  Recompile o projeto

------------------------------------------------------------------------

## 🔬 Filosofia do Projeto

Este repositório segue princípios de:

-   🌎 Ciência aberta
-   🔁 Reprodutibilidade científica
-   🧱 Organização modular
-   ⚙ Automação de workflows
-   🗃 Separação clara entre dados, código e resultados

Qualquer pessoa deve conseguir clonar o repositório e reproduzir o
artigo do zero.

------------------------------------------------------------------------

## 📄 Licença

-   💻 Código: MIT
-   📝 Conteúdo textual: CC-BY

------------------------------------------------------------------------

## 👤 Autor

Iago Guilherme\
Instituto de Astronomia, Geofísica e Ciências Atmosféricas (IAG-USP)

## 👥 Informações do Curso

| Função       | Nome |
|--------------|------|
| 👨‍🏫 Instrutor | [Leonardo Uieda](https://www.leouieda.com/) |
| 👨‍🔬 Monitores | [Yago Moreira Castro](https://github.com/YagoMCastro) |
