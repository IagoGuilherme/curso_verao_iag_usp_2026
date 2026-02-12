#!/bin/bash
set -euo pipefail

CSV="resultados/variacao_temperatura.csv"
OUT_DIR="paper/variaveis"

usage() {
  echo "Uso: $0 {conta|extremos}"
  exit 1
}

# Checa se o CSV existe e tem pelo menos 1 linha de dados além do cabeçalho
checar_csv() {
  if [ ! -f "$CSV" ]; then
    echo "❌ CSV não encontrado: $CSV"
    exit 1
  fi

  local linhas
  linhas=$(wc -l < "$CSV" | tr -d ' ')
  if [ "$linhas" -lt 2 ]; then
    echo "❌ CSV sem dados (apenas cabeçalho): $CSV"
    echo "   Dica: verifique se a etapa variacao_temperatura está gerando linhas."
    exit 1
  fi
}

conta() {
  checar_csv
  mkdir -p "$OUT_DIR"

  local n
  n=$(awk 'NR>1{c++} END{print c+0}' "$CSV")

  printf '%s' "\\newcommand{\\NPaises}{${n}}" > "${OUT_DIR}/n_paises.tex"
  echo "✅ Gerado: ${OUT_DIR}/n_paises.tex (NPaises=$n)"
}

extremos() {
  checar_csv
  mkdir -p "$OUT_DIR"

  # Remove CR (\r) caso o CSV venha em CRLF
  # Mantém o arquivo original intacto, trabalhando via pipe.
  local DATA
  DATA=$(tail -n +2 "$CSV" | tr -d '\r')

  # Se por algum motivo ficar vazio, falha
  if [ -z "$DATA" ]; then
    echo "❌ Não consegui ler linhas de dados do CSV (após remover cabeçalho)."
    exit 1
  fi

  # Pega 5 menores e 5 maiores (coluna 1 numérica; país na coluna 2)
  # Remove aspas do nome.
  MENORES=$(echo "$DATA" | LC_ALL=C sort -t, -k1,1n  | head -5 | awk -F',' '{gsub(/"/,"",$2); print $2}')
  MAIORES=$(echo "$DATA" | LC_ALL=C sort -t, -k1,1nr | head -5 | awk -F',' '{gsub(/"/,"",$2); print $2}')

  # Estatísticas globais
  MAX=$(echo "$DATA" | LC_ALL=C sort -t, -k1,1nr | head -1 | cut -d',' -f1)
  MIN=$(echo "$DATA" | LC_ALL=C sort -t, -k1,1n  | head -1 | cut -d',' -f1)
  MEDIA=$(echo "$DATA" | awk -F',' '{s+=$1; n++} END{if(n>0) printf "%.3f", s/n; else print ""}')

  # Falha se não conseguiu extrair (evita gerar comandos vazios)
  if [ -z "${MAX}" ] || [ -z "${MIN}" ] || [ -z "${MEDIA}" ]; then
    echo "❌ Falha ao calcular MAX/MIN/MEDIA a partir do CSV."
    echo "   Confira o formato: variacao_C_por_ano,pais"
    exit 1
  fi

  juntar_com_e() {
    awk '{
      a[NR]=$0
    }
    END{
      if(NR==0) {print ""; exit}
      if(NR==1) {print a[1]; exit}
      for(i=1;i<=NR;i++){
        if(i==1) printf "%s", a[i];
        else if(i==NR) printf " e %s", a[i];
        else printf ", %s", a[i];
      }
      printf "\n"
    }'
  }

  LISTA_MENORES=$(echo "$MENORES" | juntar_com_e)
  LISTA_MAIORES=$(echo "$MAIORES" | juntar_com_e)

  # Checa listas
  if [ -z "$LISTA_MENORES" ] || [ -z "$LISTA_MAIORES" ]; then
    echo "❌ Não consegui montar listas de países (MAIORES/MENORES vazios)."
    exit 1
  fi

  {
    echo "\\newcommand{\\PaisesMaiores}{${LISTA_MAIORES}}"
    echo "\\newcommand{\\PaisesMenores}{${LISTA_MENORES}}"
    echo "\\newcommand{\\MaiorTaxa}{${MAX}}"
    echo "\\newcommand{\\MenorTaxa}{${MIN}}"
    echo "\\newcommand{\\MediaTaxa}{${MEDIA}}"
  } > "${OUT_DIR}/paises_extremos.tex"

  echo "✅ Gerado: ${OUT_DIR}/paises_extremos.tex"
}

cmd="${1:-}"
case "$cmd" in
  conta) conta ;;
  extremos) extremos ;;
  *) usage ;;
esac
