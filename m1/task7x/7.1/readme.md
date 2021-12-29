# A Network
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

# B parser apache log

```
#!/bin/bash

log=$2

MostRequestFunc () {
echo "Read log.."
awk '{freq[$1]++} END{for (i in freq) print i, freq[i] }' $log | awk '{print $2, "requests from " $1}' | sort -n -r | head -1
}

CountRequestFunc () {
echo "Read log.."
awk '{freq[$1]++} END{for (i in freq) print i, freq[i] }' $log | awk '{print $2, "requests from " $1}' | sort -n -r
}

MostReqPageFunc () {
echo "Read log..."
awk '{freq[$7]++} END{for (i in freq) print i, freq[i] }' $log | sed '/favicon.ico/d'  |awk '{print $2, "requests from " $1}' | sort -n -r | head -1
}

404PageFunc () {
echo "Read log..."
cat $log | grep " 404 " | grep "http://example" | awk '{print $9, $11}'
}

MostReqTimeFunc () {
echo "Read log..."
awk '{print $4}' $log | sed 's/\[//g' | sed 's/...$//' | awk '{freq[$1]++} END{for (i in freq) print i, freq[i] }' | awk '{print $2, "requests from " $1}' | sort -n -r | head -1
}

RobotsFunc () {
awk '/http.*bot.*/{print $1}' $log | cat -n > temp_ip
grep -o 'http.*bot.*' $log | sed 's,)",,g' | cat -n > temp_bot
paste temp_ip temp_bot > temp
awk '{ if (length($0)<170) print $4,$2 }' temp | sort | uniq -c
rm temp*
}

    case "$1" in

        -mip) MostRequestFunc ;;
        -mp) MostReqPageFunc  ;;
        -rfip) CountRequestFunc ;;
        -404) 404PageFunc ;;
        -mrt) MostReqTimeFunc ;;
        -r) RobotsFunc ;;
        -h) cat ~/log/man ;;
        *) echo "You can use ./parser -h for see all options"
    esac


```

**Test**

```
ubuntu@ip-10-0-1-30:~/log$ ./parser
You can use ./parser -h for see all options
ubuntu@ip-10-0-1-30:~/log$ ./parser -h

Use: ./parcer [-key] (file.log)

 -mip - From which ip were the most requests?

 -mp - What is the most requested page?

 -rfip - How many requests were there from each ip?

 -404 -  What non-existent pages were clients referred to?

 -mrt -  What time did site get the most requests?

 -r - What search bots have accessed the site? (UA + IP)

```

```
ubuntu@ip-10-0-1-30:~/log$ ./parser -mip apache.log
Read log..
29 requests from 94.78.95.154
```

```
ubuntu@ip-10-0-1-30:~/log$ ./parser -mp apache.log
Read log...
33 requests from /ukhod-za-soboj/pokhudenie/furosemid-dlya-pokhudeniya.html
ubuntu@ip-10-0-1-30:~/log$
```

```
ubuntu@ip-10-0-1-30:~/log$ ./parser -rfip apache.log
Read log..
29 requests from 94.78.95.154
21 requests from 95.31.14.165
19 requests from 176.108.5.105
16 requests from 31.7.230.210
14 requests from 144.76.76.115
12 requests from 217.69.133.239
11 requests from 66.102.9.35
11 requests from 5.255.251.28
11 requests from 217.69.133.234
11 requests from 188.123.232.29
10 requests from 91.121.209.185
10 requests from 46.158.68.55
9 requests from 93.170.253.156
9 requests from 5.135.154.105
9 requests from 217.69.133.236
8 requests from 91.206.110.87
...
```

