- 1

```
ubuntu@ip-10-0-1-30:~$ my-nmap/./mynmap
You can use mynmap -h for see all options
ubuntu@ip-10-0-1-30:~$ my-nmap/./mynmap -h
ubuntu@ip-10-0-1-30:~$ nano my-nmap/./mynmap
ubuntu@ip-10-0-1-30:~$ my-nmap/./mynmap
You can use mynmap -h for see all options
ubuntu@ip-10-0-1-30:~$ my-nmap/./mynmap -h

--all - displays the IP addresses and symbolic names of all hosts in the current subnet.

--target -  key displays a list of open system TCP ports.

-h - manual

ubuntu@ip-10-0-1-30:~$ my-nmap/./mynmap --all
Scaning network...
H1(10.0.5.34)
H2(10.0.5.145)
H3(10.0.5.226)
ubuntu@ip-10-0-1-30:~$ my-nmap/./mynmap --target
Scaning port...
127.0.0.1:2604
127.0.0.1:2605
0.0.0.0:179
0.0.0.0:22
127.0.0.1:6010
127.0.0.1:2601
:::179
:::22
::1:6010
ubuntu@ip-10-0-1-30:~$
```

*script*
```
#!/bin/bash


if ! dpkg -l | grep nmap &> /dev/null
        then
        echo "NMAP not found"
        echo "Install NMAP..."
        sudo apt install nmap -y &> /dev/null

fi




allFunc () {
echo "Scaning network..."
nmap -sL 10.0.5.1/24 | grep "(" > ~/my-nmap/nmapscan.temp
awk '{print $5 $6}' ~/my-nmap/nmapscan.temp | grep '^[A-Za-z0-9].('
}


targetFunc () {
echo "Scaning port..."
netstat -tnl > ~/my-nmap/portscan.temp
awk '{print $4}' ~/my-nmap/portscan.temp | grep ^[0-9:]
}


case $1 in

        --all) allFunc ;;
        --target)  targetFunc ;;
        -h) cat ~/my-nmap/man ;;
        *) echo "You can use mynmap -h for see all options"
exit ;;
esac
```

