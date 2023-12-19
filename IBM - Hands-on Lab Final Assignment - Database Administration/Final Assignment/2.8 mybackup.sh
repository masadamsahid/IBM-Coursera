#! /bin/sh

backup_dir=/tmp/mysqldumps/$(date +%Y%m%d);

backup_file=$backup_dir/backup.sql;

mkdir -p $backup_dir/;

# Create backup
if mysqldump --all-databases --user=root --password=MTI5NzMtbWFzYWRh > $backup_file
then
    echo 'SUCCESS: MySQL dump created at:';
    echo $backup_file;
else
    echo 'mysqldump return non-zero code No backup was created!';
fi

