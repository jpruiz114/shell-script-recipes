#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Right usage: foreach-compress-files.sh files-location extension password"
else
	FOLDER_LOCATION=$1
	cd $FOLDER_LOCATION
	
	EXT=$2
	
	# Place here the location of the Rar exe file
	RAR="C:\Program Files\WinRAR\Rar.exe"
	
	windows() { [[ -n "$WINDIR" ]]; }
	
	if windows; then
		# Make a simbolic link in your Windows\System32 folder
		SYMLINK_COMMAND="mklink \"C:\Windows\System32\rar.exe\" \"$RAR\""
		echo $SYMLINK_COMMAND
		cmd <<< $SYMLINK_COMMAND > /dev/null
		
		PASSWORD=$3
		
		for currentFile in *.${EXT}; do
			echo "Processing $currentFile file..."
			
			BASENAME=$(basename "$currentFile" .$EXT)
			echo "$BASENAME"
			
			rar a -p$PASSWORD $BASENAME.rar $currentFile
		done
	fi
fi
