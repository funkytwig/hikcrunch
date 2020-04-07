#!/bin/bash 

source vars.inc.bash
source function.inc.bash
source start.bash

function run_cmd() {
	cmd=$1

	echo $cmd

	ret=$?

	if  [ $ret -ne 0 ]; then
		echo "$cmd exited with error code $ret"
		exit 1
	fi
}

SOURCE_BASE=/mnt/ext_backup_hub/CCTV-TG20
TARGET_BASE=/tribe/data/cctv/from_nvr_headers_rewrittern
TEMP_FILE=/tribe/data/cctv/temp.mp4

if [ -f $TEMP_FILE ]; then
	run_cmd "rm $TEMP_FILE"
fi

for dir in `find $SOURCE_BASE -name "ch*" -type d`
do
	for file in `find $dir -name "ch*"`
	do
		basename=`basename $file`
		dirname=`dirname $file`
		top_dir="${dirname##*/}"
		ext="${file##*.}"
		chan="${basename%_*}"
		filename_nocam="${basename#*_}"
		year=${filename_nocam:0:4}
		month=${filename_nocam:4:2}
		day=${filename_nocam:6:2}
		hhmm=${filename_nocam:8:4}
		secs=${filename_nocam:12:2}
		rest=${filename_nocam:14}

		new_filename="${chan}_${year}_${month}_${day}_${hhmm}_${secs}${rest}"
		new_dir="${TARGET_BASE}/${top_dir}"

		if [ ! -d $new_dir ]; then
			run_cmd "mkdir -p $new_dir"
		fi

		new_pathname="${new_dir}/${new_filename}"

		# note first pass returns main directory, not file, but extension is then set to whole directory name so skipped

		if [ "$ext" = "mp4" ] || [ $ext = "txt" ]; then 
			if [ ! -f $new_pathname ]; then  # skip if file already copies, used so we can rerun if fscript fails

				if [ "$ext" = "mp4" ]; then
					run_cmd "ffmpeg -loglevel warning -i $file -flags +global_header -vcodec copy -acodec copy $TEMP_FILE" 
					run_cmd "mv $TEMP_FILE $new_pathname" 
        	        	elif [ "$ext" = "txt" ]; then
					run_cmd "cp $file $new_pathname" 
	        		fi
			fi
		fi
	done
done
