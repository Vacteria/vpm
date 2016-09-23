NAME="patch"
VERSION="2.6.1"
SOURCES="http://ftp.gnu.org/gnu/patch/patch-${VERSION}.tar.bz2"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
