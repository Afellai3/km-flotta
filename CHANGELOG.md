# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2026-03-06

### ✨ Added

#### 📊 KPI Principali
- **`KM Totali`**: formatting migliorato con separatore migliaia (#,##0)
- **`KM Netti Totali`**: spostato in folder KPI Principali
- **`N° Tratte Totali`**: nuova misura per conteggio totale tratte
- **`KM Medi per Tratta`**: refactoring per usare `[N° Tratte Totali]`

#### 🚨 Anomalie e Controlli (NUOVO)
- **`🚨 Veicoli Critici (>20%)`**: alert automatico veicoli con scarto >20%
- **`⚠️ Utenti da Verificare`**: alert utenti con scarto >20%
- **`% Tratte Complete`**: % tratte chiuse con DATA_FINE valida
- **`Icona Stato Scarto`**: semaforo visuale (🔴 >20%, 🟡 >10%, 🟢 >0%)

#### 📈 Trend Temporali (NUOVO)
- **`KM Mese Corrente`**: KM ultimo mese disponibile
- **`KM Mese Precedente`**: per confronto MoM
- **`Δ KM vs Mese Scorso`**: variazione assoluta
- **`Δ% KM vs Mese Scorso`**: variazione percentuale
- **`Utenti Attivi Mese Corrente`**: utenti attivi ultimo mese
- **`Utenti Attivi Mese Precedente`**: per confronto
- **`Δ Utenti Attivi MoM`**: crescita utenti mese su mese

#### 📋 Dettaglio Tratta
- **`Durata Tratta (giorni)`**: calcolo giorni tra DATA_INIZIO e DATA_FINE

### 📖 Documentation
- **README.md completo**:
  - Panoramica progetto e obiettivi business
  - Architettura tecnica (TMDL + pbi-tools)
  - Catalogo completo misure DAX
  - Setup e installazione
  - Workflow sviluppo (Git + PR)
  - Dizionario dati
  - Troubleshooting guide
  - Roadmap v1.1 e v2.0

- **CHANGELOG.md**: tracking modifiche progetto

### 🛠️ Changed

- **Display Folders riorganizzati**:
  - `📊 KPI Principali` (6 misure)
  - `🚨 Anomalie e Controlli` (6 misure)
  - `📈 Trend Temporali` (8 misure)
  - `📋 Dettaglio Tratta` (3 misure)
  - `🔧 Misure Supporto` (3 misure helper)

- **Commenti DAX**: tutte le misure ora hanno commenti esplicativi

- **Format strings**: standardizzati (#,##0 per numeri, 0.0% per percentuali)

### 🐛 Fixed

- **`% Scarto`**: ora gestisce correttamente divisione per zero
- **`N° Utenti Attivi`**: display folder assegnato correttamente

---

## [1.0.0] - 2026-03-06

### ✨ Added (Release Iniziale)

#### Misure Base
- `KM Totali`: somma KM dichiarati (stato INSERITO)
- `KM Non Rendicontati`: totale scarto assoluto
- `N° Errori Contachilometri`: tratte con KM_SCARTO < 0
- `Tratte Aperte`: tratte senza DATA_FINE
- `KM Medi per Tratta`: media KM per tratta
- `KM Totali Matrice`: versione ottimizzata per visual matrice
- `N° Tratte Matrice`: conteggio per matrice
- `N° Utenti Attivi`: utenti univoci con dichiarazioni
- `% Scarto`: percentuale scarto su totale KM
- `Ultima Dichiarazione`: data ultima dichiarazione
- `KM Netti Totali`: KM netti (dichiarati - scarto)

#### Misure Drill-Down
- `Note Tratta`: mostra note solo a livello tratta
- `Data Fine Tratta`: data fine formattata
- `Ha Dati`: flag per nascondere righe vuote

#### Colonne Calcolate
- `NomeCompleto`: concatenazione Nome + Cognome
- `MeseAnno`: formato "MMM YYYY" (Gen 2026)
- `SortMeseAnno`: ordinamento numerico mesi
- `Giorno`: giorno estratto da DATA_INIZIO
- `GiornoData`: formato "ddd dd/MM" (Lun 06/03)
- `SortGiornoData`: ordinamento numerico giorni
- `Tratta`: descrizione formattata PUNTO_INIZIO → PUNTO_FINE

#### Gerarchia Temporale
- `Gerarchia Data`: Anno → Mese → Giorno

#### Infrastructure
- **TMDL Setup**: modello convertito in formato testuale
- **pbi-tools Integration**: `deploy.bat` e `deploy.ps1` per TMDL → BIM
- **Git Repository**: source control attivo
- **Azure SQL Connection**: database `sgam_analisi`

---

## Roadmap

### v1.2 (Q2 2026) - Planned

- [ ] Pagina "Anomalie" dedicata con drill-through
- [ ] Tooltip interattivi con storico scarto
- [ ] Export Excel automatico "Veicoli da verificare"
- [ ] Filtri dinamici data (last 30/60/90 days)

### v2.0 (Q3 2026) - Planned

- [ ] Integrazione costi carburante (stima da KM)
- [ ] Analisi tratte frequenti (heatmap)
- [ ] Previsioni ML scarto atteso (Azure ML)
- [ ] Dashboard mobile Power BI Service
- [ ] Row-Level Security (RLS) per utenti

---

## Note di Versione

### Breaking Changes

Nessuna breaking change in questa versione. Tutte le modifiche sono retrocompatibili.

### Migration Guide

Per aggiornare da v1.0.0 a v1.1.0:

1. **Pull ultime modifiche**:
   ```bash
   git pull origin main
   ```

2. **Rigenera BIM**:
   ```cmd
   deploy.bat
   ```

3. **Refresh Power BI Desktop**:
   - Apri `Dichiarazione KM.pbix`
   - Home → Refresh
   - Verifica nuove misure nei folder organizzati

4. **Aggiorna visuals** (opzionale):
   - Aggiungi KPI cards per `🚨 Veicoli Critici (>20%)`
   - Aggiungi `Δ% KM vs Mese Scorso` con conditional formatting
   - Usa `Icona Stato Scarto` in matrici

---

## Contributors

- **Afellai3** - Initial work & v1.1 enhancement
- **Team Data Analytics** - Testing & feedback

---

**🚀 Keep tracking changes!**
