# Task 5.1 #

##  Part 1 ##

- 1 
```
ubuntu@ip-172-31-20-252:~$ sudo -i
// first connect to AWS instanse under user "ubuntu"
```
- 2 Changed password for root and was finding changed file
```
root@ip-172-31-20-252:/etc# passwd
New password:
Retype new password:
passwd: password updated successfully
root@ip-172-31-20-252:/etc# find -mmin -1
.
./shadow

```

- 3 (I dont anderstadnd all context of this exersize.)
```
ubuntu@ip-172-31-20-252:~$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-network:x:100:102:systemd Network Management,,,:/run/systemd:/usr/sbin/nologin
systemd-resolve:x:101:103:systemd Resolver,,,:/run/systemd:/usr/sbin/nologin
systemd-timesync:x:102:104:systemd Time Synchronization,,,:/run/systemd:/usr/sbin/nologin
messagebus:x:103:106::/nonexistent:/usr/sbin/nologin
syslog:x:104:110::/home/syslog:/usr/sbin/nologin
_apt:x:105:65534::/nonexistent:/usr/sbin/nologin
tss:x:106:111:TPM software stack,,,:/var/lib/tpm:/bin/false
uuidd:x:107:112::/run/uuidd:/usr/sbin/nologin
tcpdump:x:108:113::/nonexistent:/usr/sbin/nologin
sshd:x:109:65534::/run/sshd:/usr/sbin/nologin
landscape:x:110:115::/var/lib/landscape:/usr/sbin/nologin
pollinate:x:111:1::/var/cache/pollinate:/bin/false
ec2-instance-connect:x:112:65534::/nonexistent:/usr/sbin/nologin
systemd-coredump:x:999:999:systemd Core Dumper:/:/usr/sbin/nologin
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
lxd:x:998:100::/var/snap/lxd/common/lxd:/bin/false
mysql:x:113:119:MySQL Server,,,:/nonexistent:/bin/false
```
- 4
```
root@ip-172-31-20-252:/etc# chfn
Changing the user information for root
Enter the new value, or press ENTER for the default
        Full Name [root]: Igor S
        Room Number []: 1
        Work Phone []: +380994977156
        Home Phone []:
        Other []:
root@ip-172-31-20-252:/etc# chfn
Changing the user information for root
Enter the new value, or press ENTER for the default
        Full Name [Igor S]:
        Room Number [1]:
        Work Phone [+380994977156]:
        Home Phone []:
        Other []:
```
- 5

>--help - describes funktionality some comand in short form.

>man - shows full information about some comad

exemple:
```
root@ip-172-31-20-252:/etc# sudo --help
sudo - execute a command as another user

usage: sudo -h | -K | -k | -V
usage: sudo -v [-AknS] [-g group] [-h host] [-p prompt] [-u user]
usage: sudo -l [-AknS] [-g group] [-h host] [-p prompt] [-U user] [-u user] [command]
usage: sudo [-AbEHknPS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p prompt] [-T timeout] [-u user] [VAR=value] [-i|-s] [<command>]
usage: sudo -e [-AknS] [-r role] [-t type] [-C num] [-g group] [-h host] [-p prompt] [-T timeout] [-u user] file ...

Options:
  -A, --askpass                 use a helper program for password prompting
  -b, --background              run command in the background
  -B, --bell                    ring bell when prompting
  -C, --close-from=num          close all file descriptors >= num
  -E, --preserve-env            preserve user environment when running command
      --preserve-env=list       preserve specific environment variables
  -e, --edit                    edit files instead of running a command
  -g, --group=group             run command as the specified group name or ID
  -H, --set-home                set HOME variable to target user's home dir
  -h, --help                    display help message and exit
  -h, --host=host               run command on host (if supported by plugin)
  -i, --login                   run login shell as the target user; a command may also be specified
  -K, --remove-timestamp        remove timestamp file completely
  -k, --reset-timestamp         invalidate timestamp file
  -l, --list                    list user's privileges or check a specific command; use twice for longer format
  -n, --non-interactive         non-interactive mode, no prompts are used
  -P, --preserve-groups         preserve group vector instead of setting to target's
  -p, --prompt=prompt           use the specified password prompt
  -r, --role=role               create SELinux security context with specified role
  -S, --stdin                   read password from standard input
  -s, --shell                   run shell as the target user; a command may also be specified
  -t, --type=type               create SELinux security context with specified type
  -T, --command-timeout=timeout terminate command after the specified time limit
  -U, --other-user=user         in list mode, display privileges for user
  -u, --user=user               run command (or edit file) as specified user name or ID
  -V, --version                 display version information and exit
  -v, --validate                update user's timestamp without running a command
  --                            stop processing command line arguments

```


