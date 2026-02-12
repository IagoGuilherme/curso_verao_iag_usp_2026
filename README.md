# 🌍🪨 Curso de Verão IAG-USP 2026 - Trabalho Final

<!-- Imagem renderizada no topo (recomendado versionar em assets/) -->
<p align="center">
  <img src="assets/mapa_variacao.png" alt="Mapa mundial da variação de temperatura" width="900">
</p>

<p align="center">
  <img alt="Python" src="https://img.shields.io/badge/Python-3.11-3776AB?logo=python&logoColor=white">
  <img alt="GNU Make" src="https://img.shields.io/badge/GNU%20Make-workflow-0A7F2E">
  <img alt="Tectonic" src="https://img.shields.io/badge/LaTeX-Tectonic-EB6A00">
  <img alt="GeoPandas" src="https://img.shields.io/badge/GeoPandas-mapas-2C7FB8">
  <img alt="Licença" src="https://img.shields.io/badge/Licença-MIT-brightgreen">
  <!-- DOI (Zenodo): substitua o link/badge quando você criar o depósito no Zenodo -->
  <a href="https://zenodo.org/">
    <img alt="DOI (Zenodo)" src="https://img.shields.io/badge/DOI-Zenodo%20(a%20definir)-blueviolet">
  </a>
</p>

Projeto desenvolvido no contexto do **Curso de Verão do IAG-USP (2026)** para demonstrar um workflow científico **reprodutível**: download de dados, processamento, geração de figuras (incluindo **mapa mundial**) e compilação automática de um artigo em LaTeX — tudo com um único comando.

---

## 🧭 Visão geral

✅ O que este repositório faz:

- 📦 Baixa dados de temperatura (automático)  
- 📊 Calcula a taxa de variação recente (°C/ano) por país  
- 📈 Gera um gráfico com **extremos** (maiores e menores variações)  
- 🌍 Gera um **mapa-múndi** com escala de cores (GeoPandas + Matplotlib)  
- 🧾 Gera variáveis LaTeX automaticamente (ex.: `\NPaises`, extremos)  
- 🧱 Compila o artigo em PDF com **Tectonic**  

---

## 🗂 Estrutura do projeto

```
code/                 → scripts Python e Bash
paper/                → artigo em LaTeX
paper/variaveis/       → variáveis geradas automaticamente (não versionadas)
figuras/              → figuras geradas automaticamente (não versionadas)
resultados/           → saídas intermediárias (não versionadas)
dados/                → dados baixados automaticamente (não versionados)
dados/base/           → base cartográfica (GeoJSON) baixada automaticamente
assets/               → imagens para o README (versionadas: PNG/GIF)
Makefile              → orquestra todo o workflow
INSTALL.md            → instalação (macOS)
```

---

## 🔁 Diagrama do workflow (reprodutibilidade)

```text
          ┌──────────────────────┐
          │  code/baixa_dados.py  │
          └───────────┬──────────┘
                      │
                      ▼
          ┌──────────────────────────────┐
          │ resultados/variacao_*.csv     │  ← code/variacao_temperatura.py
          └───────────┬──────────────────┘
                      │
          ┌───────────┴───────────────────────────┐
          ▼                                       ▼
┌───────────────────────┐              ┌────────────────────────┐
│ figuras/taxas_*.png    │              │ figuras/mapa_*.png      │
│ ← code/plota_dados.py  │              │ ← code/gera_mapa.py     │
└───────────┬───────────┘              └───────────┬────────────┘
            │                                      │
            └───────────┬──────────────────────────┘
                        ▼
          ┌──────────────────────────────┐
          │ paper/variaveis/*.tex         │  ← code/conta_dados.sh
          └───────────┬──────────────────┘
                      ▼
          ┌──────────────────────────────┐
          │ paper/paper.pdf              │  ← Tectonic
          └──────────────────────────────┘
```

---

## 🚀 Como reproduzir

### 1) Instale as dependências (macOS)
Siga o passo-a-passo em **[`INSTALL.md`](INSTALL.md)**.

### 2) Gere tudo
```bash
make
```

### 3) Abra o PDF
```bash
make view
```

## 🧰 Tecnologias usadas

