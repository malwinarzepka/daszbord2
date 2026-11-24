# 📊 Dashboard Makroekonomiczny ALK w Quarto (`format: dashboard`) 🚀
### Projekt Laboratoryjny: Nowoczesne Raportowanie BI & Wdrożenie na GitHub Pages
**Uczelnia:** Akademia Leona Koźmińskiego (ALK)  
**Środowisko:** Antigravity IDE & Quarto CLI  
**Technologie:** Quarto, R, tidyverse, plotly, YAML, GitHub Pages, GitHub Actions  

---

## 🎯 Cel Projektu
Projekt demonstruje budowę responsywnego, interaktywnego panelu biznesowego (**Executive Dashboard**) z wykorzystaniem standardu **Quarto Dashboards**:
1. **Karty KPI (Value Boxes):** Dynamicznie wyliczane wskaźniki (Wzrost PKB, Inflacja CPI, Bezrobocie, PKB per capita).
2. **Interaktywne Wykresy (Plotly):** Obsługa zoomu, najechania myszką (hover tooltips), filtrowania serii i dynamicznych legend.
3. **Układ Wielozakładkowy (Tabsets / Pages):** Osobna strona dla wskaźników Polski, strona porównania regionalnego (Polska, Niemcy, Czechy, USA) oraz strona **Symulacji Monte Carlo** – 1000 losowych ścieżek indeksu realnego PKB Polski do 2050 roku (parametry `n_sim`, `rok_koncowy` i `set.seed()` zmienisz na początku tej strony w `dashboard.qmd`).
4. **Pasek boczny (Sidebar):** Prezentacja założeń metodologicznych, źródeł danych (Bank Światowy) oraz autorów.
5. **Identyfikacja wizualna ALK:** granat `#030928`, złoto `#B4865E` i czcionka Open Sans z pliku `alk.scss`, logo `assets/alk_logo.png` w pasku nawigacji oraz stopka z akredytacjami (`stopka.html` + `assets/alk_stopka.png`) na każdej stronie.
6. **Ciągłe Wdrażanie (CI/CD):** Automatyczna kompilacja i publikacja dashboardu na **GitHub Pages** pod publicznym adresem URL.

---

## 🚀 Uruchomienie i Podgląd na Żywo w Antigravity

### 1. Przygotowanie środowiska:
W konsoli R (np. w RStudio) zainstaluj jednorazowo pakiety:
```r
install.packages(c("tidyverse", "plotly", "knitr", "rmarkdown"))
```
Następnie w terminalu Antigravity (PowerShell) sprawdź, czy Quarto widzi R:
```powershell
quarto check knitr
```

### 2. Podgląd na żywo w czasie rzeczywistym (Live Preview):
```powershell
quarto preview dashboard.qmd
```
*Quarto uruchomi lokalny serwer WWW (zwykle pod adresem http://localhost:4200) z funkcją **Hot Reload** – każda zmiana w kodzie `.qmd` natychmiast odświeża dashboard w przeglądarce!*

### 3. Kompilacja do pliku produkcyjnego HTML:
```powershell
quarto render dashboard.qmd --output-dir docs --output index.html
```

---

## 🔄 Aktualizacja danych
Dołączony plik `data/macro_data.csv` celowo kończy się na roku **2023**. Nowsze wskaźniki z API Banku Światowego pobiera robot GitHub Actions (`.github/workflows/update_data.yml`): uruchamiany ręcznie w zakładce **Actions** oraz w każdy poniedziałek o 06:00 UTC. Robot zapisuje zaktualizowany plik CSV jako commit i od razu publikuje odświeżony dashboard.

Lokalnie ten sam skrypt uruchomisz w konsoli R (po otwarciu folderu projektu w RStudio):
```r
source("fetch_data.R")
```

---

## 🌐 Publikacja na GitHub Pages
Po dodaniu do repozytorium pliku `.github/workflows/deploy_dashboard.yml` i ustawieniu w **Settings &rarr; Pages** źródła **GitHub Actions** robot automatycznie skompiluje dashboard i udostępni go pod adresem:  
`https://TWOJ_LOGIN.github.io/NAZWA_REPOZYTORIUM/`
