
# Pipeline que gera os resultados, figuras e o PDF do artigo
###############################################################################

.PHONY: all clean distclean view

all: paper/paper.pdf

###############################################################################
# PDF do artigo
###############################################################################
paper/paper.pdf: paper/paper.tex paper/referencias.bib \
	figuras/taxas_variacao.png figuras/mapa_variacao.png \
	paper/variaveis/n_paises.tex paper/variaveis/paises_extremos.tex
	@echo "📝 Compilando o artigo (LaTeX → PDF)..."
	@tectonic -X compile paper/paper.tex > paper/build.log 2>&1 || (echo "❌ Erro no LaTeX. Veja paper/build.log"; exit 1)
	@echo "✅ PDF gerado em: paper/paper.pdf"

view: paper/paper.pdf
	@echo "🌐 Abrindo PDF no Google Chrome..."
	@open -a "Google Chrome.app" "paper/paper.pdf"


###############################################################################
# Limpeza
###############################################################################
clean:
	@echo "🧹 Limpando arquivos gerados (figuras, resultados, variáveis, PDF)..."
	@rm -v -r -f paper/paper.pdf resultados/ paper/variaveis/ figuras/ >/dev/null 2>&1 || true
	@echo "✅ Limpeza concluída."

distclean: clean
	@echo "🧹 Limpando também os dados baixados..."
	@rm -v -r -f dados/ >/dev/null 2>&1 || true
	@echo "✅ Distclean concluído."

###############################################################################
# Dados
###############################################################################
dados/temperature-data.zip: code/baixa_dados.py
	@echo "📦 Baixando dados de temperatura..."
	@python code/baixa_dados.py
	@echo "✅ Dados baixados."

###############################################################################
# Resultados
###############################################################################
resultados/variacao_temperatura.csv: code/variacao_temperatura.py dados/temperature-data.zip
	@echo "📊 Calculando taxa de variação (°C/ano) por país..."
	@mkdir -p resultados
	@python code/variacao_temperatura.py > resultados/variacao_temperatura.csv
	@echo "✅ Resultados em: resultados/variacao_temperatura.csv"

###############################################################################
# Figuras
###############################################################################
figuras/taxas_variacao.png: code/plota_dados.py resultados/variacao_temperatura.csv
	@echo "📈 Gerando gráfico de maiores/menores variações..."
	@mkdir -p figuras
	@python code/plota_dados.py
	@echo "✅ Figura gerada: figuras/taxas_variacao.png"

dados/base/world.geojson:
	@echo "🗺️  Baixando base cartográfica (world.geojson)..."
	@mkdir -p dados/base
	@curl -fL --retry 3 --retry-delay 2 -o dados/base/world.geojson \
		https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson
	@echo "✅ Base salva em: dados/base/world.geojson"

figuras/mapa_variacao.png: code/gera_mapa.py resultados/variacao_temperatura.csv dados/base/world.geojson
		@echo "🌍 Gerando mapa mundial da variação (°C/ano)..."
		@mkdir -p figuras
		@PYTHONWARNINGS=ignore python code/gera_mapa.py 2>/dev/null
		@echo "✅ Figura gerada: figuras/mapa_variacao.png"

###############################################################################
# Variáveis do LaTeX
###############################################################################
paper/variaveis/n_paises.tex: resultados/variacao_temperatura.csv code/conta_dados.sh
	@echo "🧾 Gerando variável LaTeX: NPaises..."
	@mkdir -p paper/variaveis
	@bash code/conta_dados.sh conta
	@echo "✅ Variável gerada: paper/variaveis/n_paises.tex"

paper/variaveis/paises_extremos.tex: resultados/variacao_temperatura.csv code/conta_dados.sh
	@echo "🧾 Gerando variáveis LaTeX: países extremos..."
	@mkdir -p paper/variaveis
	@bash code/conta_dados.sh extremos
	@echo "✅ Variáveis geradas: paper/variaveis/paises_extremos.tex"

logs:
		@echo "📄 Último log do LaTeX (paper/build.log):"
		@tail -n 60 paper/build.log || true
