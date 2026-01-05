#!/bin/bash
set -euo pipefail

print_usage() {
  cat <<EOF
Usage:
  $0 <target-ip> <target-username> [--dry-run|-n]

Options:
  --dry-run, -n    Run ansible-playbook in check mode (adds --check --diff)
  -h, --help       Show this help
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  print_usage
  exit 0
fi

if [[ -z "${1:-}" || -z "${2:-}" ]]; then
  print_usage
  exit 1
fi

TARGET="$1"
USER="$2"
DRY=""
if [[ "${3:-}" == "--dry-run" || "${3:-}" == "-n" ]]; then
  DRY="--check --diff"
fi

ansible-galaxy collection install community.general || {
  echo "ansible-galaxy install failed" >&2
  exit 1
}

ANSIBLE_SSH_ARGS='-C -o ForwardX11=yes -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no' \
  ansible-playbook --inventory "${TARGET}," --user "${USER}" --ask-pass --ask-become-pass ${DRY} playbooks/main.yml
