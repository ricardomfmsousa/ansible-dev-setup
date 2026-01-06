# Ansible DEV setup (debian compatible)

Sets up a full development environment through [ansible](https://www.ansible.com/)
on local or remote Cosmic Debian based hosts without the need to manually copy files or perform
configurations on the target machines.

## Deploy

### Pre-requisites

- Install the following dependencies:

  ```bash
  sudo apt update && \
  sudo apt install -y python3 python3-pip python3-venv python3-full && \
  python3 -m venv ~/ansible-env && \
  source ~/ansible-env/bin/activate && \
  pip install --upgrade pip && \
  pip install ansible ansible-runner psutil
  ```

- The **target hosts** should have ssh installed:

  ```bash
  sudo apt install ssh
  ```

- Get all **target hosts** IPs:

  ```bash
  ip a | grep inet
  ```

### Execute

```bash
# Local deployment (forwards optional dry-run)
./deploy-local.sh [--dry-run|-n]

# Remote deployment
./deploy-remote.sh <target-ip> <target-username> [--dry-run|-n]

# Passing `--dry-run` (or `-n`) runs Ansible in check mode (adds `--check --diff`).
```

## Playbook development

- Install the linter
  ```bash
  pip3 install "ansible-lint"
  ```
- Run the linter before committing and fix all raised issues
  ```bash
  ansible-lint
  ```
  > **TODO:** configure `pre-commit` to automate the last step (https://ansible-lint.readthedocs.io/en/latest/configuring/)
