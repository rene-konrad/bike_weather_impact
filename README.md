# 🚲 San Francisco Bikeshare & Wetteranalyse

Dieses Projekt analysiert den Einfluss von Wetterbedingungen (Temperatur und Niederschlag) auf die Nutzung von Bikesharing-Angeboten in San Francisco. Ziel war es herauszufinden, unter welchen Bedingungen die Fahrräder am häufigsten genutzt werden und wie sich Wochentage im Vergleich zum Wetter verhalten.

## 📊 Dashboard Vorschau

<img width="1061" height="712" alt="Bildschirmfoto 2025-12-12 um 00 49 32" src="https://github.com/user-attachments/assets/94b189f5-73bc-444a-ae4a-648dcc434b0f" />

Das Dashboard visualisiert:
* [cite_start]**Durchschnittliche Fahrten pro Monat:** Saisonaler Trend der Nutzung[cite: 7].
* [cite_start]**Wetter-Einfluss:** Vergleich zwischen regnerischen und trockenen Tagen[cite: 13].
* [cite_start]**Temperatur-Kategorien:** Detaillierte Aufschlüsselung nach Komfort-Kategorien (z. B. "Ideal", "Warm", "Cold") in Kombination mit Regenstatus [cite: 37-43].

## 🛠️ Technologie-Stack

* **Google BigQuery:** Data Warehousing und SQL-Abfragen.
* **SQL:** Datenbereinigung, Transformation und Aggregation.
* **Looker Studio:** Datenvisualisierung und Reporting.
* **Datenquellen:**
  * `bigquery-public-data.san_francisco_bikeshare`
  * `bigquery-public-data.noaa_gsod` (Wetterdaten 2017)

## 🧠 Methodik

Die Datenaufbereitung erfolgte über eine SQL-Abfrage, die Rohdaten in interpretierbare Kategorien transformiert:

### 1. Datenkategorisierung
Um die Daten interpretierbar zu machen, wurden rohe Wetterdaten in verständliche Kategorien unterteilt:

* **Temperatur-Buckets:** Die Temperatur wurde in 5 Komfort-Stufen eingeteilt, von "Cold (<50°F)" bis "Hot (>75°F)". Die Kategorie "Ideal" wurde beispielsweise als 60-68°F definiert.
* **Regen-Status:** Ein Tag wird als `Rainy` definiert, wenn der Niederschlagswert (`prcp`) größer als 0.05 ist, andernfalls gilt er als `Dry`.
* **Wochentag-Filter:** Es wurde zwischen `Weekend` (Samstag/Sonntag) und `Weekday` unterschieden.

### 2. Datenverknüpfung
Die Wetterdaten wurden mit den Fahrdaten (`bikeshare_trips`) über das Datum und mit den Stationsinformationen verknüpft, wobei der Fokus auf einer spezifischen Wetterstation (`724940`) lag.

### 3. Aggregation & Filterung
Die finale Analyse konzentriert sich auf **Wochentage**, da hier das Pendlerverhalten am stärksten ausgeprägt ist. Berechnet wurde der Durchschnitt der täglichen Fahrten, gruppiert nach Monat, Komfort-Kategorie und Regenstatus.

## 📈 Ergebnisse

* [cite_start]**Spitzennutzung:** Monate wie September und Oktober zeigen besonders hohe Aktivität [cite: 21-24].
* [cite_start]**Wetterpräferenz:** Die Analyse zeigt überraschend hohe Durchschnittswerte auch bei regnerischen Bedingungen (z. B. ~3.900 Fahrten), solange die Temperaturen im Bereich "Ideal" (60-68°F) liegen[cite: 37].
* [cite_start]**Temperatur:** Die Kategorien "Ideal" und "Warm" dominieren die Nutzungshäufigkeit, während extreme Kälte die Nutzung deutlich reduziert [cite: 41-43].


Wetterpräferenz: Überraschenderweise zeigt die Analyse hohe Durchschnittswerte auch bei regnerischen Bedingungen in bestimmten Temperaturfenstern (z. B. "Ideal Rainy" mit ~3.900 Fahrten).


Temperatur: Die Kategorien "Ideal" (60-68°F) und "Warm" (68-75°F) dominieren die Nutzungshäufigkeit.
