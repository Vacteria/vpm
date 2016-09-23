NAME="tar"
VERSION="1.26"
SOURCES="http://ftp.gnu.org/gnu/tar/tar-${VERSION}.tar.bz2"

exec_build()
{
	sed -i '/gets is a security hole/d' gnu/stdio.in.h

	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst
	
	return 0
}
