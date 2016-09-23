NAME="diffutils"
VERSION="3.2"
SOURCES="http://ftp.gnu.org/gnu/diffutils/diffutils-${VERSION}.tar.gz"

exec_build()
{
	sed -i '/gets is a security hole/d' lib/stdio.in.h

	./configure \
	--prefix=/toolchain || die conf
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
