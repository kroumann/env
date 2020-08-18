#!/bin/bash

if [ -z "$WORKSPACEDIR" ]; then
    echo "Need to \"source workon $workspace\" first..."
    exit 1
fi

CSCOPE_DIR="$HOME/scopetags/$WORKSPACE"

if [ ! -d "$CSCOPE_DIR" ]; then	
	mkdir -p "$CSCOPE_DIR"
fi


cd $CSCOPE_DIR
echo "Finding files ..."
find -H $WORKSPACEDIR -name '*.[ch]' \
-o -name '*.java' \
-o -name '*properties' \
-o -name '*.cpp' \
-o -name '*.cc' \
-o -name '*.hpp' \
-o -name '*.py' > "$CSCOPE_DIR/cscope.files"
		
echo "Adding files to cscope db: $PWD/cscope.db ..."
cscope -b -q -i "$CSCOPE_DIR/cscope.files"
# -b		build cross reference only
# -q		Enable fast symbol lookup via an inverted index

echo "Generating ctags files..."
ctags -L $CSCOPE_DIR/cscope.files --extra=+f
# -L            Read the list of file names from the specified file.
# --extra=+f    Also include entries for base filename.

#export CSCOPE_DB="$PWD/cscope.out"		
#echo "Exported CSCOPE_DB to: '$CSCOPE_DB'"
		
