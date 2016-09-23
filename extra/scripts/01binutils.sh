NAME="binutils"
VERSION="2.22"
SOURCES="http://ftp.gnu.org/gnu/binutils/binutils-${VERSION}.tar.bz2"
PATCHES="http://www.linuxfromscratch.org/patches/lfs/development/binutils-${VERSION}-build_fix-1.patch"

exec_build()
{
	mkdir -v binutils-build
	cd binutils-build

	../configure \
	--with-sysroot=${ROOTFSDIR} \
    --with-lib-path=/toolchain/lib \
	--target=${DIST_TGT} \
	--prefix=/toolchain \
	--disable-nls \
	--disable-werror || die conf

	make || die make

	case ${REALARCH} in
		x86_64 ) mkdir -v /toolchain/lib && ln -sv lib /toolchain/lib64 ;;
	esac

	make install || die inst

	return 0
}
