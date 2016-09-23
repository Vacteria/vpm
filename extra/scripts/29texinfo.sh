NAME="texinfo"
VERSION="4.13a"
SOURCES="http://ftp.gnu.org/gnu/texinfo/texinfo-${VERSION}.tar.gz"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