- 🐍 Python 3.11  
- 📚 NumPy, Pandas  
- 🖼 Matplotlib  
- 🗺 GeoPandas  
- 🧱 GNU Make  
- 🧾 Tectonic (LaTeX)  

---

## 🏛 Contexto acadêmico

Instituto de Astronomia, Geofísica e Ciências Atmosféricas — Universidade de São Paulo (IAG-USP)

- **Instrutor:** Leonardo Uieda — https://www.leouieda.com/ (GitHub: https://github.com/leouieda)  
- **Monitores:**  
  - Arthur Siqueira de Macêdo — https://github.com/arthursmacedo  
  - Yago Moreira Castro — https://github.com/YagoMCastro  

---


## 📖 How to Cite

If you use this project, please cite:

Guilherme, I. (2026). *Curso de Verão IAG-USP 2026 — Reproducible Scientific Project* (v1.0). Zenodo. https://doi.org/10.5281/zenodo.18615451


---

## ⚖️ Licença

- Código (Python/Bash/Make/LaTeX): **MIT**  
- Texto do artigo/Markdown: você pode manter **CC-BY** (se quiser separar), ou usar MIT para tudo.

---

# English

<p align="center">
  <img alt="Python" src="https://img.shields.io/badge/Python-3.11-3776AB?logo=python&logoColor=white">
  <img alt="GNU Make" src="https://img.shields.io/badge/GNU%20Make-workflow-0A7F2E">
  <img alt="Tectonic" src="https://img.shields.io/badge/LaTeX-Tectonic-EB6A00">
  <img alt="GeoPandas" src="https://img.shields.io/badge/GeoPandas-maps-2C7FB8">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-brightgreen">
  <a href="https://zenodo.org/">
    <img alt="DOI (Zenodo)" src="https://img.shields.io/badge/DOI-Zenodo%20(TBD)-blueviolet">
  </a>
</p>

This repository (IAG-USP Summer Course 2026) demonstrates a **fully reproducible** scientific workflow: data download, processing, figure generation (including a **global map**), and automated LaTeX compilation — all driven by `make`.

## Quickstart

- Install dependencies (macOS): see **`INSTALL.md`**
- Build everything:
  ```bash
  make
  ```
- Open the PDF:
  ```bash
  make view
  ```

## Reproducible workflow

```text
Data → Processing → Results → Figures → LaTeX variables → PDF
```

## 📖 How to Cite

If you use this project, please cite:

Guilherme, I. (2026). *Curso de Verão IAG-USP 2026 — Reproducible Scientific Project* (v1.0). Zenodo. https://doi.org/10.5281/zenodo.18615451

## License

MIT (code). You may optionally use CC-BY for text.


# 🍽️ Workflow v2.0 --- Explicação para Iniciantes (Analogias de Cozinha)

Para explicar esse fluxo de forma simples, vamos usar uma analogia de
**Cozinha Profissional**.

Se você é um "noob" no mundo do Python, imagine que:

-   💻 Seu computador é o **prédio**
-   📂 Seu projeto é um **jantar de gala**
-   🎯 O objetivo é que ele saia **perfeito e idêntico toda vez**

Aqui está o workflow v2.0 explicado passo a passo.

------------------------------------------------------------------------

## 1️⃣ Miniforge --- A Fundação da Cozinha

Antes de cozinhar, você precisa de uma cozinha equipada.

### O que ele é

O **Miniforge** é o instalador que coloca as ferramentas básicas no seu
Mac.

### Comparação com Anaconda

-   **Anaconda** = um buffet gigantesco com 500 pratos prontos\
    (ocupa muito espaço e vem com coisas que você nunca vai usar)
-   **Miniforge** = uma cozinha de chef\
    (minimalista, leve e focada no que realmente importa --- usando o
    canal `conda-forge`)

### Por que usar?

Em Macs modernos, o Miniforge: - É mais rápido - Dá menos erro de
conflito de bibliotecas - É mais limpo e controlado

------------------------------------------------------------------------

## 2️⃣ Conda --- O Chef de Cozinha

Agora que você tem a cozinha, precisa de alguém para gerenciar tudo.

### O que ele faz

O **Conda** lê o arquivo `environment.yml` e entende exatamente o que
precisa ser instalado.

### Comparação com Pip

