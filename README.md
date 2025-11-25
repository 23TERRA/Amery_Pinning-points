# Century-scale stability with pinning-point sensitivity in the Lambert–Amery system (Úa–PICO workflows)
# What's this?
[![DOI](https://zenodo.org/badge/1082543431.svg)](https://doi.org/10.5281/zenodo.17705566)
These scripts reproduce the simulations and figures for the Lambert–Amery (AmIS) study that analyzes how surface mass balance (SMB), ocean-forced basal melt, and pinning-point geometry jointly set 21st-century sea-level contribution. 

The repository contains:
model definitions and parameters for the Úa–PICO coupling,
plotting utilities to regenerate paper figures, and
outputs for 12 climate experiments (10 SSP5-8.5/RCP8.5 scenarios + 2 controls) and 22 geometry experiments (12 APPs “all-pins” + 10 single-pin tests).

# Coupled Model Parameters (Úa & PICO) File
File Location: Century-scale stability with pinning-point sensitivity in the Lambert–Amery system/DefineUa_PICO;

Purpose: All parameters, switches, and utilities to run the coupled Úa–PICO model.

Key Features:

1.Úa setup (Define*): SSA solver options, rheology (Glen n = 3), inverse-mode rate factor A and basal slipperiness C (held fixed in forward runs).

2.PICO setup (PICO*): box-overturning configuration following ISMIP6 conventions with
effective turbulent exchange γ*_T = 1.5×10⁴ m s⁻¹,
maximum boxes n_max = 10,
basin-mean T–S boundary forcing.

3.Forcing (DefineMassBalance*): ISMIP6 SMB anomalies and basin-mean ocean T–S (GHub–ISMIP6-Forcing).

# Plotting Utilitiesr File
File Location: Century-scale stability with pinning-point sensitivity in the Lambert–Amery system/Plot;

Purpose: Scripts to regenerate paper figures and diagnostics.


# Results (Outputs) File
File Location: Century-scale stability with pinning-point sensitivity in the Lambert–Amery system/Results;

Purpose: Simulation outputs for all runs (controls, scenarios, APPs, single pins).

# How to do the Experiments & Pinning Perturbations？
What’s included：

1.Climate experiments (12 total):
10 scenarios (SSP5-8.5/RCP8.5 members) with time-evolving SMB and basin-mean T–S.

2.Two controls with identical SMB:
Ctrl-Static (fixed-2020 T–S to PICO),
Ctrl-OceanAvg (time-evolving ensemble-mean T–S to PICO).

3.Geometry experiments (22 total):
APPs (All Pins): basin-wide 500 m bed lowering strictly within all pinning polygons from Matsuoka et al. (2015).
Single-pin tests (10 largest features): same 500 m lowering applied individually.

Note：Pin polygons originate from Matsuoka et al. (2015); using BedMachine v3 (2020) we found Podlednyj Holm ungrounded and Svarthausen Nunatak outside the Lambert–Amery drainage, yielding a final set of ten single-pin sites.
The 500 m perturbations modify only bed elevation inside each pin polygon; all other geometry and parameters are unchanged.


# Data sources (brief)
1.Drainage basins: Zwally et al. (2012).

2.Bed/geometry: BedMachine Antarctica v3 (Morlighem et al., 2020).

3.Pinning polygons: Matsuoka et al. (2015).

4.Forcings: ISMIP6 SMB anomalies and basin-mean T–S (Nowicki et al., 2020; Jourdain et al., 2020).



