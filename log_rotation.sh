#!/bin/bash
#Incremental Backup using Rsync and Log rotation scheme
#
#
BACKUP_DIR=/home/tim/destination
BACKUP_MAX=3

pushd $BACKUP_DIR

#Step 1: Remove oldest Backup
rm -rf backup.${BACKUP_MAX}

# Step 2: Rotate
(( _to = BACKUP_MAX ))
while (( _to > 1 )) ; do
   (( _from = _to - 1 ))
   mv backup.${_from} backup.${_to}
   (( _to = _to - 1 ))
done

#Step 3: Use rsync to create most recent backup.1 and hardlink to backup.2
rsync -a --delete --link-dest=/home/tim/destination/backup.2 /home/tim/source/ /home/tim/destination/backup.1/

popd

echo Rotation Complete.