-   **Pip** = entregador que traz apenas ingredientes de Python\
-   **Conda** = chef experiente que sabe:
    -   Instalar pacotes Python
    -   Instalar bibliotecas de sistema (C++, GeoTIFF)
    -   Instalar ferramentas como LaTeX ou Tectonic

Se sua receita envolve mapas complexos ou geração de PDF científico, o
Conda resolve tudo sozinho.

------------------------------------------------------------------------

## 3️⃣ environment.yml --- A Receita Oficial

Esse arquivo é o segredo da **reprodutibilidade**.

### O que ele faz

Lista: - Versão exata do Python - Versões exatas de cada biblioteca
(Pandas, GeoPandas, etc.) - Ferramentas externas como Tectonic

### Por que isso é importante?

Se você enviar apenas seu código para alguém: - Pode não funcionar -
Pode quebrar por causa de versões diferentes

Com o `environment.yml`, você está entregando a **receita exata**.

O resultado será o mesmo: - No seu Mac - No IAG-USP - Em Harvard - Daqui
a 2 anos

------------------------------------------------------------------------

## 4️⃣ O Ambiente (ex: `curso-verao`) --- A Bancada Isolada

Você não quer misturar a farinha do bolo com o sal da carne.

Quando você roda:

``` bash
conda activate curso-verao
```

Você entra em uma "caixa isolada".

### O que isso significa?

-   Apenas as versões definidas naquela receita existem ali dentro
-   Atualizações de outros projetos não quebram seu artigo
-   Seu ambiente fica controlado e seguro

------------------------------------------------------------------------

## 5️⃣ Makefile --- O Livro de Ordens

O Makefile é quem realmente automatiza o trabalho.

### O que ele faz?

Ele diz:

> "Use o Python desse ambiente, gere os mapas, e depois use o Tectonic
> para montar o PDF."

### A grande vantagem

Em vez de digitar 10 comandos no terminal, você digita:

``` bash
make
```

E ele: - Executa os scripts - Atualiza figuras se os dados mudarem -
Gera o PDF final - Faz tudo na ordem certa

Sem erro humano.

------------------------------------------------------------------------

# 📊 Resumo Comparativo

  --------------------------------------------------------------------------
  Ferramenta            Analogia         Por que não a outra?
  --------------------- ---------------- -----------------------------------
  **Miniforge**         A Cozinha        Melhor que Anaconda por ser leve e
                                         rápida no Mac

  **Conda**             O Chef           Melhor que Pip por gerenciar mapas,
                                         C++, LaTeX

  **environment.yml**   A Receita        Garante que o projeto não
                                         "estrague" no futuro

  **Makefile**          O Gerente        Automatiza tudo e evita erro humano
  --------------------------------------------------------------------------

------------------------------------------------------------------------

# 🚀 O Toque Final da v2.0

O **Tectonic** (motor de PDF) está dentro da lista de dependências do
Conda.

Isso é poderoso.

Significa que: - Seu projeto não depende de LaTeX instalado na máquina -
Ele traz o próprio "escritor de PDF" dentro do ambiente - Ele é portátil
e totalmente reproduzível

É um workflow de nível profissional.

------------------------------------------------------------------------

# ▶️ Como Rodar o Projeto

## 1️⃣ Instale o Miniforge (uma vez só)

Baixe e instale a versão para seu sistema.

------------------------------------------------------------------------

## 2️⃣ Crie o ambiente

Dentro da pasta do projeto:

``` bash
conda env create -f environment.yml
```

------------------------------------------------------------------------

## 3️⃣ Ative o ambiente

``` bash
conda activate curso-verao
```

------------------------------------------------------------------------

## 4️⃣ Gere tudo automaticamente

``` bash
make
```

Pronto.

-   Mapas serão gerados
-   Figuras atualizadas
-   PDF compilado
-   Tudo reproduzível

------------------------------------------------------------------------

# 🎯 Filosofia do Workflow

Esse projeto foi estruturado para ser:

-   ✅ Reproduzível
-   ✅ Portátil
-   ✅ Automatizado
-   ✅ Cientificamente robusto
-   ✅ Seguro contra conflitos de versão

É como ter uma cozinha profissional portátil dentro do seu computador.

