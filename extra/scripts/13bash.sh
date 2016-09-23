NAME="bash"
VERSION="4.2"
SOURCES="http://ftp.gnu.org/gnu/bash/bash-${VERSION}.tar.gz"
PATCHES="http://www.linuxfromscratch.org/patches/lfs/development/bash-${VERSION}-fixes-8.patch"

exec_build()
{
	./configure \
	--prefix=/toolchain \
	--without-bash-malloc || die conf
	
	make || die make
	run_test || make test
	make install || die inst

	ln -vs bash /toolchain/bin/sh
	
	return 0
}
