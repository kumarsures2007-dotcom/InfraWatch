# InfraWatch — Linux Infrastructure Monitoring System

## Overview

InfraWatch is a Bash-based Linux monitoring project
that checks basic system health and generates reports.

## Features

- Monitors root disk usage
- Monitors memory usage
- Displays system uptime
- Generates timestamped monitoring reports
- Records monitoring events in a log
- Supports automated execution using cron

## Requirements

- Linux
- Bash
- Standard Linux utilities
- Cron for scheduled monitoring

## Installation

Clone the repository or download the project files.

Navigate to the project directory:

    cd InfraWatch

Make the script executable:

    chmod +x monitor.sh

## Usage

Run the monitoring script:

    ./monitor.sh

Reports are stored in the reports directory.

Logs are stored in the logs directory.

## Automated Monitoring

You can schedule the script using cron.

Example: run every five minutes.

    */5 * * * * /home/suresh/InfraWatch/monitor.sh

Adjust the path to match your installation.

## Future Improvements

- CPU usage monitoring
- Email alerts
- Configurable thresholds
- Improved error handling
- Additional system health checks

## Author

Sureshkumar
