
# Pipeline que gera os resultados, figuras e o PDF do artigo
###############################################################################

.PHONY: all clean distclean view logs

# Alvo principal: Compila tudo e abre o PDF ao final
all:
	@clear
	@echo "🚀 Iniciando pipeline (make)..."
	@$(MAKE) --no-print-directory paper/paper.pdf
	@echo "✅ Tudo certo: paper/paper.pdf está atualizado."
	@$(MAKE) --no-print-directory view

###############################################################################
# PDF do artigo
###############################################################################
paper/paper.pdf: paper/paper.tex paper/referencias.bib \
	figuras/taxas_variacao.png figuras/mapa_variacao.png \
	paper/variaveis/n_paises.tex paper/variaveis/paises_extremos.tex
	@echo "📝 Compilando o artigo (LaTeX → PDF)..."
	@tectonic -X compile paper/paper.tex > paper/build.log 2>&1 || \
	 (echo "❌ Erro no LaTeX. Veja paper/build.log"; exit 1)
	@echo "✅ PDF gerado em: paper/paper.pdf"

# Comando para visualizar o PDF
view: paper/paper.pdf
	@echo "🌐 Abrindo PDF no Google Chrome..."
	@open -a "Google Chrome" paper/paper.pdf || open paper/paper.pdf || echo "⚠️ Não foi possível abrir o navegador automaticamente."

###############################################################################
# Limpeza
###############################################################################
clean:
	@echo "🧹 Limpeza profunda..."
	@rm -rf paper/paper.pdf resultados/ figuras/ data/ paper/variaveis/
	@rm -f paper/*.aux paper/*.bbl paper/*.blg paper/*.log paper/*.out paper/*.fdb_latexmk paper/*.fls paper/*.synctex.gz
	@echo "✅ Limpo."

###############################################################################
# Dados
###############################################################################
# Garante que a pasta data exista antes de rodar o script
data/temperature-data.zip: code/baixa_dados.py
	@mkdir -p data
	@echo "📦 Baixando dados de temperatura..."
	@python code/baixa_dados.py
	@echo "✅ Dados baixados."

###############################################################################
# Resultados
###############################################################################
resultados/variacao_temperatura.csv: code/variacao_temperatura.py data/temperature-data.zip
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

# Baixa a base do mapa se necessário
data/base/world.geojson:
	@mkdir -p $(@D)
	@echo "🌍 Baixando base cartográfica..."
	@curl -sSL -o $@ https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson
	@echo "✅ Base salva em: $@"

figuras/mapa_variacao.png: code/gera_mapa.py resultados/variacao_temperatura.csv data/base/world.geojson
	@echo "🌍 Gerando mapa mundial da variação (°C/ano)..."
	@mkdir -p figuras
	@PYTHONWARNINGS=ignore python code/gera_mapa.py > /dev/null 2>&1
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

###############################################################################
# Logs
###############################################################################
logs:
	@echo "📄 Último log do LaTeX:"
	@tail -n 60 paper/build.log || echo "⚠️ Nenhum log encontrado."
