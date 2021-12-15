# Tsak 6.1 #

Host NAT - H1
Host behind the H1 - H2

2. VM2 has one interface (internal), VM1 has 2 interfaces (NAT and internal). Configure all network
interfaces in order to make VM2 has an access to the Internet (iptables, forward, masquerade).

**Preparing H1**

```
root@ip-10-0-1-30:/sbin# lshw -C network
  *-network:0
       description: Ethernet interface
       physical id: 1
       logical name: eth0
       serial: 02:79:0e:15:e3:1a
       capabilities: ethernet physical
       configuration: broadcast=yes driver=vif driverversion=5.11.0-1022-aws ip=10.0.1.30 link=yes multicast=yes
  *-network:1
       description: Ethernet interface
       physical id: 2
       logical name: eth1
       serial: 02:7b:fc:9b:96:78
       capabilities: ethernet physical
       configuration: broadcast=yes driver=vif driverversion=5.11.0-1022-aws ip=10.0.5.34 link=yes multicast=yes
```

Allow forwarding packet between all eth

> sysctl -w net.ipv4.ip_forward="1"


Add iptables rule. Created bash script /etc/rc.local
```

#!/bin/bash

# /etc/rc.local

# Accept incoming packets from localhost and the LAN interface.
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i eth1 -j ACCEPT

# Accept incoming packets from the WAN if the router initiated the connection.
iptables -A INPUT -i eth0 -m conntrack \
--ctstate ESTABLISHED,RELATED -j ACCEPT

# Forward LAN packets to the WAN.
iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT

# Forward WAN packets to the LAN if the LAN initiated the connection.
iptables -A FORWARD -i eth0 -o eth1 -m conntrack \
--ctstate ESTABLISHED,RELATED -j ACCEPT

# NAT traffic going out the WAN interface.
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# SSH forward
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 2222 -j DNAT --to-destination 10.0.5.145:22


# rc.local needs to exit with 0
exit 0
```

```
root@ip-10-0-1-30:/sbin# iptables -S
-P INPUT ACCEPT
-P FORWARD ACCEPT
-P OUTPUT ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -i eth1 -j ACCEPT
-A INPUT -i eth0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -i eth1 -o eth0 -j ACCEPT
-A FORWARD -i eth0 -o eth1 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
root@ip-10-0-1-30:/sbin# iptables -t nat -S
-P PREROUTING ACCEPT
-P INPUT ACCEPT
-P OUTPUT ACCEPT
-P POSTROUTING ACCEPT
-A PREROUTING -i eth0 -p tcp -m tcp --dport 2222 -j DNAT --to-destination 10.0.5.145:22
-A POSTROUTING -o eth0 -j MASQUERADE
```

**Preparing H2**

```
root@ip-10-0-1-145:/home/ubuntu# lshw -C network
  *-network:0
       description: Ethernet interface
       physical id: 1
       logical name: eth0
       serial: 02:03:c7:70:6c:46
       capabilities: ethernet physical
       configuration: broadcast=yes driver=vif driverversion=5.11.0-1022-aws link=yes multicast=yes
  *-network:1
       description: Ethernet interface
       physical id: 2
       logical name: eth1
       serial: 02:72:35:a2:38:c0
       capabilities: ethernet physical
       configuration: broadcast=yes driver=vif driverversion=5.11.0-1022-aws ip=10.0.5.145 link=yes multicast=yes

```

Setup eth1 (eth0 was desable after update systeam)

Create file

> toush /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg

and add:

> network: {config: disabled}


Change file nano 
> nano /etc/netplan/50-cloud-init.yaml


```

        eth1:
            dhcp4: false
            dhcp4-overrides:
               route-metric: 200
            dhcp6: false
            addresses:
                - 10.0.5.145/24
            routes:
                - to: default
                  via: 10.0.5.34
            nameservers:
                addresses: [8.8.8.8, 8.8.4.4]
            match:
                macaddress: 02:72:35:a2:38:c0
            set-name: eth1
    version: 2
    renderer: networkd

```
Chek and apply netplan

> netplan apply