**It is about 1/10 from full list:**
```
root@ip-172-31-20-252:/etc# man sudo
SUDO(8)                                                                                BSD System Manager's Manual                                                                               SUDO(8)

NAME
     sudo, sudoedit — execute a command as another user

SYNOPSIS
     sudo -h | -K | -k | -V
     sudo -v [-ABknS] [-g group] [-h host] [-p prompt] [-u user]
     sudo -l [-ABknS] [-g group] [-h host] [-p prompt] [-U user] [-u user] [command]
     sudo [-ABbEHnPS] [-C num] [-g group] [-h host] [-p prompt] [-r role] [-t type] [-T timeout] [-u user] [VAR=value] [-i | -s] [command]
     sudoedit [-ABknS] [-C num] [-g group] [-h host] [-p prompt] [-T timeout] [-u user] file ...

DESCRIPTION
     sudo allows a permitted user to execute a command as the superuser or another user, as specified by the security policy.  The invoking user's real (not effective) user-ID is used to determine the
     user name with which to query the security policy.

```

- 6
"Less" and "more" are comands for comfortable read big text files. "Less" is more new and more comfortable comand.

```
ubuntu@ip-172-31-20-252:/$ find /home .bash -print
/home
/home/ubuntu
/home/ubuntu/.Xauthority
/home/ubuntu/.bashrc
/home/ubuntu/DevOnline_rds.sql
/home/ubuntu/.cache
/home/ubuntu/.cache/motd.legal-displayed
/home/ubuntu/.bash_history
/home/ubuntu/.sudo_as_admin_successful
/home/ubuntu/.ssh
/home/ubuntu/.ssh/authorized_keys
/home/ubuntu/.aws
/home/ubuntu/.aws/credentials
/home/ubuntu/.aws/config
/home/ubuntu/.bash_logout
/home/ubuntu/.profile
/home/ubuntu/DevOnline.sql
find: ‘.bash’: No such file or directory
ubuntu@ip-172-31-20-252:/$ more /home/ubuntu/DevOnline.sql
-- MySQL dump 10.13  Distrib 8.0.27, for Linux (x86_64)
--
-- Host: localhost    Database: DevOnline
-- ------------------------------------------------------
-- Server version       8.0.27-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `lessons`
--

```

"Less" shows file in separate "window" and you can move file as down as up.

- 8

> ls -1 -a -F -R /home

      -1     list one file per line. 
      -a     view all files in all dir.
      -F     append indicator
      -R     list subdirectories recursively

```
ubuntu@ip-172-31-20-252:/$ ls -1 -a -F -R /home
/home:
./
../
ubuntu/

/home/ubuntu:
./
../
.Xauthority
.aws/
.bash_history
.bash_logout
.bashrc
.cache/
.profile
.ssh/
.sudo_as_admin_successful
DevOnline.sql
DevOnline_rds.sql

/home/ubuntu/.aws:
./
../
config
credentials

/home/ubuntu/.cache:
./
../
motd.legal-displayed

/home/ubuntu/.ssh:
./
../
authorized_keys
```

- without "-a"
```
ubuntu@ip-172-31-20-252:/$ ls -1 -F -R /home
/home:
ubuntu/

/home/ubuntu:
DevOnline.sql
DevOnline_rds.sql
```
##  Part 2 ##

