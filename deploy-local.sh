#!/bin/bash
set -euo pipefail

# Usage: ./deploy-local.sh [--dry-run|-n]
# For local deployment, forward the optional dry-run flag to `deploy-remote.sh`.

DRY_FLAG="${1:-}"

if [[ "$DRY_FLAG" == "-h" || "$DRY_FLAG" == "--help" ]]; then
	echo "Usage: $0 [--dry-run|-n]"
	exit 0
fi

./deploy-remote.sh localhost "$(whoami)" "${DRY_FLAG}"