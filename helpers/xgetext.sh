#!/bin/sh

touch po/{vpmqdb,vpm,vpmbuild,vpmget,vpmrepo}.pot

find gdbm/ -name "*.c" | xgettext --keyword=_ -o po/vpmqdb.pot -j -f -

for I in vpm vpmbuild vpmget vpmrepo
do
	echo bash/${I}.in  | xgettext -L Shell -o po/${I}.pot -j -f -
	find bash/${I}/ -type f | xgettext -L Shell -o po/${I}.pot -j -f -
done
