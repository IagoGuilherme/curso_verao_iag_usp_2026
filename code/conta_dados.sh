#!/bin/bash
set -euo pipefail

CSV="resultados/variacao_temperatura.csv"
OUT_DIR="paper/variaveis"

usage() {
  echo "Uso: $0 {conta|extremos}"
  exit 1
}

# Formata lista "A, B, C e D"
formatar_lista() {
  local -a LISTA=("$@")
  local TAM=${#LISTA[@]}

  if [ "$TAM" -eq 0 ]; then
    echo ""
  elif [ "$TAM" -eq 1 ]; then
    echo "${LISTA[0]}"
  else
    local out=""
    for ((i=0; i<TAM; i++)); do
      if [ $i -eq 0 ]; then
        out="${LISTA[$i]}"
      elif [ $i -eq $((TAM-1)) ]; then
        out="${out} e ${LISTA[$i]}"
      else
        out="${out}, ${LISTA[$i]}"
      fi
    done
    echo "$out"
  fi
}

conta() {
  mkdir -p "$OUT_DIR"

  # conta linhas sem cabeçalho (NR>1)
  local n
  n=$(awk 'NR>1{c++} END{print c+0}' "$CSV")

  # IMPORTANTÍSSIMO: usar printf (echo pode transformar \n em newline)
  printf '%s' "\\newcommand{\\NPaises}{${n}}" > "${OUT_DIR}/n_paises.tex"

  echo "✅ Gerado: ${OUT_DIR}/n_paises.tex (NPaises=$n)"
}


extremos() {
  mkdir -p "$OUT_DIR"

  # Pega 5 menores e 5 maiores (coluna 1 numérica; país na coluna 2)
  # Remove aspas do nome e já formata no padrão LaTeX.
  MENORES=$(tail -n +2 "$CSV" | sort -t, -k1,1n  | head -5 | awk -F',' '{gsub(/"/,"",$2); print $2}')
  MAIORES=$(tail -n +2 "$CSV" | sort -t, -k1,1nr | head -5 | awk -F',' '{gsub(/"/,"",$2); print $2}')
  # Estatísticas globais
  MAX=$(tail -n +2 "$CSV" | sort -t, -k1,1nr | head -1 | cut -d',' -f1)
  MIN=$(tail -n +2 "$CSV" | sort -t, -k1,1n  | head -1 | cut -d',' -f1)
  MEDIA=$(awk -F',' 'NR>1{s+=$1; n++} END{if(n>0) printf "%.3f", s/n}' "$CSV")



  # Função para juntar linhas em "A, B, C e D"
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
