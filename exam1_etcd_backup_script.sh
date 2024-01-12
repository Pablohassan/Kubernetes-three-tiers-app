 LOGFILE="/home/ubuntu/backup/backup_script.log"

current_time() {
    date +"%Y-%m-%d %H:%M:%S"
}

echo "---------------------------------" >> "$LOGFILE"
echo " $(current_time): Backup started at $(date)" >> "$LOGFILE"

# Save the etcd snapshot
echo " $(current_time): Saving etcd snapshot..." >> "$LOGFILE"
/usr/local/bin/k3s etcd-snapshot save --etcd-snapshot-dir=/home/ubuntu/backup 2>&1 | tee -a "$LOGFILE"
sudo chmod -R u+rw,g+r,o+r /home/ubuntu/backup 2>&1 | tee -a "$LOGFILE"
# Check if etcd snapshot was successful
if [ $? -eq 0 ]; then
    echo "$(current_time): etcd snapshot saved successfully." >> "$LOGFILE"
else
    echo "$(current_time): Error occurred during etcd snapshot save. Check the logs above." >> "$LOGFILE"
    exit 1
fi

# Sync the backup to the remote server
echo "$(current_time): Syncing backup to remote server..." >> "$LOGFILE"


rsync -a -e "ssh -p 2222 -i /home/ubuntu/.ssh/id_rsa" /home/ubuntu/backup vagrant@127.0.0.1:/home/vagrant/backups 2>&1 | tee -a "$LOGFILE"

# Check if rsync was successful
if [ $? -eq 0 ]; then
    echo "$(current_time): Backup synced successfully to remote server." >> "$LOGFILE"
else
    echo " $(current_time): Error occurred during rsync. Check the logs above." >> "$LOGFILE"
    exit 1
fi

echo "$(current_time): Backup completed at $(date)" >> "$LOGFILE"
