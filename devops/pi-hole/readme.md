# Pi Hole

As local DNS, rather than Ad blocker

## Set-up

[read this](https://docs.pi-hole.net/guides/dns/unbound/)

to update domains

```wget https://www.internic.net/domain/named.root -qO- sudo tee /var/lib/unbound/root.hints```

## Web Admin

```http:\\192.168.70.252:82\admin```

to see which port lighttpd is running on

```sudo lsof -i -P -n | grep lighttpd```

to see the config

```sudo vi /etc/lighttpd/lighttpd.conf```