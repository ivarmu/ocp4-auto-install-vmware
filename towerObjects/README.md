Tower Objects Deploy
=========

Ansible playbooks and roles to create Tower Objects related to Ephemeral OCP4 environments based on VMware virtualization.

Requirements
------------

These playbooks and roles are tested on Ansible 2.9.

Dependencies
------------
N/A

Encrypted variables
----------------
All encrypted variables should be placed at `vars/configure_tower_vault.yml` or at `vars/configure_tower_credentials.yml`.

Create, encrypt and edit files with ansible-vault:
```console
$ ansible-vault create vars/configure_tower_vault.yml
$ ansible-vault encrypt vars/configure_tower_vault.yml
$ ansible-vault edit vars/configure_tower_vault.yml
```

Playbooks:
-----------------

- playbooks/config-tower.yml
```console
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags credentials_types,
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags credentials,
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags groups,
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags hosts,
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags inventories,
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags job_templates,
$ ansible-playbook playbooks/config-tower.yml --ask-vault-pass --tags projects,
```

Playbook's example execution:
----------------------------

Variables
----------

Variables Must be set in yaml files with follow structure:

```
vars/configure_tower_ENTITY.yml
```

and the content must define a main variable with the same name as the file name:

```yaml
---
configure_tower_ENTITY:
  var: value
...
```

Where ENTITY can be any of the following values:
* credentials
* credential_types
* groups
* hosts
* inventories
* job_templates
* projects

Vars files example:
```yaml
$ cat vars/configure_tower_inventories.yml
---
configure_tower_inventories:
  - name: "EphemeralOCP4localhost"
    description: "Inventory for EphemeralOCP4 localhost"
    organization: "Red Hat"
...
```

Git configuration to diff vaulted files
=========

If you want to `git diff` vaulted files, you must name them with the pattern `*_credentials.yml` or `*_vault.yml` and configure some things into your local git configuration.

Content to be added to your local config file for git `${HOME}/.gitconfig` or running the command `git config --global --edit` (alias section is not required):
```ini
[diff "ansible-vault"]
  textconv = ansible-vault view
[merge "ansible-vault"]
  driver = ./ansible-vault-merge %O %A %B %L %P
  name = Ansible Vault merge driver
[alias]
lg1 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all
lg = !"git lg1"
```

Already provided files:

- `${REPO_ROOT}/.gitattributes`:
  > ```conf
  > *_credentials.yml filter=ansible-vault diff=ansible-vault merge=binary
  > *_vault.yml filter=ansible-vault diff=ansible-vault merge=binary
  > ```

- `${REPO_ROOT}/ansible-vault-merge`:
  > ```bash
  > #!/usr/bin/env bash
  > set -e
  >
  > ancestor_version=$1
  > current_version=$2
  > other_version=$3
  > conflict_marker_size=$4
  > merged_result_pathname=$5
  >
  > ancestor_tempfile=$(mktemp tmp.XXXXXXXXXX)
  > current_tempfile=$(mktemp tmp.XXXXXXXXXX)
  > other_tempfile=$(mktemp tmp.XXXXXXXXXX)
  >
  > delete_tempfiles() {
  >     rm -f "$ancestor_tempfile" "$current_tempfile" "$other_tempfile"
  > }
  > trap delete_tempfiles EXIT
  >
  > ansible-vault decrypt --output "$ancestor_tempfile" "$ancestor_version"
  > ansible-vault decrypt --output "$current_tempfile" "$current_version"
  > ansible-vault decrypt --output "$other_tempfile" "$other_version"
  >
  > git merge-file "$current_tempfile" "$ancestor_tempfile" "$other_tempfile"
  >
  > ansible-vault encrypt --output "$current_version" "$current_tempfile"
  > ```

Finally, and to simplify your life, you can create the file `${REPO_ROOT}/.vault_password` containing the vault password and configure your `ansible.cfg` like follows:
```ini
vault_password_file = ./.vault_password
```
This way, the `git diff` command will not ask for the vault password multiple times.

License
-------

GPLv3

Author Information
------------------
silvinux - silvio@redhat.com
iaragone - iaragone@redhat.com

