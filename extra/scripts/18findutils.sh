NAME="findutils"
VERSION="4.4.2"
SOURCES="http://ftp.gnu.org/gnu/findutils/findutils-${VERSION}.tar.gz"

exec_build()
{
	./configure \
	--prefix=/toolchain || die conf
	
	make || die make
	run_test || make check
	make install || die inst
	
	return 0
}
