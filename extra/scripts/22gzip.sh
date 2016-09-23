NAME="gzip"
VERSION="1.5"
SOURCES="http://ftp.gnu.org/gnu/gzip/gzip-${VERSION}.tar.gz"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst
	
	return 0
}
