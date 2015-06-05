#!/bin/bash

HERE=$(cd $(dirname $0); pwd -P)
RUNS="5_5_5 5_5_13 5_13_5 13_5_5 13_13_5 13_5_13 5_13_13 13_13_13 13_13_26 13_26_13 26_13_13 26_26_13 26_13_26 13_26_26 26_26_26 32_32_32"

NMAX=$(echo ${RUNS} | wc -w)
NRUN=1
for RUN in ${RUNS} ; do
  MVALUE=$(echo ${RUN} | cut --output-delimiter=' ' -d_ -f1)
  NVALUE=$(echo ${RUN} | cut --output-delimiter=' ' -d_ -f2)
  KVALUE=$(echo ${RUN} | cut --output-delimiter=' ' -d_ -f3)
  >&2 echo "Test ${NRUN} of ${NMAX} (M=${MVALUE} N=${NVALUE} K=${KVALUE})"
  env LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH \
    ${HERE}/specialized.sh ${MVALUE} ${NVALUE} ${KVALUE}
  echo
  NRUN=$((NRUN + 1))
done

