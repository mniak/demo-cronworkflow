#!/bin/bash

ORG="$1"
if [[ "$ORG" == "" ]]; then 
    >&2 echo "Missing ORG variable"
    exit 1
fi

PROGRAM="$2"
if [[ "$PROGRAM" == "" ]]; then 
    >&2 echo "Missing PROGRAM variable"
    exit 1
fi
ERRORRATE=${3-0}

RAND=$((RANDOM % 100 + 1))
if [[ $RAND -le $ERRORRATE ]]; then
    EXITCODE=$RAND
else
    EXITCODE=0
fi

echo "---- JOB STARTED ----"
echo "  ORG: $ORG"
echo "  PROGRAM: $PROGRAM"
echo "  ERRORRATE: $ERRORRATE%"
echo "  RAND: $RAND, EXITCODE: $EXITCODE"
echo ""
for i in {1..5}; do
    echo -n "($i) Doing something... "
    sleep 2
    if [[ i -eq 3 && $EXITCODE -gt 0 ]]; then
        echo "Exiting with code $EXITCODE"
        exit $EXITCODE
    fi
    echo "Done!"
done

echo "---- END OF THE JOB ----"