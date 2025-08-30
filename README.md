# Scripting Projects

Collection of DevOps scripts for learning and automation.

## Scripts

### health_check.sh
Checks:
- Disk usage (top 5 lines)
- Top 5 memory processes
- Open TCP listeners

#### Usage
```bash
./health_check.sh
./health_check.sh | tee reports/health_$(date +%F_%H%M).log
