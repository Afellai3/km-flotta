# 🚗 KM Flotta - Sistema Dichiarazione Chilometri

> Sistema di tracciamento e controllo dichiarazioni chilometriche per flotta aziendale con rilevamento anomalie automatico.

[![Power BI](https://img.shields.io/badge/Power_BI-F2C811?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![TMDL](https://img.shields.io/badge/TMDL-versioned-blue)](https://github.com/Afellai3/km-flotta/tree/main/tmdl-output)
[![License](https://img.shields.io/badge/license-Private-red)](LICENSE)

---

## 📊 Panoramica

**KM Flotta** è un report Power BI che monitora le dichiarazioni chilometriche dei dipendenti tramite web app aziendale, con focus su:

- **Controllo qualità**: rilevamento automatico anomalie (scarto >20%)
- **Trend adozione**: crescita utenti attivi e completezza dichiarazioni
- **Drill-down**: da overview fleet a dettaglio tratta singola
- **Time intelligence**: confronti mese corrente vs precedente

### 🎯 Obiettivi Business

1. **Verificare accuratezza** dichiarazioni KM (confronto contachilometri vs dichiarato)
2. **Identificare utenti problematici** (scarto >20% o errori ripetuti)
3. **Monitorare adozione** web app (utenti attivi, tratte completate)
4. **Ottimizzare controlli** amministrativi (alert automatici)

---

## 🛠️ Architettura Tecnica

### Stack Tecnologico

| Componente | Tecnologia | Scopo |
|---|---|---|
| **Data Source** | Azure SQL Database | `vw_DichiarazioneKM` view |
| **BI Tool** | Power BI Desktop | Report e DAX |
| **Version Control** | Git + GitHub | Source control TMDL |
| **Model Format** | TMDL (Tabular Model Definition Language) | Formato testuale per DAX |
| **Deploy Tool** | pbi-tools | Conversione TMDL ↔ BIM |

### Struttura Repository

```
km-flotta/
├── tmdl-output/                  # Modello TMDL (version controlled)
│   ├── tables/
│   │   └── vw_DichiarazioneKM.tmdl  # Tabella principale con misure DAX
│   ├── model.tmdl               # Metadata modello
│   ├── relationships.tmdl       # Relazioni
│   └── cultures/                # Localizzazioni
├── Model bim dichiarazione km.bim  # BIM generato da TMDL
├── deploy.bat                # Script deploy Windows
├── deploy.ps1                # Script deploy PowerShell
├── README.md                 # Questa documentazione
└── CHANGELOG.md              # Log modifiche
```

---

## 📊 Misure DAX Disponibili

### 📊 KPI Principali

| Misura | Descrizione | Formato |
|---|---|---|
| `KM Totali` | Somma KM dichiarati (solo INSERITO) | #,##0 |
| `KM Non Rendicontati` | Totale scarto (valore assoluto) | #,##0 |
| `% Scarto` | Percentuale scarto su totale KM | 0.0% |
| `N° Utenti Attivi` | Utenti univoci con dichiarazioni | #,##0 |
| `N° Tratte Totali` | Conteggio tratte inserite | #,##0 |
| `KM Medi per Tratta` | Media KM per tratta | #,##0.0 |

### 🚨 Anomalie e Controlli

| Misura | Descrizione | Soglia |
|---|---|---|
| `🚨 Veicoli Critici (>20%)` | Veicoli con scarto >20% | 0.20 |
| `⚠️ Utenti da Verificare` | Utenti con scarto >20% | 0.20 |
| `N° Errori Contachilometri` | Tratte con KM_SCARTO < 0 | - |
| `Tratte Aperte` | Tratte senza DATA_FINE | - |
| `% Tratte Complete` | % tratte chiuse correttamente | 0.0% |
| `Icona Stato Scarto` | 🔴 >20%, 🟡 >10%, 🟢 >0% | - |

### 📈 Trend Temporali

| Misura | Descrizione |
|---|---|
| `KM Mese Corrente` | KM ultimo mese disponibile |
| `KM Mese Precedente` | KM mese precedente (confronto) |
| `Δ KM vs Mese Scorso` | Variazione assoluta MoM |
| `Δ% KM vs Mese Scorso` | Variazione % MoM |
| `Utenti Attivi Mese Corrente` | Utenti ultimo mese |
| `Δ Utenti Attivi MoM` | Crescita utenti MoM |
| `Ultima Dichiarazione` | Data ultima dichiarazione |

### 📋 Dettaglio Tratta

| Misura | Descrizione | Visibilità |
|---|---|---|
| `Note Tratta` | Note inserite dall'utente | Solo drill-down Tratta |
| `Data Fine Tratta` | Data fine formattata | Solo drill-down Tratta |
| `Durata Tratta (giorni)` | Giorni tra inizio e fine | Solo drill-down Tratta |

---

## 🚀 Setup Progetto

### Prerequisiti

- **Power BI Desktop** (versione 2.151+)
- **Git** per version control
- **pbi-tools** per conversione TMDL ⇄ BIM
- **Accesso Azure SQL** al database `sgam_analisi`

### Installazione

#### 1. Clone Repository

```bash
git clone https://github.com/Afellai3/km-flotta.git
cd km-flotta
```

#### 2. Installa pbi-tools

**Windows (Chocolatey)**:
```cmd
choco install pbi-tools -y
```

**Oppure download diretto**:
- [pbi-tools releases](https://github.com/pbi-tools/pbi-tools/releases/latest)
- Estrai in `C:\pbi-tools\`
- Aggiungi al PATH di sistema

#### 3. Deploy Modello

```cmd
# Converte TMDL → BIM
deploy.bat
```

#### 4. Apri Report

1. Apri **Power BI Desktop**
2. File → Open → `Dichiarazione KM.pbix`
3. Home → **Refresh** (carica dati da Azure SQL)

---

## 📝 Workflow di Sviluppo

### Modifica Misure DAX

```bash
# 1. Crea branch feature
git checkout -b feat/nuova-misura

# 2. Modifica TMDL con VS Code
code tmdl-output/tables/vw_DichiarazioneKM.tmdl

# 3. Converti TMDL → BIM
deploy.bat

# 4. Testa in Power BI Desktop
# (Refresh + verifica nuova misura)

# 5. Commit
git add tmdl-output/
git commit -m "feat: aggiunta misura XYZ"

# 6. Push e crea Pull Request
git push origin feat/nuova-misura
```

### Pull Request Workflow

1. **Crea PR** da branch feature → `main`
2. **Review**: verifica diff DAX su GitHub
3. **Test**: valida report localmente
4. **Merge**: approva e mergia su main
5. **Deploy**: pubblica su workspace Power BI Service

---

## 📊 Dizionario Dati

### Tabella: `vw_DichiarazioneKM`

| Colonna | Tipo | Descrizione |
|---|---|---|
| `ID` | int64 | ID univoco tratta |
| `ID_USER` | int64 | ID utente dipendente |
| `Nome` | string | Nome utente |
| `Cognome` | string | Cognome utente |
| `Email` | string | Email aziendale |
| `TARGA` | string | Targa veicolo |
| `DATA_INIZIO` | dateTime | Data/ora inizio tratta |
| `DATA_FINE` | dateTime | Data/ora fine tratta |
| `PUNTO_INIZIO` | string | Località partenza |
| `PUNTO_FINE` | string | Località arrivo |
| `KM_INIZIO` | int64 | Lettura contachilometri inizio |
| `KM_FINE` | int64 | Lettura contachilometri fine |
| `KM_PERCORSI` | int64 | KM dichiarati utente |
| `KM_SCARTO` | int64 | Diff. tra contachilometri e dichiarato |
| `KM_NETTI` | int64 | KM netti (dopo correzione scarto) |
| `NOTE` | string | Note utente sulla tratta |
| `STATO` | string | INSERITO / ANNULLATO |
| `DATA_INSERT` | dateTime | Data inserimento record |
| `DATA_UPDATE` | dateTime | Data ultimo aggiornamento |

### Colonne Calcolate

| Colonna | Formula | Scopo |
|---|---|---|
| `NomeCompleto` | `Nome & " " & Cognome` | Nome completo utente |
| `MeseAnno` | `FORMAT(DATA_INIZIO, "MMM YYYY")` | Mese leggibile (Gen 2026) |
| `GiornoData` | `FORMAT(DATA_INIZIO, "ddd dd/MM")` | Giorno leggibile (Lun 06/03) |
| `Tratta` | `PUNTO_INIZIO & " → " & PUNTO_FINE` | Descrizione tratta formattata |

---

## ⚙️ Configurazione

### Connection String Azure SQL

```m
Origine = Sql.Database(
    "sqltorello1.8e5e8f166c55.database.windows.net",
    "sgam_analisi"
)
```

**Per modificare**:
1. Power BI Desktop → Transform Data
2. Home → Data Source Settings
3. Modifica connection string
4. Salva e ricarica

### Soglie Anomalie

Per modificare la soglia di alert (default 20%):

```dax
-- In vw_DichiarazioneKM.tmdl
measure '🚨 Veicoli Critici (>20%)' =
    VAR Soglia = 0.20  // <-- Modifica qui (es. 0.15 per 15%)
    ...
```

Poi:
```cmd
deploy.bat
# Refresh Power BI Desktop
```

---

## 📊 Utilizzo Report

### KPI Cards (Overview)

**Misure consigliate per KPI cards**:
- `KM Totali`
- `N° Utenti Attivi` + `Δ Utenti Attivi MoM`
- `% Scarto` + conditional formatting (🔴 >20%)
- `🚨 Veicoli Critici (>20%)`
- `Tratte Aperte`

### Matrice Principale

**Righe**:
1. `NomeCompleto`
2. `TARGA`
3. `Gerarchia Data` (Anno → Mese → Giorno)
4. `Tratta`

**Valori**:
- `KM Totali`
- `KM Non Rendicontati`
- `% Scarto` (conditional formatting)
- `N° Tratte Matrice`
- `Note Tratta` (drill-down Tratta)
- `Data Fine Tratta` (drill-down Tratta)

**Filtri**:
- `Ha Dati = 1` (nasconde righe vuote)

### Conditional Formatting

**% Scarto** (semaforo):
- 🟢 Verde: 0–5%
- 🟡 Giallo: 5–20%
- 🔴 Rosso: >20%

---

## 🔧 Troubleshooting

### Problema: "Model.bim not found"

**Soluzione**:
```cmd
# Rigenera BIM da TMDL
deploy.bat
```

### Problema: "Data source connection error"

**Causa**: Credenziali Azure SQL scadute

**Soluzione**:
1. Power BI Desktop → File → Options → Data source settings
2. Edit Permissions → Credentials → Re-enter
3. Refresh

### Problema: "Misure DAX non visibili"

**Causa**: Display folders nascosti

**Soluzione**:
1. Power BI Desktop → Model view
2. View → Show → Display folders
3. Verifica folders: 📊 KPI Principali, 🚨 Anomalie, etc.

### Problema: "Git merge conflict su TMDL"

**Soluzione**:
```bash
# 1. Accetta incoming changes
git checkout --theirs tmdl-output/tables/vw_DichiarazioneKM.tmdl

# 2. Rigenera BIM
deploy.bat

# 3. Verifica in Power BI Desktop

# 4. Commit risoluzione
git add tmdl-output/
git commit -m "fix: risolto merge conflict su misure DAX"
```

---

## 📅 Roadmap

### v1.1 (Q2 2026)

- [ ] Pagina "Anomalie" dedicata (drill-through da veicoli critici)
- [ ] Tooltip interattivi con storico scarto utente/veicolo
- [ ] Export Excel automatico "Veicoli da verificare"

### v2.0 (Q3 2026)

- [ ] Integrazione costi carburante (stimati da KM)
- [ ] Analisi tratte più frequenti (heatmap origine-destinazione)
- [ ] Previsioni ML su scarto atteso (Azure ML)
- [ ] Dashboard mobile Power BI Service

---

## 👥 Contributori

- **Owner**: Afellai3
- **Team**: Data Analytics - Trasporto e Logistica

---

## 📝 Licenza

Private - Uso interno aziendale

---

## 🔗 Link Utili

- [Power BI Desktop Download](https://powerbi.microsoft.com/desktop/)
- [pbi-tools Documentation](https://pbi.tools/)
- [DAX Guide](https://dax.guide/)
- [TMDL Specification](https://learn.microsoft.com/power-bi/developer/projects/projects-dataset)

---

**🚀 Buon lavoro con KM Flotta!**
