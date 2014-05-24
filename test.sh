#!/bin/bash

RECHO=./recho.sh
HOST=localhost
FILE=`pwd`/foo.txt
OUT="beep"
RC=0

$RECHO $HOST $OUT > $FILE

if [[ "`cat $FILE`" != "$OUT" ]]; then
  echo "fail"
  RC=1
fi

echo "ok"
rm -f $FILE
exit $RC
