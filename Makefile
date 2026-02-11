# # # Pipeline que gera os resultados, figuras e o PDF do artigo
# # ###############################################################################
# #
# # # Regras para geração dos produtos
# # ###############################################################################
# #
# # # Gera o PDF com o tectonic. Depende do LaTeX, Bibtex, figuras e variáveis
# # paper/paper.pdf: paper/paper.tex paper/referencias.bib figuras/taxas_variacao.png paper/variaveis/n_paises.tex paper/variaveis/paises.tex
# # 	tectonic -X compile paper/paper.tex
# #
# # # Regra para remover todos os arquivos gerados pelo Make.
# # # Isso é padrão em quase todos os Makefiles.
# # clean:
# # 	rm -v -r -f paper/paper.pdf resultados/ paper/variaveis/ dados/ figuras/
# #
# # dados/temperature-data.zip: code/baixa_dados.py
# # 	python code/baixa_dados.py
# #
# # # Gera os resultados de variação de temperatura
# # resultados/variacao_temperatura.csv: code/variacao_temperatura.py dados/temperature-data.zip
# # 	# O mkdir -p cria a pasta caso ela não exista.
# # 	# O -p faz com que não ocorra um erro se a pasta já existir.
# # 	mkdir -p resultados
# # 	python code/variacao_temperatura.py > resultados/variacao_temperatura.csv
# #
# # # Gera a figura a partir dos resultados
# # figuras/taxas_variacao.png: code/plota_dados.py resultados/variacao_temperatura.csv
# # 	# O mkdir -p cria a pasta caso ela não exista.
# # 	# O -p faz com que não ocorra um erro se a pasta já existir.
# # 	mkdir -p figuras
# # 	python code/plota_dados.py
# #
# # # Regras para gerar as variáveis utilizadas no LaTeX
# # paper/variaveis/n_paises.tex: dados/temperature-data.zip
# # 	# O mkdir -p cria a pasta caso ela não exista. O -p faz com que não ocorra
# # 	# um erro se a pasta já existir.
# # 	mkdir -p paper/variaveis
# # 	printf "%s" "\\newcommand{\\NPaises}{`ls dados/temperatura/*.csv | wc -l`}" > paper/variaveis/n_paises.tex
# #
# # paper/variaveis/paises.tex: code/lista_paises.py dados/temperature-data.zip
# # 	# O mkdir -p cria a pasta caso ela não exista. O -p faz com que não ocorra
# # 	# um erro se a pasta já existir.
# # 	mkdir -p paper/variaveis
# # 	python code/lista_paises.py > paper/variaveis/paises.tex
#
#
#
# # Pipeline que gera os resultados, figuras e o PDF do artigo
# ###############################################################################
#
# .PHONY: all clean
#
# # Alvo padrão
# all: paper/paper.pdf
#
# # Lista de fontes (ajuste conforme os arquivos reais que você tem no repo)
# FONTS = \
# 	fonts/Gilroy-Light.ttf \
# 	fonts/Gilroy-Bold.ttf \
# 	fonts/Gilroy-BoldItalic.ttf \
# 	fonts/Gilroy-SemiBold.ttf \
# 	fonts/Gilroy-ExtraBold.ttf \
# 	fonts/Gilroy-Black.ttf \
# 	fonts/Gilroy-Heavy.ttf \
# 	fonts/Gilroy-MediumItalic.ttf \
# 	fonts/Gilroy-ThinItalic.ttf
#
# # Gera o PDF com o tectonic. Depende do LaTeX, Bibtex, figuras, variáveis e fontes
# paper/paper.pdf: paper/paper.tex paper/referencias.bib figuras/taxas_variacao.png figuras/mapa_variacao.png paper/variaveis/n_paises.tex paper/variaveis/paises.tex
# 	tectonic -X compile paper/paper.tex
# 	open -a "Google Chrome" paper/paper.pdf
#
#
# # Regra para remover todos os arquivos gerados pelo Make.
# clean:
# 	rm -v -r -f paper/paper.pdf resultados/ paper/variaveis/ dados/ figuras/
#
# dados/temperature-data.zip: code/baixa_dados.py
# 	python code/baixa_dados.py
#
# # Gera os resultados de variação de temperatura
# resultados/variacao_temperatura.csv: code/variacao_temperatura.py data/temperature-data.zip
# 	mkdir -p resultados
# 	python code/variacao_temperatura.py > resultados/variacao_temperatura.csv
#
# # Gera a figura a partir dos resultados
# figuras/taxas_variacao.png: code/plota_dados.py resultados/variacao_temperatura.csv
# 	mkdir -p figuras
# 	python code/plota_dados.py
#
# # Regras para gerar as variáveis utilizadas no LaTeX
# paper/variaveis/n_paises.tex: dados/temperature-data.zip
# 	mkdir -p paper/variaveis
# 	printf "%s" "\\newcommand{\\NPaises}{`ls data/temperatura/*.csv | wc -l`}" > paper/variaveis/n_paises.tex
#
# paper/variaveis/paises.tex: code/lista_paises.py dados/temperature-data.zip
# 	mkdir -p paper/variaveis
# 	python code/lista_paises.py > paper/variaveis/paises.tex
#
# figuras/mapa_variacao.png: code/gera_mapa.py resultados/variacao_temperatura.csv dados/base/world.geojson
# 		mkdir -p figuras
# 		python code/gera_mapa.py
#
#
# dados/base/world.geojson:
# 			mkdir -p dados/base
# 			curl -L -o dados/base/world.geojson https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson



