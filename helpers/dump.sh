for i in /var/vpm/pkgfiles/*
do
	N=$(grep -E '^NAME.*:.*' $i | sed -e 's/.*: //g')
	V=$(grep -E '^VERSION.*:.*' $i | sed -e 's/.*: //g')
	A=$(grep -E '^PKGARCH.*:.*' $i | sed -e 's/.*: //g')

	vpmqdb -if /var/vpm/data/packages.db "${N}" "${V}|${A}|1"
done