- 1

>-f        Prints the full path prefix for each file.

>-P        List  only  those files that match the wild-card pattern.

>--prune   Exclude dir without finded diles.

>-L        Max display depth of the directory tree.


```
ubuntu@ip-172-31-20-252:/$ tree -f -P '*log*' --prune -L 3 /var
/var
├── /var/lib
│   ├── /var/lib/sgml-base
│   │   ├── /var/lib/sgml-base/supercatalog
│   │   └── /var/lib/sgml-base/supercatalog.old
│   └── /var/lib/xml-core
│       └── /var/lib/xml-core/catalog
└── /var/log
    ├── /var/log/alternatives.log
    ├── /var/log/alternatives.log.1
    ├── /var/log/apt
    │   ├── /var/log/apt/eipp.log.xz
    │   ├── /var/log/apt/history.log
    │   ├── /var/log/apt/history.log.1.gz
    │   ├── /var/log/apt/term.log
    │   └── /var/log/apt/term.log.1.gz
    ├── /var/log/auth.log
    ├── /var/log/cloud-init-output.log
    ├── /var/log/cloud-init.log
    ├── /var/log/dpkg.log
    ├── /var/log/dpkg.log.1
    ├── /var/log/fontconfig.log
    ├── /var/log/kern.log
    ├── /var/log/landscape
    │   └── /var/log/landscape/sysinfo.log
    ├── /var/log/lastlog
    ├── /var/log/mysql
    │   ├── /var/log/mysql/error.log
    │   ├── /var/log/mysql/error.log.1.gz
    │   ├── /var/log/mysql/error.log.2.gz
    │   └── /var/log/mysql/error.log.3.gz
    ├── /var/log/syslog
    ├── /var/log/syslog.1
    ├── /var/log/syslog.2.gz
    ├── /var/log/syslog.3.gz
    ├── /var/log/ubuntu-advantage.log
    ├── /var/log/ubuntu-advantage.log.1
    └── /var/log/unattended-upgrades
        ├── /var/log/unattended-upgrades/unattended-upgrades-dpkg.log
        ├── /var/log/unattended-upgrades/unattended-upgrades-dpkg.log.1.gz
        ├── /var/log/unattended-upgrades/unattended-upgrades-shutdown.log
        ├── /var/log/unattended-upgrades/unattended-upgrades-shutdown.log.1.gz
        ├── /var/log/unattended-upgrades/unattended-upgrades.log
        └── /var/log/unattended-upgrades/unattended-upgrades.log.1.gz

8 directories, 35 files
```
- 2

"file" — determine file type


```
ubuntu@ip-172-31-20-252:/boot$ file System.map-5.11.0-1020-aws
System.map-5.11.0-1020-aws: regular file, no read permission
ubuntu@ip-172-31-20-252:/boot$ file initrd.img
initrd.img: symbolic link to initrd.img-5.11.0-1021-aws

```
- 3

You can use cd /home from any dir, for move to home dir.

- 4

It was in part1 ex8.

- 5

create a subdirectory in the home directory;
```
ubuntu@ip-172-31-20-252:/home$ mkdir ubuntu/timedir
ubuntu@ip-172-31-20-252:~$ ls
DevOnline.sql  DevOnline_rds.sql  timedir
```
in this subdirectory create a file containing information about directories
located in the root directory

 view the created file;


```
ubuntu@ip-172-31-20-252:/$ tree -d >  /home/ubuntu/timedir/DirTree
ubuntu@ip-172-31-20-252:/$ less /home/ubuntu/timedir/DirTree

.
├── bin -> usr/bin
├── boot
│   └── grub
│       ├── fonts
│       └── i386-pc
├── dev
│   ├── block
│   ├── char
│   ├── cpu
│   │   └── 0
│   ├── disk
│   │   ├── by-label
│   │   ├── by-partuuid
│   │   └── by-uuid
│   ├── dma_heap
│   ├── fd -> /proc/self/fd
│   ├── hugepages
│   ├── input
│   │   └── by-path
│   ├── lightnvm
│   ├── mapper
│   ├── mqueue
│   ├── net
│   ├── pts
│   ├── shm
│   │   └── eic-hostkey-WxIe8M8S [error opening dir]
│   ├── vfio
│   └── xen
├── etc
│   ├── ImageMagick-6
│   ├── NetworkManager
│   │   └── dispatcher.d
│   ├── PackageKit

...
```

