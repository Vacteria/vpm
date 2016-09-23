case ${REALARCH} in
	i?86   )
		NAME="gnat-gpl-2011-i686-gnu"
		VERSION="linux-libc2.3-bin"
	;;
	x86_64 )
		NAME="gnat-gpl-2010-x86_64-pc"
		VERSION="linux-gnu-bin"
	;;
esac
SOURCES="http://devel.vacteria.org/gcc/${NAME}-${VERSION}.tar.gz"

exec_build()
{
	make ins-all prefix=/toolchain/gnat || die make
	
	return 0
}
