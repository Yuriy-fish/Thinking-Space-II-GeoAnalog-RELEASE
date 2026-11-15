# GeoAnalog Matchmaker 🚀
### NASA Space Apps Challenge 2026 // Planetary Analog Intelligence Platform

> **"Identify Earth Locations that Analog the Permanent Moon Base Locations and Mars."**

GeoAnalog Matchmaker is an advanced planetary science decision-support platform designed to compare, rank, discover, and characterize high-fidelity terrestrial analogs for high-priority exploration targets on the **Moon** (Artemis south pole candidates, lava tubes, maria) and **Mars** (Jezero, Gale, Valles Marineris, Mawrth Vallis).

---

## 🌐 100% Offline Double-Click Mode (No Node, No Python, No Server Required!)

You can now run GeoAnalog Matchmaker **completely offline** with zero server or runtime dependencies:

- **Simply double-click** either:
  1. [Offline_App.html](file:///C:/Users/ADMIN/.gemini/antigravity/scratch/geoanalog-matchmaker/Offline_App.html) in the root folder, OR
  2. [index.html](file:///C:/Users/ADMIN/.gemini/antigravity/scratch/geoanalog-matchmaker/index.html) in the root folder (auto-routes seamlessly), OR
  3. [dist/index.html](file:///C:/Users/ADMIN/.gemini/antigravity/scratch/geoanalog-matchmaker/dist/index.html)
- **Zero Installation**: All JavaScript, CSS styles, MapLibre shaders, Three.js 3D globe models, i18n locales, and planetary/analog catalogs are bundled into a single standalone self-contained HTML file (~2.5 MB).
- Works directly on any USB drive, offline machine, or companion laptop.

---

## 🖥️ Running on a New / Companion's Laptop

The launcher is **self-detecting** — it tries three strategies automatically:

| Mode | How to Run | Requirement | Experience |
|------|------------|-------------|------------|
| **Instant Offline (Double-Click)** | Double-click `Offline_App.html` or `index.html` | Any web browser (Chrome, Edge, Firefox) | ✅ 100% Offline & Portable |
| **Dev Server (Node.js)** | Double-click `launch.bat` | Node.js installed | ✅ Live HMR (`http://localhost:5173/`) |
| **Local HTTP (Python)** | Double-click `launch.bat` | Python 3 installed | ✅ HTTP Server (`http://localhost:8080/`) |

**Easiest steps for a brand-new laptop:**
1. Install **Node.js LTS** from https://nodejs.org/ *(one-time, ~5 minutes)*
2. Copy the project folder to the laptop (USB / ZIP / share)
3. Double-click **`launch.bat`** — it handles the rest automatically

**If you can't install anything on the laptop:**
- Python 3 is usually pre-installed on many laptops — `launch.bat` will find it
- Or just double-click `launch.bat` anyway — it will open `dist/index.html` as a last resort

---

## ⚡ One-Click Quick Launch

### Option 1: Windows Double-Click (Recommended)
Simply double-click **`launch.bat`** (or **`run.bat`**) in the project folder.
- Detects Node.js or Python automatically — no manual setup needed.
- Auto-installs npm dependencies on first Node.js run.
- Starts the web server and opens your default browser.

### Option 2: PowerShell
Right-click `launch.ps1` → *Run with PowerShell*, or:
```powershell
.\launch.ps1
```

### Option 3: Standard Node / npm CLI
```bash
# 1. Install dependencies (first time only)
npm install

# 2. Start server and auto-open browser
npm start
```

---

## 🧪 Automated Testing & Scientific Verification

Run all 8 scientific engine and provider test suites (146 unit tests verifying Providers, Planetary Maps, MCDA, HADE, ML, Portfolio Optimization, Knowledge Graph, and Mission Dossier export):
```bash
npm test
```

To create a production-optimized build:
```bash
npm run build
```

---

## 🗺️ Key Platform Capabilities

1. **Analysis Workspace**: Multi-Criteria Decision Analysis (MCDA) evaluating Analog Similarity Index (ASI), Data Coverage & Confidence (DCC), and Operational Field Suitability (OFS) across 7 scientific categories with epistemic null-safety and heuristic calibration notices.
2. **Hidden Analog Discovery Engine (HADE)**: Geospatial discovery engine conducting coarse-to-fine global screening, process-based analog matching (impact cratering, volcanism, lacustrine, hydrothermal, aeolian), multispectral mineral similarity (EMIT & CRISM), and morphological equifinality diagnostics.
3. **Multi-Objective Composite Portfolio Optimizer**: Synthesizes multi-site analog field campaign portfolios to maximize comprehensive planetary coverage (PCI > 90%) with an explicit multi-environment disclaimer.
4. **Explainable ML & Novelty Detection**: k-NN feature similarity search, statistical Euclidean outlier detection, and non-dominated Pareto frontier trade-off analysis.
5. **Interactive Mapping & 3D Celestial Globes**: 2D MapLibre GL mapping with equirectangular Moon/Mars planetary projections, official IAU CRS transformations (`IAU_2015:30100`, `IAU_2015:49901`), dual longitude conventions, and 3D Three.js celestial globes.
6. **Mission Dossier & Multi-Format Reporting**: One-click generation of briefing dossiers with radar charts, delta tables, dynamic citations, and exports in JSON, CSV, GeoJSON, PNG, and print-ready PDF.

---

## 📜 Scientific Datasets & Space Agency Provenance
All baseline data is verified from official planetary archives and curated registries:
- **NASA Planetary Data System (PDS)**: Catalog metadata and direct mission archive links (Tier 3: catalog lookup; live telemetry API not integrated in this build).
- **NASA LRO** (LROC, LOLA, Diviner Lunar Radiometer) via NASA Trek raster layers.
- **NASA MRO** (CRISM mineral parameters, HiRISE) & Mars Odyssey (THEMIS).
- **NASA POWER**: Curated empirical coordinate cache (Tier 2); returns `UNAVAILABLE DATA` when offline or uncached without synthetic numbers.
- **OpenFreeMap / OpenStreetMap & Esri**: Terrestrial vector and satellite imagery basemaps.
- **USGS Astrogeology Science Center**: Planetary datums, radii, and IAU coordinate frames.

---

## 📄 License
MIT License. Developed for NASA Space Apps Challenge 2026.
