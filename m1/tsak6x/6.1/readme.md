
forwarding packet between all eth

> sysctl -w net.ipv4.ip_forward="1"


NAT

> -A PREROUTING -i eth0 -p tcp -m tcp --dport 22 -j DNAT --to-destination 10.0.5.72:2222

> -A POSTROUTING -o eth0 -j MASQUERADE

save all new rules

> iptables-save -f /etc/iptables/NAT.conf

Create script for auto update iptables 


> sudo nano /etc/network/if-pre-up.d/iptables

add to it:

```
#!/bin/sh
/sbin/iptables-restore < /etc/iptables/NAT.conf
```
add permissionf for execute

> ubuntu@ip-10-0-1-98:~$ sudo chmod +x /etc/network/if-pre-up.d/iptables