# Pipeline que gera os resultados, figuras e o PDF do artigo
###############################################################################

.PHONY: all clean view

# Alvo padrão: gera o PDF (e tudo que ele depende)
all: paper/paper.pdf


###############################################################################
# PDF do artigo
###############################################################################
# OBS:
# - "view" abre o PDF no Chrome (se você quiser separar build e abrir).
# - O PDF depende das figuras e das variáveis geradas automaticamente.

paper/paper.pdf: paper/paper.tex paper/referencias.bib \
	figuras/taxas_variacao.png figuras/mapa_variacao.png \
	paper/variaveis/n_paises.tex paper/variaveis/paises_extremos.tex
	tectonic -X compile paper/paper.tex

# Abre o PDF no Google Chrome (não mistura com build)
view: paper/paper.pdf
	open -a "Google Chrome" paper/paper.pdf


###############################################################################
# Limpeza
###############################################################################
clean:
	rm -v -r -f paper/paper.pdf resultados/ paper/variaveis/ dados/ figuras/


###############################################################################
# Dados
###############################################################################
dados/temperature-data.zip: code/baixa_dados.py
	python code/baixa_dados.py


###############################################################################
# Resultados
###############################################################################
resultados/variacao_temperatura.csv: code/variacao_temperatura.py dados/temperature-data.zip
	mkdir -p resultados
	python code/variacao_temperatura.py > resultados/variacao_temperatura.csv


###############################################################################
# Figuras
###############################################################################
figuras/taxas_variacao.png: code/plota_dados.py resultados/variacao_temperatura.csv
	mkdir -p figuras
	python code/plota_dados.py

# Baixa a base do mapa (GeoJSON do mundo) se ainda não existir.
# Essa regra é reprodutível: ao rodar "make", o arquivo é baixado automaticamente.
dados/base/world.geojson:
	mkdir -p dados/base
	curl -L -o dados/base/world.geojson https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson

# Gera o mapa a partir do CSV de resultados + base do mundo (GeoJSON)
figuras/mapa_variacao.png: code/gera_mapa.py resultados/variacao_temperatura.csv dados/base/world.geojson
	mkdir -p figuras
	python code/gera_mapa.py


###############################################################################
# Variáveis do LaTeX
###############################################################################
# Usa um único script Bash para gerar:
# - NPaises (contagem)
# - PaisesMaiores/PaisesMenores (extremos)
#
# O script lê diretamente o CSV final (resultados/variacao_temperatura.csv),
# então as variáveis ficam sempre coerentes com as figuras.

paper/variaveis/n_paises.tex: resultados/variacao_temperatura.csv code/conta_dados.sh
	mkdir -p paper/variaveis
	bash code/conta_dados.sh conta

paper/variaveis/paises_extremos.tex: resultados/variacao_temperatura.csv code/conta_dados.sh
	mkdir -p paper/variaveis
	bash code/conta_dados.sh extremos