```
ubuntu@ip-10-0-1-30:~/log$ ./parser -404 apache.log
Read log...
404 "http://example.com/ehsteticheskaya-medicina/injekcii/biorevitalizaciya/preparaty-dlya-biorevitalizacii.html"
404 "http://example.com/ehsteticheskaya-medicina/injekcii/biorevitalizaciya/preparaty-dlya-biorevitalizacii.html"
404 "http://example.com/ukhod-za-soboj/molodost/omolozhenie-lica-posle-50-let.html"
404 "http://example.com/ukhod-za-soboj/molodost/omolozhenie-lica-posle-50-let.html"
404 "http://example.com/ehsteticheskaya-medicina/injekcii/oblasti-lica-dlya-primeneniya-kozhnykh-fi.html"
404 "http://example.com/ehsteticheskaya-medicina/injekcii/oblasti-lica-dlya-primeneniya-kozhnykh-fi.html"
404 "http://example.com/ehsteticheskaya-medicina/injekcii/oblasti-lica-dlya-primeneniya-kozhnykh-fi.html"
404 "http://example.com/ukhod-za-soboj/bolezni-kozhi/sukhaya-mozol-na-palce-nogi.html"
404 "http://example.com/ukhod-za-soboj/bolezni-kozhi/sukhaya-mozol-na-palce-nogi.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/menyu-razdelnogo-pitaniya-dlya-pokhuden.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/dieta-maggi-tvorozhnyjj-variant.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/dieta-maggi-tvorozhnyjj-variant.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/dieta-maggi-tvorozhnyjj-variant.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/dieta-maggi-tvorozhnyjj-variant.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/skandinavskaya-dieta-dlya-pokhudeniya.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/dieta-grechnevaya-s-kefirom.html"
404 "http://example.com/ukhod-za-soboj/pokhudenie/dieti/dieta-maggi-tvorozhnyjj-variant.html"
```

I chosed per minute interval.
```
ubuntu@ip-10-0-1-30:~/log$ ./parser -mrt apache.log
Read log...
18 requests from 25/Apr/2017:11:36
```


```
ubuntu@ip-10-0-1-30:~/log$ ./parser -r apache.log
      1 http://ahrefs.com/robot/ 164.132.161.40
      1 http://ahrefs.com/robot/ 164.132.161.63
      1 http://ahrefs.com/robot/ 164.132.161.85
      1 http://ahrefs.com/robot/ 217.182.132.183
      8 http://go.mail.ru/help/robots 217.69.133.234
      6 http://go.mail.ru/help/robots 217.69.133.235
      7 http://go.mail.ru/help/robots 217.69.133.236
      3 http://go.mail.ru/help/robots 217.69.133.237
      4 http://go.mail.ru/help/robots 217.69.133.238
     12 http://go.mail.ru/help/robots 217.69.133.239
      6 http://go.mail.ru/help/robots 217.69.133.240
      6 http://go.mail.ru/help/robots 217.69.133.70
      6 http://go.mail.ru/help/robots 217.69.134.12
      2 http://go.mail.ru/help/robots 217.69.134.13
      2 http://go.mail.ru/help/robots 217.69.134.14
      1 http://go.mail.ru/help/robots 217.69.134.15
      5 http://go.mail.ru/help/robots 217.69.134.29
      1 http://go.mail.ru/help/robots 217.69.134.30
      1 http://go.mail.ru/help/robots 217.69.134.39
     14 http://mj12bot.com/ 144.76.76.115
      1 http://search.msn.com/msnbot.htm 40.77.167.19
      1 http://www.bing.com/bingbot.htm 136.243.34.71
      2 http://www.bing.com/bingbot.htm 207.46.13.109
      1 http://www.bing.com/bingbot.htm 207.46.13.128
      4 http://www.bing.com/bingbot.htm 207.46.13.3
      2 http://www.bing.com/bingbot.htm 40.77.167.19
      1 http://www.google.com/bot.html 66.249.66.194
      5 http://www.google.com/bot.html 66.249.66.199
      6 http://www.google.com/bot.html 66.249.66.204
     11 http://yandex.com/bots 5.255.251.28

```


# C Backup

**Script**
```

#!/bin/bash

if [ -n "$1" ] && [ -n "$2" ];
then
rsync -azvh --log-file=/home/ubuntu/backup/backup.log $1 $2 --delete &> /dev/null
else
rsync -azvh --log-file=/home/ubuntu/backup/backup.log /home/ubuntu/backup/data /home/ubuntu/backup/bdir --delete &>  /dev/null
fi

```


**Check cron**

```
ubuntu@ip-10-0-1-30:~/backup$ cat /var/log/syslog

Dec 29 19:45:01 ip-10-0-1-30 CRON[10191]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:46:01 ip-10-0-1-30 CRON[10200]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:47:01 ip-10-0-1-30 CRON[10210]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:48:01 ip-10-0-1-30 CRON[10223]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:49:01 ip-10-0-1-30 CRON[10237]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:50:01 ip-10-0-1-30 CRON[10246]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:51:01 ip-10-0-1-30 CRON[10254]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)
Dec 29 19:52:01 ip-10-0-1-30 CRON[10261]: (ubuntu) CMD (/home/ubuntu/backup/backup.sh)

```

