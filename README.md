# Ansible DEV setup (debian compatible)

Sets up a full development environment through [ansible](https://www.ansible.com/)
on remote hosts without the need to manually copy files or perform configurations
on the target machines.

## Deploy

### Pre-requisites

- Install the following dependencies:

  ```bash
  python3 -m pip install ansible ansible-runner psutil
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
./setup.sh <target-ip> <target-username>
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
