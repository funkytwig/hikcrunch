#!/bin/bash 

source vars.inc.bash
source function.inc.bash
source start.bash

if [ -f $TEMP_FILE ]; then
	run_cmd "rm $TEMP_FILE"
fi

for dir in `find $SOURCE_BASE -name "ch*" -type d`
do
	for file in `find $dir -name "ch*"`
	do
		base=`basename $file`
		dirname=`dirname $file`
		top_dir="${dirname##*/}"
		ext="${file##*.}"
		chan="${base%_*}"
		filename_nocam="${base#*_}"
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
			else
				log "Skipping $new_pathname, file exists"
			fi
		fi
	done
done

source end.bash