3. Check the route from VM2 to Host.
```
root@ip-10-0-1-145:/home/ubuntu# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    0      0        0 eth1
10.0.5.0        0.0.0.0         255.255.255.0   U     0      0        0 eth1

root@ip-10-0-1-145:/home/ubuntu# ping _gateway
PING _gateway (10.0.5.34) 56(84) bytes of data.
64 bytes from _gateway (10.0.5.34): icmp_seq=1 ttl=64 time=0.363 ms
64 bytes from _gateway (10.0.5.34): icmp_seq=2 ttl=64 time=0.429 ms
^C
--- _gateway ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms
rtt min/avg/max/mdev = 0.363/0.396/0.429/0.033 ms
```

4. Check the access to the Internet, (just ping, for example, 8.8.8.8)
```
root@ip-10-0-1-145:/home/ubuntu# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=36 time=11.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=36 time=11.9 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=36 time=11.8 ms
^C
--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 11.765/11.835/11.898/0.054 ms
```
4. Check the access to the Internet, (just ping, for example, 8.8.8.8)
```
root@ip-10-0-1-145:/home/ubuntu# nslookup 8.8.8.8
8.8.8.8.in-addr.arpa    name = dns.google.

```

6. Determine, which IP address belongs to resource epam.com.
```
root@ip-10-0-1-145:/home/ubuntu# nslookup epam.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   epam.com
Address: 3.214.134.159
```
7. Determine the default gateway for your HOST and display routing table.
```
root@ip-10-0-1-30:/sbin# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    100    0        0 eth0
default         _gateway        0.0.0.0         UG    200    0        0 eth1
10.0.1.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
_gateway        0.0.0.0         255.255.255.255 UH    100    0        0 eth0
10.0.5.0        0.0.0.0         255.255.255.0   U     0      0        0 eth1
_gateway        0.0.0.0         255.255.255.255 UH    200    0        0 eth1

PING _gateway (10.0.1.1) 56(84) bytes of data.
64 bytes from _gateway (10.0.1.1): icmp_seq=1 ttl=255 time=0.261 ms
64 bytes from _gateway (10.0.1.1): icmp_seq=2 ttl=255 time=0.309 ms
64 bytes from _gateway (10.0.1.1): icmp_seq=3 ttl=255 time=0.359 ms
^C
--- _gateway ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2025ms
rtt min/avg/max/mdev = 0.261/0.309/0.359/0.040 ms

```
Getawey for H1 - _getaway with metric 100 - 10.0.1.1

8. Trace the route to google.com.

