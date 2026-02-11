import os
import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt

CSV_PATH = "resultados/variacao_temperatura.csv"
WORLD_GEOJSON = "dados/base/world.geojson"
OUT_PATH = "figuras/mapa_variacao.png"


def detect_columns(df: pd.DataFrame) -> tuple[str, str]:
    candidates_country = [c for c in df.columns if c.lower() in ("pais", "país", "country", "name")]
    country_col = candidates_country[0] if candidates_country else df.columns[-1]

    candidates_value = [c for c in df.columns if ("variacao" in c.lower()) or ("alpha" in c.lower())]
    if candidates_value:
        value_col = candidates_value[0]
    else:
        value_col = None
        for c in df.columns:
            if c == country_col:
                continue
            tmp = pd.to_numeric(df[c], errors="coerce")
            if tmp.notna().any():
                value_col = c
                break
        value_col = value_col or df.columns[0]
    return country_col, value_col


def load_data(path: str) -> pd.DataFrame:
    df = pd.read_csv(path)
    country_col, value_col = detect_columns(df)

    df = df[[value_col, country_col]].copy()
    df.columns = ["_value", "_country"]

    df["_country"] = df["_country"].astype(str).str.strip().str.replace(r"\s+", " ", regex=True)
    df["_value"] = df["_value"].astype(str).str.replace(",", ".", regex=False)
    df["_value"] = pd.to_numeric(df["_value"], errors="coerce")

    df = df[df["_country"].notna() & (df["_country"].str.len() > 0)]
    return df


def load_world(path: str) -> gpd.GeoDataFrame:
    if not os.path.exists(path):
        raise FileNotFoundError(
            f"Arquivo do mapa não encontrado: {path}\n"
            "Baixe e coloque o GeoJSON em dados/base/world.geojson (ver Makefile/README)."
        )
    world = gpd.read_file(path)

    # Tenta definir uma coluna de nome padrão
    name_col = None
    for c in ["name", "ADMIN", "admin", "NAME", "Country", "COUNTRY", "country"]:
        if c in world.columns:
            name_col = c
            break
    if name_col is None:
        # fallback: primeira coluna object
        obj_cols = [c for c in world.columns if world[c].dtype == "object"]
        name_col = obj_cols[0] if obj_cols else None

    if name_col is None:
        raise ValueError("Não encontrei coluna de nome de país no GeoJSON do mundo.")

    world = world.rename(columns={name_col: "_world_name"})
    world["_world_name"] = world["_world_name"].astype(str).str.strip()
    return world[["_world_name", "geometry"]]


def normalize(s: str) -> str:
    return " ".join(str(s).strip().lower().split())


def main():
    os.makedirs(os.path.dirname(OUT_PATH), exist_ok=True)

    df = load_data(CSV_PATH)
    world = load_world(WORLD_GEOJSON)

    # Normaliza nomes para casar melhor
    df["_country_norm"] = df["_country"].map(normalize)
    world["_world_norm"] = world["_world_name"].map(normalize)

    # Merge pelo nome normalizado (sem quebrar se não casar)
    df_agg = df.groupby("_country_norm")["_value"].mean().reset_index()
    merged = world.merge(df_agg, how="left", left_on="_world_norm", right_on="_country_norm")

    fig, ax = plt.subplots()
    merged.plot(
        column="_value",
        legend=True,
        ax=ax,
        missing_kwds={
            "color": "lightgrey",
            "edgecolor": "white",
            "hatch": "///",
            "label": "Sem dados / sem match",
        },
        edgecolor="white",
        linewidth=0.2,
    )

    ax.set_title("Taxa de variação de temperatura (°C/ano) — últimos 5 anos",fontsize=8)
    ax.set_xlabel("Longitude")
    ax.set_ylabel("Latitude")
    ax.legend(loc="lower left")

    fig.savefig(OUT_PATH, dpi=300, bbox_inches="tight")
    plt.close(fig)

    # Log informativo
    total = len(df)
    matched = merged["_value"].notna().sum()
    print(f"✅ Mapa salvo em: {OUT_PATH}")
    print(f"ℹ️ Registros no CSV: {total} | Polígonos com valor: {matched}")


if __name__ == "__main__":
    main()
