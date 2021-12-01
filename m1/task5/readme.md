# Task 1 #

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

