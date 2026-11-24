# Skrypt aktualizacji danych makroekonomicznych dla Quarto Dashboard
# Źródło: API Banku Światowego (The World Bank)
#
# Uruchomienie:
#   * w chmurze robi to za Ciebie robot GitHub Actions (.github/workflows/update_data.yml),
#   * lokalnie: otwórz folder projektu w RStudio i wpisz w konsoli R: source("fetch_data.R")

library(tidyverse)
library(jsonlite)

options(timeout = 30)

kraje <- c(
  POL = "Polska",
  DEU = "Niemcy",
  CZE = "Czechy",
  USA = "Stany Zjednoczone"
)

wskazniki <- c(
  "NY.GDP.MKTP.KD.ZG" = "Wzrost_PKB_proc",
  "FP.CPI.TOTL.ZG"    = "Inflacja_CPI_proc",
  "SL.UEM.TOTL.ZS"    = "Bezrobocie_proc",
  "NY.GDP.PCAP.CD"    = "PKB_per_capita_USD"
)

# Zakres lat: od 2012 do ostatniego zakończonego roku kalendarzowego
rok_od <- 2012
rok_do <- as.integer(format(Sys.Date(), "%Y")) - 1

# Pobiera jeden wskaźnik dla jednego kraju i zwraca ramkę: Rok + kolumna wskaźnika.
# Przy błędzie sieci ponawia próbę; po 3 nieudanych próbach przerywa cały skrypt,
# żeby nie zapisać do repozytorium pliku z dziurami.
pobierz_wskaznik <- function(kod_kraju, kod_wskaznika, nazwa_kolumny, proby = 3) {
  url <- paste0(
    "https://api.worldbank.org/v2/country/", kod_kraju,
    "/indicator/", kod_wskaznika,
    "?format=json&date=", rok_od, ":", rok_do, "&per_page=100"
  )
  for (i in seq_len(proby)) {
    odpowiedz <- tryCatch(fromJSON(url), error = function(e) NULL)
    # Poprawna odpowiedź API to lista: [[1]] metadane, [[2]] tabela z danymi
    if (length(odpowiedz) >= 2 && is.data.frame(odpowiedz[[2]])) {
      return(
        odpowiedz[[2]] |>
          as_tibble() |>
          transmute(Rok = as.integer(date), "{nazwa_kolumny}" := round(value, 2))
      )
    }
    message("    [Ponawiam] ", kod_kraju, " - ", nazwa_kolumny, " (próba ", i, "/", proby, ")")
    Sys.sleep(3)
  }
  stop("Nie udało się pobrać: ", kod_kraju, " - ", nazwa_kolumny, ". Plik CSV pozostaje bez zmian.")
}

aktualizuj_dane <- function(sciezka = "data/macro_data.csv") {
  message("--> Pobieranie świeżych wskaźników z API Banku Światowego (", rok_od, "-", rok_do, ")...")

  dane <- map_dfr(names(kraje), function(kod_kraju) {
    df_kraj <- tibble(Rok = rok_od:rok_do, Kraj = kod_kraju, Nazwa_Kraju = kraje[[kod_kraju]])
    for (kod_wskaznika in names(wskazniki)) {
      df_kraj <- left_join(
        df_kraj,
        pobierz_wskaznik(kod_kraju, kod_wskaznika, wskazniki[[kod_wskaznika]]),
        by = "Rok"
      )
    }
    df_kraj
  })

  dane <- dane |>
    # Usuwamy lata, dla których Bank Światowy nie opublikował jeszcze żadnego wskaźnika
    filter(!if_all(all_of(unname(wskazniki)), is.na)) |>
    arrange(Kraj, Rok)

  dir.create(dirname(sciezka), showWarnings = FALSE, recursive = TRUE)
  write_csv(dane, sciezka, na = "")
  message("[OK] Zapisano ", nrow(dane), " wierszy (lata ", min(dane$Rok), "-", max(dane$Rok), ") do pliku: ", sciezka)
}

aktualizuj_dane()
