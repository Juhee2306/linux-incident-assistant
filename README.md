# Linux Incident Assistant

A lightweight Bash-based tool that detects common Linux system incidents
and logs actionable diagnostics.

## Problem Statement

Linux systems often fail due to silent resource exhaustion or loss of access.
The hardest part is not running commands, but knowing **what to check first**
during an incident.

## What This Tool Does

The Linux Incident Assistant performs the following checks:

- Disk usage pressure (threshold-based)
- Memory usage pressure
- SSH availability (process-based detection)

Each check is classified as `OK` or `WARNING` and written to a log file
for later analysis.

## Design Principles

- **Incident-first thinking**: Focuses on common failure modes, not metrics noise
- **Portable**: Does not assume systemd; works in minimal environments
- **Runtime logging**: Logs are generated at execution time and not committed to Git
- **Maintainable**: Refactored into functions for clarity and reuse

## Project Structure

linux-incident-assistant/
├── bin/
│   └── incident_check.sh
├── logs/
│   └── incident.log (generated at runtime)
└── README.md

## How to Run

```bash
cd bin
chmod +x incident_check.sh
./incident_check.sh
```
Logs are written to:
```bash
../logs/incident.log
```
## Deployment on EC2

This tool was deployed and validated on an Ubuntu 22.04 EC2 instance.

The repository was cloned directly from GitHub on the server and executed
without modification. Logs were generated at runtime based on the EC2
instance state, validating portability across environments.

## Scope

This project focuses on incident detection and basic diagnostic context.
It intentionally avoids automated remediation and external alerting,
keeping the scope aligned with observability and triage.
