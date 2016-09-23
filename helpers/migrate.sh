#!/bin/sh

# This script is usefull to migrate old txt format vpm database to
# new format GDBM based

INPUT="${1:-/var/vpm/data/packages.db}"
OUTPUT="${2:-/var/vpm/data/packages.db.gdbm}"

if [ ! -e "${OUTPUT}" ]
then
	vpmqdb -cf ${OTPUT}
fi

while read line
do
	IFS=$'|'
	set -- $line
	KEY=${2}
	unset IFS
	VALUE="${3}|${4}|${5}"

	vpmqdb -if ${OUTPUT} ${KEY} ${VALUE}
done < ${INPUT}
unset IFS
