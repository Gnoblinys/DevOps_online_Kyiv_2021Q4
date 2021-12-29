#!/bin/bash

if [ -n "$1" ] && [ -n "$2" ];
then
rsync -azvh --log-file=/home/ubuntu/backup/backup.log $1 $2 --delete &> /dev/null
else
rsync -azvh --log-file=/home/ubuntu/backup/backup.log /home/ubuntu/backup/data /home/ubuntu/backup/bdir --delete &>  /dev/null
fi



