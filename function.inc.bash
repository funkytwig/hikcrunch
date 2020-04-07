# function.inc.bash - funkybackup global functions
#
# For more details about the script and to me goto 
# http://www.funkytwig.com/blog/funkybackup
#
# (c) 2015 Ben Edwards (funkytwig.com) 
# You are alowed to use the script if you keep this head0er 
# and do not redistibute it, just send people to the URL
#
# Ver   Coments
# 0.5   Initial version

function log {
  logstamp=`date +%D_%R`
  log_text="$logstamp $1"

  if [ $interactive -eq 1 ]; then
    echo $log_text
  fi

  if [ $interactive -eq 1 ]; then
    echo "$logstamp $1" >> $logfile
  fi
}

function log_file {
  while read line 
  do
    log "$line" 
  done < "$1"
}

function run_cmd {
  tmp_log=/tmp/$$_cmd.log

  log "$1"

  $1 > $tmp_log 2>&1

  ret=$?

  if [ -f $tmp_log ]; then
    log_file $tmp_log
  fi

  if [ $ret -ne 0 ]; then
    log "ERROR : Return code $ret"
    exit 1;
    rm $lockfile
  fi

  return $ret
}