**Test script**
```
ubuntu@ip-10-0-1-30:~/backup$ ./backup.sh
ubuntu@ip-10-0-1-30:~/backup$ ./backup.sh /home/ubuntu/backup/data /home/ubuntu/backup/bdir
ubuntu@ip-10-0-1-30:~/backup$ cat backup.log
2021/12/29 19:55:59 [10303] building file list
2021/12/29 19:55:59 [10303] sent 171 bytes  received 19 bytes  380.00 bytes/sec
2021/12/29 19:55:59 [10303] total size is 0  speedup is 0.00
2021/12/29 19:56:01 [10309] building file list
2021/12/29 19:56:01 [10309] sent 171 bytes  received 19 bytes  380.00 bytes/sec
2021/12/29 19:56:01 [10309] total size is 0  speedup is 0.00
```

```
ubuntu@ip-10-0-1-30:~/backup$ cat backup.log
2021/12/29 19:45:01 [10193] building file list
2021/12/29 19:45:01 [10193] created directory $
2021/12/29 19:45:01 [10193] cd+++++++++ bdir/
2021/12/29 19:45:01 [10193] >f+++++++++ bdir/file0
2021/12/29 19:45:01 [10193] cd+++++++++ bdir/dir1/
2021/12/29 19:45:01 [10193] >f+++++++++ bdir/dir1/file1
2021/12/29 19:45:01 [10193] cd+++++++++ bdir/dir2/
2021/12/29 19:45:01 [10193] >f+++++++++ bdir/dir2/file2
2021/12/29 19:45:01 [10193] cd+++++++++ bdir/dir3/
2021/12/29 19:45:01 [10193] cd+++++++++ data/
2021/12/29 19:45:01 [10193] >f+++++++++ data/file0
2021/12/29 19:45:01 [10193] cd+++++++++ data/dir1/
2021/12/29 19:45:01 [10193] >f+++++++++ data/dir1/file1
2021/12/29 19:45:01 [10193] cd+++++++++ data/dir2/
2021/12/29 19:45:01 [10193] >f+++++++++ data/dir2/file2
2021/12/29 19:45:01 [10193] cd+++++++++ data/dir3/
2021/12/29 19:45:01 [10193] sent 595 bytes  received 186 bytes  1.56K bytes/sec
2021/12/29 19:45:01 [10193] total size is 0  speedup is 0.00
2021/12/29 19:46:01 [10202] building file list
2021/12/29 19:46:01 [10202] sent 351 bytes  received 20 bytes  742.00 bytes/sec
2021/12/29 19:46:01 [10202] total size is 0  speedup is 0.00
2021/12/29 19:47:01 [10212] building file list
2021/12/29 19:47:01 [10212] sent 351 bytes  received 20 bytes  742.00 bytes/sec
2021/12/29 19:47:01 [10212] total size is 0  speedup is 0.00
2021/12/29 19:48:01 [10225] building file list
2021/12/29 19:48:01 [10225] sent 351 bytes  received 20 bytes  742.00 bytes/sec
2021/12/29 19:48:01 [10225] total size is 0  speedup is 0.00


ubuntu@ip-10-0-1-30:~/backup$ ls -R data/
data/:
dir1  dir2  dir3  file0

data/dir1:
file1

data/dir2:
file2

data/dir3:
ubuntu@ip-10-0-1-30:~/backup$ rm -r data/dir1
ubuntu@ip-10-0-1-30:~/backup$ ls -R data/
data/:
dir2  dir3  file0

data/dir2:
file2

data/dir3:

ubuntu@ip-10-0-1-30:~/backup$ cat backup.log
2021/12/29 19:49:01 [10239] building file list
2021/12/29 19:49:01 [10239] *deleting   data/dir1/file1
2021/12/29 19:49:01 [10239] *deleting   data/dir1/
2021/12/29 19:49:01 [10239] .d..t...... data/
2021/12/29 19:49:01 [10239] sent 321 bytes  received 55 bytes  752.00 bytes/sec
2021/12/29 19:49:01 [10239] total size is 0  speedup is 0.00

```





