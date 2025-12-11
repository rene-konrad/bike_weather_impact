🚲 San Francisco Bikeshare & Wetteranalyse
Dieses Projekt analysiert den Einfluss von Wetterbedingungen (Temperatur und Niederschlag) auf die Nutzung von Bikesharing-Angeboten in San Francisco. Ziel war es herauszufinden, unter welchen Bedingungen die Fahrräder am häufigsten genutzt werden und wie sich Wochentage im Vergleich zum Wetter verhalten.

📊 Dashboard Vorschau
<img width="1061" height="712" alt="Bildschirmfoto 2025-12-12 um 00 49 32" src="https://github.com/user-attachments/assets/88dcc71b-20b2-4c47-9e40-b71582cf4afd" />

Das Dashboard visualisiert:

Durchschnittliche Fahrten pro Monat: Saisonaler Trend der Nutzung.


Wetter-Einfluss: Vergleich zwischen regnerischen und trockenen Tagen .


Temperatur-Kategorien: Detaillierte Aufschlüsselung nach Komfort-Kategorien (z. B. "Ideal", "Warm", "Cold") in Kombination mit Regenstatus .

🛠️ Technologie-Stack
Google BigQuery: Data Warehousing und SQL-Abfragen.

SQL: Datenbereinigung, Transformation und Aggregation.

Looker Studio: Datenvisualisierung und Reporting.

Datenquellen:

bigquery-public-data.san_francisco_bikeshare

bigquery-public-data.noaa_gsod (Wetterdaten 2017)

🧠 Methodik & SQL-Logik
Die Datenaufbereitung erfolgt über eine SQL-Abfrage (Temperatur-Analyse.sql), die folgende Schritte durchführt:

1. Datenkategorisierung (CTE daily_counts)
Um die Daten interpretierbar zu machen, wurden rohe Wetterdaten in verständliche Kategorien unterteilt:

Temperatur-Buckets:

Cold (<50°F)

Cool_Foggy (50-60°F)

Ideal (60-68°F)

Warm (68-75°F)

Hot (>75°F)

Regen-Status: Definiert als Rainy wenn der Niederschlag (prcp) > 0.05 ist, sonst Dry.

Wochentag-Filter: Unterscheidung zwischen Weekend und Weekday.

SQL

CASE
    WHEN weather_2017.temp >= 60 AND weather_2017.temp < 68 THEN '3_Ideal (60-68°F)'
    ...
END AS comfort_category
2. Datenverknüpfung (Joins)
Die Wetterdaten wurden mit den Fahrdaten (bikeshare_trips) über das Datum und mit den Stationsinformationen verknüpft, wobei der Fokus auf einer spezifischen Wetterstation (724940) lag.

3. Aggregation & Filterung
Die finale Abfrage konzentriert sich auf Wochentage (WHERE day_type = 'Weekday'), da hier das Pendlerverhalten am stärksten ausgeprägt ist. Es wird der Durchschnitt der täglichen Fahrten (AVG(count_trips)) berechnet, gruppiert nach Monat, Komfort-Kategorie und Regenstatus.

📈 Ergebnisse
Basierend auf dem Bericht :


Spitzennutzung: Monate wie September und Oktober zeigen hohe Aktivität .


Wetterpräferenz: Überraschenderweise zeigt die Analyse hohe Durchschnittswerte auch bei regnerischen Bedingungen in bestimmten Temperaturfenstern (z. B. "Ideal Rainy" mit ~3.900 Fahrten).


Temperatur: Die Kategorien "Ideal" (60-68°F) und "Warm" (68-75°F) dominieren die Nutzungshäufigkeit.
