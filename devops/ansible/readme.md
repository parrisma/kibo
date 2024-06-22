# Ansible

## Install

[install notes](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu)

## Create ansible user on host

```sudo addgroup ansible```
```sudo adduser --gid 1001 --shell /bin/bash --home /home/ansible ansible```
```sudo usermod -a -G sudo ansible```

## Generate key for ssh

```ssh-keygen -b 4096 -i /home/ansible/.ssh/ansible```
```ssh-copy-id -i /home/ansible/.ssh/ansible 192.168.99.99```
```ssh -i /home/ansible/.ssh/ansible 192.68.99.99```i

## Run playbook

e.g.
```ansible-playbook ./playbook/etcd_user.yml -i ./inventory/hosts --user ansible --ask-become-pass -e user_config=etcd_user_config.yml```

## etcd

[info](https://etcd.io/docs/v2.3/docker_guide/)