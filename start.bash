# start.bash
#

if [ -z "$SOURCE_BASE" ]; then
  error "SOURCE_BASE not set"
  exit 1
fi

if [ -z "$TARGET_BASE" ]; then
  error "TARGET_BASE not set"
  exit 1
fi

if [ -f $lockfile ]; then
  log "Another script is running ($lockfile exists), exiting"
  exit 1;
fi 

touch $lockfile

script_start=`date +%s` # julian seconds
