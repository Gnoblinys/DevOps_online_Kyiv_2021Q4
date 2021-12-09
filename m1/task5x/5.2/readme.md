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

- 6

How do I change the name (account name) of an existing user?

usermod -l new_username old_username // it coman doesn't change home directory name
```
less /etc/passwd
jhon:x:1001:1001:,,,:/home/jhon:/bin/bash

ubuntu@ip-172-31-20-252:~$ sudo usermod -l jack jhon

less /etc/passwd
jack:x:1001:1001:,,,:/home/jhon:/bin/bash
```
- 7 

What is skell_dir? What is its structure?

/etc/skel - it is setap default parametrs for created new users
```
ubuntu@ip-172-31-20-252:~$ tree -a /etc/skel
/etc/skel
├── .bash_logout
├── .bashrc
└── .profile

```

- 8

How to remove a user from the system (including his mailbox)?

 deluser --remove-home username // for delete user and home dir
 deluser --remove-all-files uername // for delete user, home dir and all users files in system. 

 ```
ubuntu@ip-172-31-20-252:/etc/skel$ sudo deluser --remove-home jack
Looking for files to backup/remove ...
Removing files ...
Removing user `jack' ...
Warning: group `jhon' has no more members.
Done.
```

- 9 

What commands and keys should be used to lock and unlock a user account?

usermod -e EXPIRE_DATE//  --expiredate EXPIRE_DATE
           The date on which the user account will be disabled. The date is specified in the format
           YYYY-MM-DD.
or
passwd -l user_name
usermod -L, --lock //it methods don't lock access through SSH!!!
           Lock a user's password. This puts a '!' in front of the encrypted password, effectively
           disabling the password. You can't use this option with -p or -U.

```
sudo usermod -e 2021-12-07 jack
sudo usermod -U jack //unlock
```
- 10

How to remove a user's password and provide him with a password-free
login for subsequent password change?

passwd -d username
passwd -e username

```
ubuntu@ip-172-31-20-252:/etc/skel$ sudo passwd -d jack
passwd: password expiry information changed.
ubuntu@ip-172-31-20-252:/etc/skel$ sudo passwd -e jack
passwd: password expiry information changed.
```
- 11

Display the extended format of information about the directory, tell about
the information columns displayed on the terminal

```
ubuntu@ip-172-31-20-252:/$ ls -alhi
total 72K
    2 drwxr-xr-x 19  root root 4.0K Dec  8 13:27 .
    2 drwxr-xr-x 19  root root 4.0K Dec  8 13:27 ..
   13 drwxr-xr-x  3  root root 4.0K Dec  6 14:34 boot
 1521 lrwxrwxrwx  1  root root    9 Oct 21 23:23 lib64 -> usr/lib64
 [1]      [2]    [3] [4]  [5]  [6]  [      7   ] [        8        ]

 1. inode
 2. permission
 3. number of links in system
 4. owner user
 5. owner group
 6. size
 7. laste date of create/edit/access 
 8. name
 ```

 - 12

 What access rights exist and for whom (i. e., describe the main roles)?
Briefly describe the acronym for access rights.

Permission
```
rwx|rwx|rwx
 |   |   |--> others
 |   |------> group
 |----------> owner
```
 For change permissions we can use comand chmod:

 > chmod ugo+rwx filename

```
 u - user
 g - group
 o - other
```

```
 r - allow read
 w - allow write
 x - allow execute
```
or nuber codes:

 > chmod 777 filename

```
0 - without permission
1 - only execute
2 - only write
3 - execute and write
4 - only read
5 - read and execute
6 - read and write
7 - read, write and execute
```

 - 13

 What is the sequence of defining the relationship between the file and the
user?
```
                                User trying rwx file\dir
                                System check permission:
                                       User is owner?
                                       Yes       Not
                                       /           \
Allow acces according to owner permissins           User is member of group?
                                                            Yes   Not
                                                           /       |
                  Allow acces according to group permissins        |
                                                                   |
                                                      Yser is member of owner?
                                                        Yes          Not
                                                       /               \
              Allow acces according to group permissins            disallow acces
```
- 14

What commands are used to change the owner of a file (directory), as well
as the mode of access to the file? Give examples, demonstrate on the terminal.

```
ubuntu@ip-172-31-20-252:~/test$ ls -l | grep test
-rwx-wx-wx 1 ubuntu ubuntu     0 Dec  8 15:08 test

ubuntu@ip-172-31-20-252:~/test$ sudo chown jack:jack test
ubuntu@ip-172-31-20-252:~/test$ ls -l | grep test
-rwx-wx-wx 1 jack   jack       0 Dec  8 15:08 test

```

- 15

What is an example of octal representation of access rights? Describe the
umask command.

```
0 - without permission
1 - only execute
2 - only write
3 - execute and write
4 - only read
5 - read and execute
6 - read and write
7 - read, write and execute
```

umask - sets permissions for new files in while terminal session. Doesn't set permission execute for files.

```
ubuntu@ip-172-31-20-252:~/test$ umask -p
umask 0002
ubuntu@ip-172-31-20-252:~/test$ umask -S
u=rwx,g=rwx,o=rx

```
- 16

Give definitions of sticky bits and mechanism of identifier substitution. Give
an example of files and directories with these attributes.

```
A Sticky bit is a permission bit that is set on a file or a directory that lets only the owner of the file/directory or the root user to delete or rename the file. No other user is given privileges to delete the file created by some other user.
```

```
ubuntu@ip-172-31-20-252:/$ ls -ld
drwxr-xr-x 19 root root 4096 Dec  8 13:27 .

d- Sticky bit
```

- 17

What file attributes should be present in the command script

File with comand skript mast have attribute "x" for distanation users and group or SUID/SGID "s"   for start skript with permission file owner.




|Type|Link|
|----|----|
|Comands|https://losst.ru|
|SUID, GUID & Sticky Bit|[https://andreyex.ru](https://andreyex.ru/linux/spetsialnye-razresheniya-dlya-fajlov-v-linux-suid-guid-i-sticky-bit/)|













