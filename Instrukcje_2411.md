# 📘 Instrukcja Laboratoryjna: Tworzenie Dashboardu w Quarto z AI

### Krok 1: Otwarcie projektu w Antigravity IDE
* **Cel:** Skonfigurowanie środowiska pracy i ustawienie aktywnego katalogu roboczego.
* **Instrukcja:**
  1. Uruchom aplikację **Antigravity**.
  2. Z górnego menu wybierz `File` &rarr; `Open Folder...` (lub skrót `Ctrl + K, Ctrl + O`).
  3. Wskaż folder ze sklonowanym lub rozpakowanym projektem dashboardu makroekonomicznego.

---

### Krok 2: Personalizacja kontekstu asystenta (`AGENTS.md`)
* **Cel:** Poinformowanie agenta AI o Twojej roli, poziomie zaawansowania oraz standardach uczelni.
* **Instrukcja:**
  1. Utwórz w głównym katalogu projektu plik o nazwie `AGENTS.md` (jeśli jeszcze nie istnieje).
  2. Otwórz czat asystenta Antigravity i wklej poniższy prompt, aby wygenerować spersonalizowane wytyczne:
* **Prompt do asystenta:**
```text
Proszę, pomóż mi wypełnić plik AGENTS.md. Jestem studentem II roku ekonomii na Akademii Leona Koźmińskiego (ALK) i realizuję projekt dashboardu analitycznego w R i Quarto. Zadaj mi pytania doprecyzowujące, które pozwolą dostosować Twój styl pracy i odpowiedzi do moich potrzeb.
```

---

### Krok 3: Przygotowanie środowiska Quarto & R
* **Cel:** Instalacja silnika raportowego Quarto oraz wymaganych bibliotek analitycznych w języku R.
* **Instrukcja:**
  1. Pobierz i zainstaluj najnowszą wersję **Quarto CLI** odpowiednią dla Twojego systemu operacyjnego.
  2. Otwórz **RStudio** i zainstaluj wymagane pakiety, wpisując poniższe polecenie w konsoli R (lub wybierając `Tools` &rarr; `Install Packages`):
* **Polecenie w konsoli R:**
```r
install.packages(c("tidyverse", "plotly", "knitr", "rmarkdown"))
```
* **Przydatne źródła:**
  * Pobieranie Quarto: [quarto.org/docs/get-started](https://quarto.org/docs/get-started/)
  * Galeria dashboardów: [quarto.org/docs/gallery](https://quarto.org/docs/gallery/)
  * Dostępne motywy HTML: [quarto.org/docs/output-formats/html-themes.html](https://quarto.org/docs/output-formats/html-themes.html)

---

### Krok 4: Uruchomienie podglądu na żywo (Live Preview)
* **Cel:** Uruchomienie lokalnego serwera deweloperskiego z automatycznym odświeżaniem widoku po każdej zmianie w kodzie.
* **Instrukcja:**
  1. W oknie Antigravity otwórz wbudowany terminal skrótem `Ctrl + \`` (lub `Terminal` &rarr; `New Terminal`).
  2. Wpisz polecenie uruchamiające podgląd dashboardu w przeglądarce:
* **Polecenie w terminalu:**
```bash
quarto preview dashboard.qmd
```

---

### Krok 5: Rozbudowa dashboardu z pomocą Antigravity
* **Cel:** Implementacja nowych zakładek, wykresu słupkowego oraz profilu radarowego przy zachowaniu identyfikacji wizualnej ALK.
* **Instrukcja:**
  1. W oknie czatu Antigravity wklej poniższy, ustrukturyzowany prompt inżynierski:
* **Prompt do asystenta:**
```text
Proszę zmodyfikuj plik dashboard.qmd (komórki kodu są w języku R: tidyverse + plotly):

1. Na stronie 'Polska (Trendy Krajowe)' zamień dolny wiersz z tabelą na kartę z dwiema zakładkami (.tabset):
   - Zakładka '📋 Tabela Danych': obecna tabela danych historycznych.
   - Zakładka '📊 Struktura Wskaźników': wykres słupkowy plot_ly(type = "bar") pokazujący roczne tempo PKB per capita.

2. Na stronie 'Porównanie Regionalne' dodaj wykres radarowy (plot_ly z type = "scatterpolar", fill = "toself") porównujący Polskę (POL) i Niemcy (DEU) pod kątem znormalizowanych wskaźników (Wzrost PKB, Inflacja, Stabilność Zatrudnienia) dla roku rok_por.

3. Użyj oficjalnych barw ALK: zmiennych alk_granat (#030928, granat) oraz alk_zloto (#B4865E, złoto) zdefiniowanych w pierwszej komórce dashboard.qmd.

4. Pisz wyłącznie w R – nie dodawaj żadnych komórek Pythona.

5. Nie używaj poleceń git ani Rscript – pliki wgram na GitHuba przez przeglądarkę.

6. Zadbaj o to, aby podpisy wykresów oraz tabelek (tytuły, osie X i Y) nie były obcięte przez krawędzie kart (np. użyj podziału <br> i odpowiednich marginesów).
```
### Krok 6: Kompilacja Produkcyjna do Folderu docs/

```text
 quarto render dashboard.qmd --output-dir docs --output index.html
```