copy the created file to your home directory using relative and absolute
addressing.
```
ubuntu@ip-172-31-20-252:/$ cp /home/ubuntu/timedir/DirTree /home/ubuntu/
ubuntu@ip-172-31-20-252:/$ cp ~/timedir/DirTree ~/DirTreeRel
ubuntu@ip-172-31-20-252:/$ tree ~/
/home/ubuntu/
├── DevOnline.sql
├── DevOnline_rds.sql
├── DirTree
├── DirTreeRel
└── timedir
    └── DirTree
```

delete the previously created subdirectory with the file requesting removal;
```
ubuntu@ip-172-31-20-252:/$ rm -R ~/timedir
ubuntu@ip-172-31-20-252:/$ tree ~/
/home/ubuntu/
├── DevOnline.sql
├── DevOnline_rds.sql
├── DirTree
└── DirTreeRel
```
delete the file copied to the home directory.
```
ubuntu@ip-172-31-20-252:/$ rm ~/Dir*
ubuntu@ip-172-31-20-252:/$ tree ~/
/home/ubuntu/
├── DevOnline.sql
└── DevOnline_rds.sql
```

- 6 Perform the following sequence of operations:
create a subdirectory test in the home directory;
```
ubuntu@ip-172-31-20-252:/$ mkdir ~/test
```


copy the .bash_history file to this directory while changing its name to
labwork2;
```
ubuntu@ip-172-31-20-252:/$ cp ~/.bash_history ~/test/labwork2
ubuntu@ip-172-31-20-252:/$ tree ~/
/home/ubuntu/
├── DevOnline.sql
├── DevOnline_rds.sql
└── test
    └── labwork2

```

create a hard and soft link to the labwork2 file in the test subdirectory;
```
ubuntu@ip-172-31-20-252:~/test$ ln labwork2 hard_labwork2
ubuntu@ip-172-31-20-252:~/test$ ls -ilh
total 8.0K
256748 -rw------- 2 ubuntu ubuntu 1.2K Dec  2 15:10 hard_labwork2
256748 -rw------- 2 ubuntu ubuntu 1.2K Dec  2 15:10 labwork2

ubuntu@ip-172-31-20-252:~/test$ ln -s labwork2 sym_labwork2
ubuntu@ip-172-31-20-252:~/test$ ls -ilh
total 8.0K
256748 -rw------- 2 ubuntu ubuntu 1.2K Dec  2 15:10 hard_labwork2
256748 -rw------- 2 ubuntu ubuntu 1.2K Dec  2 15:10 labwork2
256174 lrwxrwxrwx 1 ubuntu ubuntu    8 Dec  3 14:04 sym_labwork2 -> labwork2
```

how to define soft and hard link, what do these
concepts;
```
Hard Link can be determined by same inod number in different file system objects number in output comand ls -il.
Soft link marked like "l" before permissions, example "lrwxrwxrwx".
```

change the data by opening a symbolic link. What changes will happen and
why
```
There chenges file where refer symlink becouse simlimk it only link - special file, not target file.
```

rename the hard link file to hard_lnk_labwork2;
```
ubuntu@ip-172-31-20-252:~/test$ mv hard_labwork2 hard_lnk_labwork2
ubuntu@ip-172-31-20-252:~/test$ ls -l
total 8
-rw------- 2 ubuntu ubuntu 1203 Dec  3 14:34 hard_lnk_labwork2
-rw------- 2 ubuntu ubuntu 1203 Dec  3 14:34 labwork2
lrwxrwxrwx 1 ubuntu ubuntu    8 Dec  3 14:04 sym_labwork2 -> labwork2
```

