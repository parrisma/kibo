# Pi Hole

As local DNS, rather than Ad blocker

## Set-up

[read this](https://docs.pi-hole.net/guides/dns/unbound/)

to update domains

```wget https://www.internic.net/domain/named.root -qO- sudo tee /var/lib/unbound/root.hints```