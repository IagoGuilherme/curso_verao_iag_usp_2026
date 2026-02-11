# INSTALL.md --- Curso de Verão IAG-USP 2026

## Requisitos (macOS)

Este projeto foi desenvolvido e testado em **macOS** utilizando
Miniforge e Tectonic. Siga os passos abaixo para configurar corretamente
o ambiente.

------------------------------------------------------------------------

## 1. Instalar Xcode Command Line Tools

Abra o Terminal e execute:

``` bash
xcode-select --install
```

Isso instala ferramentas básicas como `git` e compiladores necessários.

------------------------------------------------------------------------

## 2. Instalar Miniforge

Baixe a versão correta para seu processador:

👉 https://conda-forge.org/download/

Ou via terminal (Apple Silicon):

``` bash
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
bash Miniforge3-MacOSX-arm64.sh
```

(Use `x86_64.sh` se seu Mac for Intel.)

Após a instalação, feche e reabra o terminal.

------------------------------------------------------------------------

## 3. Criar ambiente virtual

``` bash
conda create -n curso-verao python=3.11
conda activate curso-verao
```

------------------------------------------------------------------------

## 4. Instalar dependências

``` bash
conda install -y make tectonic numpy pandas matplotlib geopandas
```

Isso instala:

-   GNU Make\
-   Tectonic (LaTeX moderno)\
-   NumPy\
-   Pandas\
-   Matplotlib\
-   GeoPandas

------------------------------------------------------------------------

## 5. Testar instalação

``` bash
git --version
make --version
python --version
tectonic --version
```

------------------------------------------------------------------------

## 6. Rodar o projeto

Depois de clonar o repositório:

``` bash
make
make view
```

O pipeline irá:

1.  Baixar os dados
2.  Gerar resultados
3.  Criar figuras
4.  Compilar o PDF
5.  Abrir o artigo

------------------------------------------------------------------------

## Observações

-   Não é necessário instalar MacTeX.
-   Sempre ative o ambiente antes de rodar o projeto:

``` bash
conda activate curso-verao
```

------------------------------------------------------------------------

Projeto desenvolvido no contexto do Curso de Verão IAG-USP 2026.