rename the soft link file to symb_lnk_labwork2 file;
```
ubuntu@ip-172-31-20-252:~/test$ mv sym_labwork2 symb_lnk_labwork2
ubuntu@ip-172-31-20-252:~/test$ ls -li
total 8
256748 -rw------- 2 ubuntu ubuntu 1203 Dec  3 14:34 hard_lnk_labwork2
256748 -rw------- 2 ubuntu ubuntu 1203 Dec  3 14:34 labwork2
256174 lrwxrwxrwx 1 ubuntu ubuntu    8 Dec  3 14:04 symb_lnk_labwork2 -> labwork2
```

then delete the labwork2. What changes have occurred and why?
```
ubuntu@ip-172-31-20-252:~/test$ rm labwork2
ubuntu@ip-172-31-20-252:~/test$ ls -li
total 4
256748 -rw------- 1 ubuntu ubuntu 1203 Dec  3 14:34 hard_lnk_labwork2
256174 lrwxrwxrwx 1 ubuntu ubuntu    8 Dec  3 14:04 symb_lnk_labwork2 -> labwork2 //flagged red color

File labwork2 is continue existing becouse it have one inode with additional name (hardlink).
Soft link is not wokr becouse target file doesn't exist.
```
- 7
Using the locate utility, find all files that contain the squid and traceroute
sequence.
```
ubuntu@ip-172-31-20-252:/$ locate -i -A squid
/usr/lib/python3/dist-packages/sos/report/plugins/__pycache__/squid.cpython-38.pyc
/usr/lib/python3/dist-packages/sos/report/plugins/squid.py
/usr/share/vim/vim81/syntax/squid.vim
ubuntu@ip-172-31-20-252:/$ locate -i -A traceroute
/etc/alternatives/traceroute6
/etc/alternatives/traceroute6.8.gz
/usr/bin/traceroute6
/usr/bin/traceroute6.iputils
/usr/share/man/man8/traceroute6.8.gz
/usr/share/man/man8/traceroute6.iputils.8.gz
/usr/src/linux-aws-5.11-headers-5.11.0-1020/tools/testing/selftests/net/traceroute.sh
/usr/src/linux-aws-5.11-headers-5.11.0-1021/tools/testing/selftests/net/traceroute.sh
/var/lib/dpkg/alternatives/traceroute6
```
- 8

Determine which partitions are mounted in the system, as well as the types of
these partitions.
```
ubuntu@ip-172-31-20-252:/dev$ df
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/root        8065444 2893312   5155748  36% /
devtmpfs          489496       0    489496   0% /dev
tmpfs             496104       0    496104   0% /dev/shm
tmpfs              99224     828     98396   1% /run
tmpfs               5120       0      5120   0% /run/lock
tmpfs             496104       0    496104   0% /sys/fs/cgroup
/dev/loop1         56832   56832         0 100% /snap/core18/2128
/dev/loop0         25600   25600         0 100% /snap/amazon-ssm-agent/4046
/dev/loop2         56832   56832         0 100% /snap/core18/2253
/dev/loop3         63360   63360         0 100% /snap/core20/1169
/dev/loop4         63360   63360         0 100% /snap/core20/1242
/dev/loop5         68864   68864         0 100% /snap/lxd/21545
/dev/loop6         68864   68864         0 100% /snap/lxd/21835
/dev/loop7         33280   33280         0 100% /snap/snapd/13640
/dev/loop8         43264   43264         0 100% /snap/snapd/14066
tmpfs              99220       0     99220   0% /run/user/1000

```
or
```
ubuntu@ip-172-31-20-252:/dev$ sudo fdisk -l 
//not all partition

Disk /dev/xvda: 8 GiB, 8589934592 bytes, 16777216 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x3fa6b62f

Device     Boot Start      End  Sectors Size Id Type
/dev/xvda1 *     2048 16777182 16775135   8G 83 Linux


Disk /dev/loop8: 42.18 MiB, 44220416 bytes, 86368 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes

```

