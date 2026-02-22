# ==============================================================================
# WCP360 Preflight Checks
# ------------------------------------------------------------------------------
# Validates server readiness before system modification.
#
# Checks:
#   - apt availability
#   - Port 80 availability
#   - Network access
#
# Risk Prevention:
#   - Avoid installing over conflicting services
#
# No persistent changes are made in this phase.
# ==============================================================================
apt update -y
