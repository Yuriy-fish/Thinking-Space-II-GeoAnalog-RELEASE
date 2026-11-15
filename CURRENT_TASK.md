# CURRENT TASK: Audit Remediation (P0)

## Current Status: ALL P0 AUDIT REMEDIATION PRIORITIES COMPLETED & VERIFIED

### Completed Priorities:
- [x] **PRIORITY 1: Scientific Data Integrity** (Tests: 4/4 passed)
  - `NasaPowerProvider.js`: Removed universal mock fallbacks (`5.3°C`, `8.1°C`, etc.). Implemented verified curated cache; returns `UNAVAILABLE DATA` when offline or uncached. Separated 7-day observation window from 30-year climatology. Guarded demo mode with `SIMULATED DATA (DEMO ONLY)`.
  - `NasaPdsProvider.js`: Removed false live telemetry claims; returns `NOT_INTEGRATED` / `telemetry_available: false` while maintaining catalog links.
- [x] **PRIORITY 2: Map Source Correctness** (Tests: 5/5 passed)
  - Corrected OpenFreeMap vs OpenStreetMap raster attribution.
  - Renamed layers to honest sources: `Esri World Imagery` (ArcGIS Online) and `Esri World Physical Map`.
  - Declared CRISM layer with `tileUrl: null` and `status: 'UNAVAILABLE_IN_RASTER_VIEW'`. Guaranteed non-substitution of unrelated Earth imagery.
- [x] **PRIORITY 3: Planetary CRS & Projections** (Tests: 5/5 passed)
  - Implemented `equirectangular` projection for Moon and Mars in MapLibre GL JS (`mercator` for Earth).
  - Registered official lunar CRS (`IAU_2015:30100`, `IAU_2015:30120`) and Martian CRS (`IAU_2015:49901`).
  - Implemented longitude normalization between signed $[-180°, +180°]$ and positive-east $[0°, 360°]$.
  - Updated Great-Circle distance and polygon area with actual celestial body radii.
- [x] **PRIORITY 4: Mission Dossier Scientific Honesty** (Tests: 36/36 passed)
  - Removed generic Jezero citations for unrelated analogs; citations built dynamically from verified records.
  - Built supporting datasets exclusively from verified mission and target records.
  - Removed arbitrary numerical defaults (`5.0°`, `500m`, `1750`); missing physical parameters remain strictly `null`.
  - Replaced misleading spacecraft landing safety tiers derived from OFS with explicit terrestrial accessibility notes.
  - Replaced fixed `±4.2%` with dynamic uncertainty assessment.
  - Replaced automatic `SCIENTIFICALLY VERIFIED` status with honest states (`EVIDENCE SUPPORTED`, `ANALYSIS GENERATED`, `INSUFFICIENT EVIDENCE`).
- [x] **PRIORITY 5: MCDA Engine Corrections** (Tests: 29/29 passed)
  - If no physical scientific dimensions are comparable (`physicalCategoriesCount === 0` or `activeWeightSum === 0`), returns `asi: null` and `status: 'INSUFFICIENT EVIDENCE'`.
  - Separated physical planetary similarity (ASI) from operational field feasibility (OFS); operational target body match cannot inflate or fabricate an ASI score.
  - Parameter comparison rules (`PARAM_RULES`) explicitly documented as heuristic baselines pending empirical field calibration (`calibration_status: 'HEURISTIC_PRELIMINARY'`).
  - Enhanced `computeDCC` to dynamically blend parameter completeness ratio with data provenance tiers and status factor.
  - Updated UI null-safety in `WorkspacePage.js` to render `INSUFF. DATA` when ASI is null.
- [x] **UI & LAYER STREAMLINING (User Directed):**
  - Deleted `🔬 Analog Discovery` tab from workspace sidebar (`WorkspacePage.js`).
  - Deleted `🚀 Workspace` launch CTA button from global header navbar and mobile drawer (`Navbar.js`).
  - Deleted `OpenStreetMap Cartographic Basemap` and `Esri World Physical Map` from active layers and adapter (`PlanetaryRasterAdapter.js`, `PlanetaryMapLibre.js`), leaving high-resolution `Esri World Imagery` as the primary Earth satellite basemap.
  - Rebuilt production asset `dist/index.html` and synchronized `Offline_App.html`. All 146 unit tests passing.
  - Updated `PROJECT_STATUS.md`, `docs/DATA_INTEGRATION_STATUS.md`, `README.md`, and `docs/FINAL_TEST_REPORT.md`.
  - Removed unsupported claims of "PRODUCTION READY // 100% SPECIFICATION COMPLIANCE" or "COMPLETE COVERAGE".
  - Classified all subsystems into explicit maturity tiers (Tier 1: Verified Local Engine, Tier 2: Cached Curated Data, Tier 3: Planned/Catalog Live APIs).
  - Updated `package.json` test script; full test suite passing 146/146 tests.
