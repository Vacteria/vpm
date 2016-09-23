NAME="glibc"
VERSION="2.16.0"
SOURCES="http://ftp.gnu.org/gnu/glibc/glibc-${VERSION}.tar.xz"

exec_build()
{
	mkdir -p glibc-build
	cd glibc-build

	case ${REALARCH} in
	  i?86) echo "CFLAGS += -march=i486 -mtune=generic" > configparms ;;
	esac

	sed -i 's/ -lgcc_s//' ../Makeconfig

	../configure \
	--prefix=/toolchain \
	--host=${DIST_TGT} \
	--build=$(../scripts/config.guess) \
	--disable-profile \
	--enable-add-ons \
	--enable-kernel=2.6.25 \
	--with-headers=/toolchain/include \
	libc_cv_forced_unwind=yes \
	libc_cv_ctors_header=yes \
	libc_cv_c_cleanup=yes || die conf

	make || die make
	make install || die inst

	mkdir -p ${ROOTFSDIR}/toolchain/etc/ld.so.conf.d
	echo 'include /toolchain/etc/ld.so.conf.d/*.conf' > ${ROOTFSDIR}/toolchain/etc/ld.so.conf
	
	return 0
}
