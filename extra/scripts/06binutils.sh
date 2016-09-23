NAME="binutils"
VERSION="2.22"
SOURCES="http://ftp.gnu.org/gnu/binutils/binutils-${VERSION}.tar.bz2"
PATCHES="http://www.linuxfromscratch.org/patches/lfs/development/binutils-${VERSION}-build_fix-1.patch"

exec_build()
{
	mkdir -v binutils-build
	cd binutils-build

	CC=${DIST_TGT}-gcc \
	AR=${DIST_TGT}-ar \
	RANLIB=${DIST_TGT}-ranlib \
	../configure \
	--prefix=/toolchain \
	--disable-nls \
	--with-lib-path=/toolchain/lib || die conf

	make || die make
	make install || die inst

	make -C ld clean || return 1
	make -C ld LIB_PATH=/usr/lib:/lib || return 1
	cp -v ld/ld-new /toolchain/bin || return 1
	
	return 0
}
