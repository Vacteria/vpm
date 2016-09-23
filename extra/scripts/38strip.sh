HOOK="1"

exec_hook()
{
	strip --strip-debug /toolchain/lib/*
	strip --strip-unneeded /toolchain/{,s}bin/*
	rm -rf /toolchain/{,share}/{info,man,doc}

	find ${ROOTFSDIR}/toolchain | grep -E "*${TRIPLET}*" | xargs rm -rvf

	[ -f ${ARCHIVEDIR}/${REALARCH}-${DISTRO}-linux-gnu.tar.xz ] && \
	rm -f ${ARCHIVEDIR}/${REALARCH}-${DISTRO}-linux-gnu.tar.xz
	
	case ${REALARCH} in
		i?86 ) defdist="pc" ;;
		x86_64 ) defdist="unknow" ;;
	esac
	FILEPATH="${ARCHIVEDIR}/${REALARCH}-${defdist}-linux-gnu.tar.xz"
	
	[ -f "${FILEPATH}" ] && rm -f "${FILEPATH}"	
	tar -C ${ROOTFSDIR} -cJvf ${FILEPATH} toolchain || return 1
	
	return 0
}
