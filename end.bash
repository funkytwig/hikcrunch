# emd.bash
#

script_end=`date +%s` # julian seconds

run_time=$(($script_end-$script_start))

log "END, run time=$run_time seconds"

rm $lockfile
