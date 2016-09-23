NAME="fakeroot"
VERSION="1.18.4"
SOURCES="http://ftp.de.debian.org/debian/pool/main/f/fakeroot/fakeroot_${VERSION}.orig.tar.bz2"

exec_build()
{
	./configure \
	--prefix=/toolchain \
	--disable-static \
	--disable-shared \
	--with-ipc=sysv
	
	make || die make
	run_test || make check
	make install || die inst
	
	return 0
}
