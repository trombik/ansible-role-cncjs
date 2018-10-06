# ansible-role-cncjs

Install [cncjs](https://github.com/cncjs/cncjs) via `npm`.

# Requirements

The role assumes both `nodejs` and `npm` are installed. Use
[trombik.nodejs](https://github.com/trombik/ansible-role-nodejs) to install
them (optional, you may use other implementation).

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `cncjs_user` | User of `cncjs` | `cncjs` |
| `cncjs_group` | Group of `cncjs` | `cncjs` |
| `cncjs_user_home` | Path to `$HOME` of user `cncjs` | `{{ __cncjs_user_home }}` |
| `cncjs_root_dir` | Path to root directory of `cncjs` application | `{{ cncjs_user_home }}/cncjs` |
| `cncjs_conf_file` | Path to `.cncrc` | `{{ cncjs_user_home }}/.cncrc` |
| `cncjs_config` | Hash of configuration in `yaml` format | `{}` |
| `cncjs_registry` | Optional node registry path | `""` |
| `cncjs_version` | Optional `cncjs` version | `""` |

## Debian

| Variable | Default |
|----------|---------|
| `__cncjs_user_home` | `/home/{{ cncjs_user }}` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__cncjs_user_home` | `/usr/home/{{ cncjs_user }}` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - trombik.nodejs
    - ansible-role-cncjs
  vars:
    # taken from examples/.cncrc
    cncjs_config:
      ports:
      - comName: "/dev/ttyAMA0"
        manufacturer: ''
      baudrates:
        - 115200
        - 250000
      watchDirectory: "/path/to/dir"
      accessTokenLifetime: 30d
      allowRemoteAccess: false
      controller: ''
      state:
        checkForUpdates: true
      commands:
        - title: Update (root user)
          commands: sudo npm install -g cncjs@latest --unsafe-perm; pkill -a -f cnc
        - title: Update (non-root user)
          commands: npm install -g cncjs@latest; pkill -a -f cnc
        - title: Reboot
          commands: sudo /sbin/reboot
        - title: Shutdown
          commands: sudo /sbin/shutdown
      events: []
      macros: []
      users: []
      # `secret` must be set because cncjs would creayte random secret if
      # missing
      secret: "{{ 'PassWord' | password_hash('sha256', 'mysecretsalt') }}"
```

# License

```
Copyright (c) 2018 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
