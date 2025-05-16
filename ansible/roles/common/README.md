Role Name
=========

Common

A role to perform common setup tasks including installing packages, removing /etc/motd file, and appending login info-message to user's .bashrc files.

Requirements
------------

No specific requirements beyond a Debian-based operating system.

Role Variables
--------------

- `default_user`: user name where .bashrc will be modified.

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role:

```yaml
    - hosts: servers
      roles:
         - common
```

This will execute the common tasks on the servers.
