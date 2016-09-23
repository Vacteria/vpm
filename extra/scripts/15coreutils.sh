NAME="coreutils"
VERSION="8.17"
SOURCES="http://ftp.gnu.org/gnu/coreutils/coreutils-${VERSION}.tar.xz"

exec_build()
{
	./configure \
	--prefix=/toolchain \
	--enable-install-program=hostname || die conf
	
	make || die make
	run_test || make RUN_EXPENSIVE_TESTS=yes check
	make install || die inst
	
	cp -v src/su /toolchain/bin/su
	
	return 0
}
