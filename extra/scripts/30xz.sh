NAME="xz"
VERSION="5.0.4"
SOURCES="http://tukaani.org/xz/xz-${VERSION}.tar.bz2"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
