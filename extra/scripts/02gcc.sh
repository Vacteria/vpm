NAME="gcc"
VERSION="4.7.1"
MPFRVER="3.1.1"
GMPVER="5.0.5"
MPCVER="1.0"
SOURCES="
	http://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.bz2
	http://www.mpfr.org/mpfr-${MPFRVER}/mpfr-${MPFRVER}.tar.bz2
	http://ftp.gnu.org/gnu/gmp/gmp-${GMPVER}.tar.xz
	http://www.multiprecision.org/mpc/download/mpc-${MPCVER}.tar.gz
"

exec_build()
{
	tar -jxf ${SRCDIR}/mpfr-${MPFRVER}.tar.bz2
	mv -v mpfr-${MPFRVER} mpfr

	tar -Jxf ${SRCDIR}//gmp-${GMPVER}.tar.xz
	mv -v gmp-${GMPVER} gmp
	
	tar -zxf ${SRCDIR}/mpc-${MPCVER}.tar.gz
	mv -v mpc-${MPCVER} mpc

	for file in $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
		cp -uv $file{,.orig}
		sed \
		-e 's@/lib\(64\)\?\(32\)\?/ld@/toolchain&@g' \
		-e 's@/usr@/toolchain@g' $file.orig > $file
		echo '
		#undef STANDARD_STARTFILE_PREFIX_1
		#undef STANDARD_STARTFILE_PREFIX_2
		#define STANDARD_STARTFILE_PREFIX_1 "/toolchain/lib/"
		#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
		touch $file.orig
	done

	sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

	mkdir -v gcc-build
	cd gcc-build

	../configure \
	--target=${DIST_TGT} \
	--prefix=/toolchain \
	--with-sysroot=${ROOTFSDIR} \
	--with-newlib \
	--without-headers \
	--with-local-prefix=/toolchain \
	--with-native-system-header-dir=/toolchain/include \
	--disable-nls \
	--disable-shared \
	--disable-multilib \
	--disable-decimal-float \
	--disable-threads \
	--disable-libmudflap \
	--disable-libssp \
	--disable-libgomp \
	--disable-libquadmath \
	--enable-languages=c \
	--with-mpfr-include=$(pwd)/../mpfr/src \
	--with-mpfr-lib=$(pwd)/mpfr/src/.libs || die conf

    make || die make
    make install || die inst
    
	ln -vs libgcc.a $( ${DIST_TGT}-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/')
    
	return 0
}
