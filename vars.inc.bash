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

# You should not need to change anything below this line

interactive=0
user=`id -u -n`
logstamp=`date +%D_%R`
logfile=/var/log/fhickcrunch.$user.log
basename=`basename $0 .bash`
lockfile=/tmp/${user}_${backup_name}_lock.funkybackup

set +f
