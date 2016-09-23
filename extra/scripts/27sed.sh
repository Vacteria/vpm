NAME="sed"
VERSION="4.2.1"
SOURCES="http://ftp.gnu.org/gnu/sed/sed-${VERSION}.tar.bz2"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