- 9
Count the number of lines containing a given sequence of characters in a given
file
```
ubuntu@ip-172-31-20-252:~/test$ grep -c Dev hard_lnk_labwork2
12
ubuntu@ip-172-31-20-252:~/test$ grep Dev hard_lnk_labwork2
sudo mysqldump DevOnline
sudo mysqldump DevOnline > /home/backupDB/DevOnline.sql
sudo mysqldump DevOnline > /home/ubuntu/DevOnline.sql
sudo mysql DevOnline < /home/ubuntu/DevOnline.sql
aws s3 mv /home/ubuntu/DevOnline.sql
aws s3 mv /home/ubuntu/DevOnline.sql dbdevonlinebackup
aws s3 mv /home/ubuntu/DevOnline.sql arn:aws:s3:::dbdevonlinebackup
aws s3 cp /home/ubuntu/DevOnline.sql arn:aws:s3:::dbdevonlinebackup
aws s3 сз /home/ubuntu/DevOnline.sql dbdevonlinebackup
aws s3 cp /home/ubuntu/DevOnline.sql dbdevonlinebackup
aws s3 cp /home/ubuntu/DevOnline.sql /dbdevonlinebackup
aws s3 cp /home/ubuntu/DevOnline.sql s3://dbdevonlinebackup/
```
- 10

Using the find command, find all files in the /etc directory containing the
host character sequence

```
ubuntu@ip-172-31-20-252:~/test$ find /etc -type f -exec grep 'host' {} \;
/etc/e2scrub.conf:# sender=e2scrub@host.domain.name
grep: /etc/iscsi/iscsid.conf: Permission denied
grep: /etc/iscsi/initiatorname.iscsi: Permission denied
/etc/perl/Net/libnet.cfg:       nntp_hosts => [ qw {} ],
/etc/perl/Net/libnet.cfg:       snpp_hosts => [ qw {} ],
/etc/perl/Net/libnet.cfg:       pop3_hosts => [ qw {} ],
/etc/perl/Net/libnet.cfg:       smtp_hosts => [ qw {} ],
/etc/perl/Net/libnet.cfg:       ph_hosts => [ qw {} ],
/etc/perl/Net/libnet.cfg:       daytime_hosts => [ qw {} ],
/etc/perl/Net/libnet.cfg:       time_hosts => [ qw {} ],
/etc/hosts:127.0.0.1 localhost
/etc/hosts:# The following lines are desirable for IPv6 capable hosts
/etc/hosts:::1 ip6-localhost ip6-loopback
/etc/hosts:ff02::3 ip6-allhosts


and more...
```

- 11

List all objects in /etc that contain the ss character sequence. How can I
duplicate a similar command using a bunch of grep?

```
ubuntu@ip-172-31-20-252:~/test$ ls /etc -R | grep "ss"
gss
issue
issue.net
nsswitch.conf
passwd
passwd-
ssh
ssl
Xsession
Xsession.d
Xsession.options
/etc/X11/Xsession.d:
20x11-common_process-args
40x11-common_xsessionrc
90x11-common_ssh-agent

and more...
```

- 12

Organize a screen-by-screen print of the contents of the /etc directory. Hint:
You must use stream redirection operations.

```
ls /etc -R | less

/etc:
ImageMagick-6
NetworkManager
PackageKit
X11
acpi
adduser.conf
alternatives
apparmor
apparmor.d
apport
apt
at.deny
bash.bashrc


and more...
```

- 13

What are the types of devices and how to determine the type of device? Give
examples.

Use comand file or ls (we gate almost same result)
```
ubuntu@ip-172-31-20-252:/dev$ file -i *
some results:
xvda:            inode/blockdevice; charset=binary //disk
tty:             inode/chardevice; charset=binary //serial port
psaux:           inode/chardevice; charset=binary // PS/2 mouse connection (mice, keyboards).
```

- 14

How to determine the type of file in the system, what types of files are there?

