#!/bin/bash

ORG="$1"
if [[ "$ORG" == "" ]]; then 
    >&1 echo "Missing ORG variable"
    exit 1
fi

PROGRAM="$2"
if [[ "$PROGRAM" == "" ]]; then 
    >&1 echo "Missing PROGRAM variable"
    exit 1
fi
EXITCODE=${3-0}

echo "---- JOB STARTED ----"
echo "  ORG: $ORG"
echo "  PROGRAM: $PROGRAM"
echo "  EXITCODE: $EXITCODE"
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