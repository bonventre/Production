#!/bin/bash

# usage: bash Scripts/generate_POT.sh -n MDC2020 -v u -o mu2e -r 1202 -e 2000 -j 1000 -d POT


# placeholder for the MDC name and version
VERSION=""
NAME=""
OWNER=""
# default arguments set, user can override 
RUN=1202
EVENTS=2000
JOBS=1000
DESC=POT
# Function: Print a help message.
usage() {                                 
  echo "Usage: $0 [ -n NAME ] [ -v VERSION ] [ -o OWNER ] [ -r RUN ] [ -e EVENTS ][ -j JOBS ][ -d DESC ]" 1>&2 
}
# Function: Exit with error.
exit_abnormal() {                         
  usage
  exit 1
}
# Loop: Get the next option;
while getopts ":n:v:o:r:e:j:d:" options; do         
  case "${options}" in                    
    n)                                  # If the option is n,
      NAME=${OPTARG}                      # set $NAME to specified value.
      ;;
    v)                                    # If the option is v,
      VERSION=${OPTARG}                     # Set $VERSION to specified value.
      ;;
    o)                                    # If the option is o,
      OWNER=${OPTARG}                     # Set $OWNER to specified value.
      ;;
    r)                                    # If the option is r,
      RUN=${OPTARG}                     # Set $RUN to specified value.
      ;;
    e)                                    # If the option is e,
      EVENTS=${OPTARG}                     # Set $EVENTS to specified value.
      ;;
    j)                                    # If the option is j,
      JOBS=${OPTARG}                     # Set $JOBS to specified value.
      ;;
    d)                                    # If the option is d,
      DESC=${OPTARG}                     # Set $DESC to specified value.
      ;;
    :)                                    # If expected argument omitted:
      echo "Error: -${OPTARG} requires an argument."
      exit_abnormal                       # Exit abnormally.
      ;;
    *)                                    # If unknown (any other) option:
      exit_abnormal                       # Exit abnormally.
      ;;
  esac
done
# Run: run generate fcl with input from user
generate_fcl --dsconf=${NAME}${VERSION} --dsowner=${OWNER} --run-number=${RUN} --events-per-job=${EVENTS} --njobs=${JOBS} --include Production/JobConfig/beam/POT.fcl --description=${DESC}
for dirname in 000 001 002 003 004 005 006 007 008 009; do
 if test -d $dirname; then
  echo "found dir $dirname"
  rm -rf POT_${NAME}${VERSION}_$dirname
  mv $dirname POT_${NAME}${VERSION}_$dirname
 fi
done