```
ubuntu@ip-172-31-20-252:~$  file -i /dev/*
/dev/autofs:          inode/chardevice; charset=binary
/dev/block:           inode/directory; charset=binary
/dev/btrfs-control:   inode/chardevice; charset=binary
/dev/char:            inode/directory; charset=binary
/dev/console:         inode/chardevice; charset=binary
/dev/core:            inode/symlink; charset=binary
/dev/cpu:             inode/directory; charset=binary
/dev/cpu_dma_latency: inode/chardevice; charset=binary
/dev/cuse:            inode/chardevice; charset=binary
/dev/disk:            inode/directory; charset=binary
/dev/dma_heap:        inode/directory; charset=binary
/dev/ecryptfs:        inode/chardevice; charset=binary
/dev/fd:              inode/symlink; charset=binary

```

- 15

List the first 5 directory files that were recently accessed in the /etc directory.

```
ubuntu@ip-172-31-20-252:~$ ls /etc -u -l | head -n 5
total 856
drwxr-xr-x 2 root root       4096 Dec  5 16:25 ImageMagick-6
drwxr-xr-x 3 root root       4096 Dec  5 16:25 NetworkManager
drwxr-xr-x 2 root root       4096 Dec  5 16:25 PackageKit
drwxr-xr-x 7 root root       4096 Dec  5 16:25 X11

```

# Task 5.2 #
- 1

Analyze the structure of the /etc/passwd and /etc/group file, what fields are
present in it, what users exist on the system? Specify several pseudo-users, how
to define them?

less /etc/passwd

```
jhon:x:1001:1001:,,,:/home/jhon:/bin/bash
[--] - [--] [--] [--] [-------] [--------]
|    |   |    |     |         |        |
|    |   |    |     |         |        +-> 7. Login shell
|    |   |    |     |         +----------> 6. Home directory
|    |   |    |     +--------------------> 5. GECOS
|    |   |    +--------------------------> 4. GID
|    |   +-------------------------------> 3. UID
|    +-----------------------------------> 2. Password
+----------------------------------------> 1. Username

```
nologin - pseudo-user, users for system srvices.
```
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin

```

less /etc/group

```
adm:x:4:syslog,ubuntu
[-] -[-] [------------] 
 |  | |         |+--------> 4. group members
 |  | |+------------------> 3. GID
 |  |+--------------------> 2. password group
 |+-----------------------> 1. UID

```
 - 2
 What are the uid ranges? What is UID? How to define it?

UID -  User IDentifier 
Ranges:
0 - always root user
from 0 to 500 or 1000 (depending on distributions) - reserve for system users.
from 501 or 1001 - new users creating through useradd coomad.

It described in /etc/passwd file.

- 3

What is GID? How to define it?

GID - Group IDentifier

It described in /etc/group file.

- 4 How to determine belonging of user to the specific group?
```
ubuntu@ip-172-31-20-252:/$ grep ubuntu etc/group
adm:x:4:syslog,ubuntu
dialout:x:20:ubuntu
cdrom:x:24:ubuntu
floppy:x:25:ubuntu
sudo:x:27:ubuntu
audio:x:29:ubuntu
dip:x:30:ubuntu
video:x:44:ubuntu
plugdev:x:46:ubuntu
netdev:x:117:ubuntu
lxd:x:118:ubuntu
ubuntu:x:1000:
```
or
```
groups ubuntu | grep adm
ubuntu : ubuntu adm dialout cdrom floppy sudo audio dip video plugdev netdev lxd

```
 - 5

What are the commands for adding a user to the system? What are the basic
parameters required to create a user?

adduser - adding user to system. For adding new user we have to describe 2 parameters: name and password. 
Or  useradd - more sample comand, creating users without passwords.

It is optional:
    Full Name []:
    Room Number []:
    Work Phone []:
    Home Phone []:
    Other []:

 ```
 ubuntu@ip-172-31-20-252:/$ sudo adduser jhon
Adding user `jhon' ...
Adding new group `jhon' (1001) ...
Adding new user `jhon' (1001) with group `jhon' ...
Creating home directory `/home/jhon' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for jhon
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] y

```









