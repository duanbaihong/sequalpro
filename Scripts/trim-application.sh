#! /bin/ksh 

#
#  trim-application.sh
#  sequel-pro
#
#  Created by Stuart Connolly (stuconnolly.com).
#  Copyright (c) 2009 Stuart Connolly. All rights reserved.
#
#  Permission is hereby granted, free of charge, to any person
#  obtaining a copy of this software and associated documentation
#  files (the "Software"), to deal in the Software without
#  restriction, including without limitation the rights to use,
#  copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the
#  Software is furnished to do so, subject to the following
#  conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
#  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
#  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
#  OTHER DEALINGS IN THE SOFTWARE.
#
#  More info at <https://github.com/sequelpro/sequelpro>

#  Trims an application bundle of unnecessary files and resources that are generally not required and otherwise
#  waste disk space.
#
#  Largely based on 'trim-app' by Ankur Kothari ( http://lipidity.com/downloads/trim-app/ )
#
#  Parameters: -p -- The path to the application that is to be trimmed 
#              -d -- Remove unnecessary files (i.e. .DS_Store files, etc) (optional).
#              -n -- Trim nib files (i.e. remove .info.nib, classes.nib, data.dependency and designable.nib) (optional).
#              -t -- Compress tiff images using LZW compression (optional).
#              -f -- Remove framework headers (optional).
#              -r -- Remove resource forks (optional).
#              -a -- All of above optional options. Equivalent to '-d -n -s -t -f -r'.  

usage() 
{
	echo "Usage: $(basename $0) -p application_path [-d -n -s -t -f -r]"	
	exit 1
}

while getopts ":p:dnstra" OPTION
do
	case $OPTION in 
	    p) APP_PATH="$OPTARG";;
		d) REMOVE_FILES=1;;
		n) TRIM_NIBS=1;;
	   	t) COMPRESS_TIFF=1;;
	   	f) REMOVE_F_HEADERS=1;;
	   	r) REMOVE_RSRC=1;;
	   	a) REMOVE_FILES=1;
	   	   TRIM_NIBS=1;
	   	   COMPRESS_TIFF=1;
	   	   REMOVE_F_HEADERS=1;
	   	   REMOVE_RSRC=1;;
		*) echo 'Unrecognised argument'; usage;;
	esac
done

if [ $# -eq 0 ]
then
    echo 'Illegal number of arguments. I need the path to an application.'
    usage
fi

if [ ! -d "$APP_PATH" ]
then
    echo "Invalid application path. Application at path '${APP_PATH}' doesn't seem to exist."
    usage
fi

if [ ! -w "$APP_PATH" ]
then
    echo "Error: Application at path '${APP_PATH}' is not writeable."
    usage
fi

if [ $# -lt 2 ]
then
    echo 'Illegal number of arguments. I need at least one trim option.'
	usage
fi

APP_NAME=$(perl -e "print substr('${APP_PATH}', rindex('${APP_PATH}', '/') + 1);")

printf "Trimming application bundle '${APP_NAME}' at '${APP_PATH}'...\n\n"

# Remove unnecessary files
if [ $REMOVE_FILES ]
then
    printf 'Removing unnecessary files...\n'

    find "$APP_PATH" \( -name '.DS_Store' -or -name 'pbdevelopment.plist' -type f \) | while read FILE; do; printf "\tRemoving file: ${FILE}\n"; rm "$FILE"; done;
fi

# Trim nibs
if [ $TRIM_NIBS ]
then
    printf '\nTrimming nibs...\n'

    find "$APP_PATH" \( -name 'info.nib' -or -name 'classes.nib' -or -name 'data.dependency' -or -name 'designable.nib' -type f \) | while read FILE; do; printf "\tRemoving nib file: ${FILE}\n"; rm "$FILE"; done;
fi

# Compress tiff images
if [ $COMPRESS_TIFF ]
then
    printf '\nCompressing tiff images...\n'

    find "$APP_PATH" \( -name "*.tif" -or -name "*.tiff" \) | while read FILE; do; printf "\tCompressing tiff: ${FILE}\n"; tiffutil -lzw "$FILE" -out "${FILE}.out" 2> /dev/null; mv "${FILE}.out" "$FILE"; done;
fi

# Remove framework headers
if [ $REMOVE_F_HEADERS ]
then
    printf '\nRemoving framework headers...\n'
    
    FRAMEWORK_PATH="${APP_PATH}/Contents/Frameworks"
    
    if [ -d "$FRAMEWORK_PATH" ]
    then
        find "$FRAMEWORK_PATH" \( -name "*.h" -type f \) | while read FILE; do; printf "\tRemoving header: ${FILE}\n"; rm "$FILE"; done;
    fi
fi

# Remove resource forks
if [ $REMOVE_RSRC ]
then
    printf '\nRemoving resource forks...\n'
    
    find "$APP_PATH" -type f | while read FILE; do if [ -s "${FILE}/rsrc" ]; then; printf "\tRemoving reource: ${FILE}/rsrc\n"; cp /dev/null "${FILE}/rsrc"; fi; done;
fi

printf "\nTrimming application bundle '${APP_NAME}' complete\n\n"

exit 0
