# vars.inc.bash - funkybackup configuration script
#
# This is called vars.inc.bash in the git repository
# and should be copied to vars.inc.bash and mofified
#
# For more details about the script and to contact me goto 
# http://www.funkytwig.com/blog/funkybackup
#
# (c) 2015 Ben Edwards (funkytwig.com) 
# Please be respectful and keep this header

set -f

SOURCE_BASE=/mnt/ext_backup_hub/CCTV-TG20
TARGET_BASE=/tribe/data/cctv/from_nvr_headers_rewrittern
TEMP_FILE=/tribe/data/cctv/temp.mp4

interactive=1

# You should not need to change anything below this line

user=`id -u -n`
logstamp=`date +%D_%R`
basename=`basename $0 .bash`
lockfile=/tmp/${user}_hickcrunch_lock.funkybackup
logfile=/var/log/hickcrunch.$user.log

set +f
