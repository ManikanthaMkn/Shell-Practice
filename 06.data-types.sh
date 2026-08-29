#!/bin/bash

NUMBER1=Manikantha
NUMBER2=87513

TIMESTAMP=$(date)
echo "script executed as: $TIMESTAMP"
SUM=$(($NUMBER1+$NUMBER2))

echo "SUM of $NUMBER1 and $NUMBER2 is: $SUM"