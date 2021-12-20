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


**Quagga**

Prepare network on NAT server

```
nano /etc/sysctl.conf
net.ipv4.conf.all.forwarding=1
net.ipv4.conf.all.proxy_arp=1
net.ipv4.conf.default.rp_filter=0
net.ipv4.conf.all.rp_filter=0
sysctl -p
```

Install quagga in H1-H2-H3 hosts

```
sudo apt install quagga

cp /usr/share/doc/quagga-core/examples/vtysh.conf.sample /etc/quagga/vtysh.conf
cp /usr/share/doc/quagga-core/examples/zebra.conf.sample /etc/quagga/zebra.conf
cp /usr/share/doc/quagga-core/examples/bgpd.conf.sample /etc/quagga/bgpd.conf
sudo chown quagga:quagga /etc/quagga/*.conf
sudo chown quagga:quaggavty /etc/quagga/vtysh.conf
sudo chmod 640 /etc/quagga/*.conf

```
Enable log
```
mkdir /var/log/quagga/
chown quagga:quagga /var/log/quagga/
touch /var/log/zebra.log
chown quagga:quagga /var/log/zebra.log
```

Start services
```
oot@ip-10-0-1-30:/home/ubuntu# service zebra start
root@ip-10-0-1-30:/home/ubuntu# service zebra status
● zebra.service - GNU Zebra routing manager
     Loaded: loaded (/lib/systemd/system/zebra.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2021-12-20 14:57:27 UTC; 5s ago
       Docs: man:zebra
    Process: 2112 ExecStartPre=/sbin/ip route flush proto zebra (code=exited, status=0/SUCCESS)
    Process: 2113 ExecStartPre=/bin/chmod -f 640 /etc/quagga/vtysh.conf /etc/quagga/zebra.conf (code=exited, status=0/SUCCESS)
    Process: 2114 ExecStartPre=/bin/chown -f quagga:quagga /etc/quagga/zebra.conf (code=exited, status=0/SUCCESS)
    Process: 2115 ExecStartPre=/bin/chown -f quagga:quaggavty /etc/quagga/vtysh.conf (code=exited, status=0/SUCCESS)
    Process: 2116 ExecStart=/usr/sbin/zebra -d -A 127.0.0.1 -f /etc/quagga/zebra.conf (code=exited, status=0/SUCCESS)
   Main PID: 2117 (zebra)
      Tasks: 1 (limit: 1147)
     Memory: 1.3M
     CGroup: /system.slice/zebra.service
             └─2117 /usr/sbin/zebra -d -A 127.0.0.1 -f /etc/quagga/zebra.conf

Dec 20 14:57:27 ip-10-0-1-30 systemd[1]: Starting GNU Zebra routing manager...
Dec 20 14:57:27 ip-10-0-1-30 systemd[1]: Started GNU Zebra routing manager.
root@ip-10-0-1-30:/home/ubuntu# service bgpd start
root@ip-10-0-1-30:/home/ubuntu# service bgpd status
● bgpd.service - BGP routing daemon
     Loaded: loaded (/lib/systemd/system/bgpd.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2021-12-20 14:57:44 UTC; 3s ago
       Docs: man:bgpd
    Process: 2131 ExecStartPre=/bin/chmod -f 640 /etc/quagga/bgpd.conf (code=exited, status=0/SUCCESS)
    Process: 2132 ExecStartPre=/bin/chown -f quagga:quagga /etc/quagga/bgpd.conf (code=exited, status=0/SUCCESS)
    Process: 2133 ExecStart=/usr/sbin/bgpd -d -A 127.0.0.1 -f /etc/quagga/bgpd.conf (code=exited, status=0/SUCCESS)
   Main PID: 2134 (bgpd)
      Tasks: 1 (limit: 1147)
     Memory: 2.6M
     CGroup: /system.slice/bgpd.service
             └─2134 /usr/sbin/bgpd -d -A 127.0.0.1 -f /etc/quagga/bgpd.conf

Dec 20 14:57:44 ip-10-0-1-30 systemd[1]: Starting BGP routing daemon...
Dec 20 14:57:44 ip-10-0-1-30 systemd[1]: Started BGP routing daemon.
root@ip-10-0-1-30:/home/ubuntu# sudo systemctl is-enabled zebra.service
sudo: unable to resolve host ip-10-0-1-30: Name or service not known
enabled

```

Check start services with system
```
root@ip-10-0-1-30:/home/ubuntu# sudo systemctl is-enabled zebra.service
sudo: unable to resolve host ip-10-0-1-30: Name or service not known
enabled
root@ip-10-0-1-30:/home/ubuntu# sudo systemctl is-enabled bgpd.service
sudo: unable to resolve host ip-10-0-1-30: Name or service not known
enabled
root@ip-10-0-1-30:/home/ubuntu# systemctl enable zebra.service
Synchronizing state of zebra.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable zebra
root@ip-10-0-1-30:/home/ubuntu# systemctl enable bgpd.service
Synchronizing state of bgpd.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable bgpd
```

Add .conf

H1
```
nano /etc/quagga/zebra.conf

hostname H1
password zebra
enable password zebra
log file /var/log/quagga/zebra.log
!
line vty
```

```
nano /etc/quagga/ospfd.conf 

log file /var/log/quagga/ospfd.log
router ospf
ospf router-id 10.0.5.34
log-adjacency-changes
redistribute kernel
redistribute connected
redistribute static
network 10.0.5.0/24 area 1
!
line vty
!























|Type|Link|
|----|----|
|DNSMASQ|[linhttps://infoit.com.uaux/ubuntu/](linhttps://infoit.com.uaux/ubuntu/kak-ustanovit-i-nastroit-dnsmasq-na-ubuntu-18-04-lts/)|

