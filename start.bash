# start.bash
#

if [ -z "$path_to_store_backups" ]; then
  error "Backup target directory not set"
  exit 1
fi

if [ -z "$what_to_backup" ]; then
  error "Backup source directory not set"
  exit 1
fi

if [ -f $lockfile ]; then
  error "Another script is running ($lockfile exists), exiting"
  exit 1;
fi 

touch $lockfile

script_start=`date +%s` # julian seconds
