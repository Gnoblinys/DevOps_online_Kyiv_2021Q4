# Tsak 6.2 #

**Setup DNS Dnsmasq**

Disable internal ubuntu resolve service
```
systemctl disable systemd-resolved
systemctl stop systemd-resolved
```
Backup and delete resolv.conf
```
mv resolv.conf backup_resolv
```
Create nev resolv.conf with simple configuration
```
echo "nameserver 8.8.8.8" > /etc/resolv.conf
```
Install service Dnsmasq
```
apt install dnsmasq
```

Backup dnsmasq.conf
```
mv dnsmasq.conf backup_dnsmasq_conf
```
Create nev dnsmasq.conf with DNS configuration
```
nano dnsmasq.conf

#DNS setup
port=53
domain-needed
bogus-priv
strict-order
expand-hosts
interface=eth1

systemctl restart dnsmasq

```
Check
```
dig A google.com

; <<>> DiG 9.16.1-Ubuntu <<>> A google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 61958
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;google.com.                    IN      A

;; ANSWER SECTION:
google.com.             120     IN      A       142.250.191.238

;; Query time: 16 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Sun Dec 19 17:54:01 UTC 2021
;; MSG SIZE  rcvd: 55
```
**Setup DHCP Dnsmasq**

Add configuration to dnsmasq.conf
```
nano dnsmasq.conf


#DHCP setup
dhcp-range=10.0.5.100,10.0.5.110,255.255.255.0
dhcp-option=option:router,10.0.5.34
dhcp-option=option:dns-server,10.0.5.34
dhcp-option=1,255.255.255.0
dhcp-option=2,60
log-dhcp
dhcp-leasefile=/var/log/dnsmasq-leases.log
```


I can't chek work DHCP - becouse my host run in AWS where aws-DHCP server didn't stop and have first priority.
But i have experience with difernet setup DHCP in mikrotik.





















|Type|Link|
|----|----|
|DNSMASQ|[linhttps://infoit.com.uaux/ubuntu/](linhttps://infoit.com.uaux/ubuntu/kak-ustanovit-i-nastroit-dnsmasq-na-ubuntu-18-04-lts/)|

