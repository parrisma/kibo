# PI 4 and 5

## NAS Set Up

To bind to a NAS

```sudo apt-get install cifs-utils```
```sudo apt install nfs-kernel-server```
```sudo systemctl start nfs-kernel-server.service```
```sudo mount -t nfs 192.168.68.61:/volume1/Elrond /mnt/Elrond```
```systemctl daemon-reload```

```sudo systemctl enable nfs-kernel-server.service``` - ensure re-start on boot
```sudo systemctl restart nfs-kernel-server.service``` - for manual restart
```sudo systemctl enable nfs-kernel-server.service``` - to see service status

## Modify DNS (use Pi hold DNS)

```sudo nmcli con mod "Wired connection 1" ipv4.dns "192.168.68.63, 192.168.68.59"```
```sudo nmcli con mod "Wired connection 1" ipv4.ignore-auto-dns yes```
```sudo service NetworkManager restart```
```sudo apt-get install dnsutils``` # dig and other tools
```dig arther.local.nas```

Where IP addresses are IP addresses of eth0 and wlan0 on the pi running Pi Hole and unbound
```nmcli connection show```
```hostname -I```

```arther.local.nas``` is a DNS name configured on pi hole
