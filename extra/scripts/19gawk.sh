NAME="gawk"
VERSION="4.0.1"
SOURCES="http://ftp.gnu.org/gnu/gawk/gawk-${VERSION}.tar.xz"

exec_build()
{
	./configure \
	--prefix=/toolchain || die conf
	
	make || die make
	run_test || make check
	make install || die inst
		
	return 0
}