```
root@ip-10-0-1-145:/home/ubuntu# traceroute google.com
traceroute to google.com (142.250.191.206), 30 hops max, 60 byte packets
 1  _gateway (10.0.5.34)  0.472 ms  0.456 ms  0.442 ms
 2  ec2-52-15-0-53.us-east-2.compute.amazonaws.com (52.15.0.53)  7.568 ms ec2-52-15-0-35.us-east-2.compute.amazonaws.com (52.15.0.35)  4.212 ms  4.227 ms
 3  100.65.31.144 (100.65.31.144)  8.733 ms 100.65.27.0 (100.65.27.0)  2.301 ms 100.65.25.32 (100.65.25.32)  4.007 ms
 4  * 100.66.13.208 (100.66.13.208)  3.939 ms 100.66.12.220 (100.66.12.220)  1.168 ms
 5  100.66.15.236 (100.66.15.236)  14.181 ms 100.66.15.64 (100.66.15.64)  39.701 ms 100.66.15.140 (100.66.15.140)  22.467 ms
 6  241.0.12.65 (241.0.12.65)  0.996 ms 241.0.12.79 (241.0.12.79)  0.556 ms 241.0.12.67 (241.0.12.67)  0.627 ms
 7  108.166.244.17 (108.166.244.17)  0.594 ms 108.166.244.21 (108.166.244.21)  0.616 ms 108.166.244.24 (108.166.244.24)  0.674 ms
 8  242.0.79.237 (242.0.79.237)  0.816 ms 242.0.79.101 (242.0.79.101)  1.316 ms 242.0.78.241 (242.0.78.241)  0.944 ms
 9  15.230.134.185 (15.230.134.185)  3.986 ms 15.230.134.173 (15.230.134.173)  3.933 ms 15.230.134.189 (15.230.134.189)  2.922 ms
10  52.95.1.222 (52.95.1.222)  2.676 ms 15.230.140.67 (15.230.140.67)  1.804 ms 15.230.39.184 (15.230.39.184)  2.738 ms
11  52.95.2.235 (52.95.2.235)  7.358 ms 52.95.1.117 (52.95.1.117)  1.512 ms 52.93.239.100 (52.93.239.100)  1.644 ms
12  100.92.53.112 (100.92.53.112)  12.776 ms 100.92.53.22 (100.92.53.22)  11.896 ms 100.92.53.74 (100.92.53.74)  11.895 ms
13  100.92.43.124 (100.92.43.124)  12.616 ms 100.92.43.130 (100.92.43.130)  12.868 ms 100.92.48.130 (100.92.48.130)  12.100 ms
14  100.92.48.67 (100.92.48.67)  14.002 ms 100.92.43.39 (100.92.43.39)  12.518 ms 100.92.43.45 (100.92.43.45)  15.877 ms
15  100.92.49.70 (100.92.49.70)  12.786 ms 100.92.49.94 (100.92.49.94)  12.240 ms 100.92.49.60 (100.92.49.60)  12.626 ms
16  100.92.49.131 (100.92.49.131)  12.888 ms 100.92.44.101 (100.92.44.101)  12.562 ms 100.92.49.129 (100.92.49.129)  14.113 ms
17  54.239.42.5 (54.239.42.5)  13.158 ms 52.93.133.68 (52.93.133.68)  12.578 ms 52.93.133.90 (52.93.133.90)  12.502 ms
18  100.91.163.100 (100.91.163.100)  11.956 ms 100.91.168.76 (100.91.168.76)  12.643 ms 100.91.163.10 (100.91.163.10)  12.799 ms
19  100.91.163.119 (100.91.163.119)  12.199 ms 100.91.163.19 (100.91.163.19)  11.842 ms 100.91.163.37 (100.91.163.37)  11.941 ms
20  100.91.159.40 (100.91.159.40)  12.178 ms 100.91.165.16 (100.91.165.16)  12.279 ms 100.91.164.46 (100.91.164.46)  12.474 ms
21  100.91.159.49 (100.91.159.49)  11.956 ms 100.91.160.81 (100.91.160.81)  12.194 ms 100.91.165.79 (100.91.165.79)  14.788 ms
22  100.91.176.221 (100.91.176.221)  15.160 ms 100.91.177.145 (100.91.177.145)  11.734 ms 100.91.177.99 (100.91.177.99)  11.720 ms
23  100.100.8.119 (100.100.8.119)  11.895 ms 100.100.8.73 (100.100.8.73)  12.408 ms 100.100.8.11 (100.100.8.11)  69.325 ms
24  100.100.88.8 (100.100.88.8)  12.484 ms 100.100.85.6 (100.100.85.6)  13.039 ms 100.100.73.72 (100.100.73.72)  12.237 ms
25  100.100.92.69 (100.100.92.69)  12.181 ms 100.100.73.197 (100.100.73.197)  84.143 ms 100.100.88.29 (100.100.88.29)  25.548 ms
26  100.100.4.10 (100.100.4.10)  12.197 ms 100.100.4.14 (100.100.4.14)  11.997 ms  11.983 ms
27  99.83.65.1 (99.83.65.1)  12.256 ms 100.95.7.80 (100.95.7.80)  13.173 ms 99.83.65.1 (99.83.65.1)  12.455 ms
28  100.100.4.12 (100.100.4.12)  12.525 ms 100.100.4.4 (100.100.4.4)  12.512 ms 100.100.4.12 (100.100.4.12)  11.831 ms
29  209.85.251.82 (209.85.251.82)  12.216 ms 99.83.65.1 (99.83.65.1)  12.245 ms 142.251.64.102 (142.251.64.102)  12.377 ms
30  108.170.246.66 (108.170.246.66)  12.585 ms * 108.170.246.2 (108.170.246.2)  20.854 ms
```








