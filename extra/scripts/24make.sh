NAME="make"
VERSION="3.82"
SOURCES="http://ftp.gnu.org/gnu/make/make-${VERSION}.tar.bz2"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make         || die make
	run_test     || make check
	make install || die inst
	
	return 0
}
