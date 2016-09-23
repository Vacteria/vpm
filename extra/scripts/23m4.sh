NAME="m4"
VERSION="1.4.16"
SOURCES="http://ftp.gnu.org/gnu/m4/m4-${VERSION}.tar.bz2"

exec_build()
{
	sed -i '/gets is a security hole/d' lib/stdio.in.h

	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst
	
	return 0
}
