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
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
	$(dirname $( ${DIST_TGT}-gcc -print-libgcc-file-name) )/include-fixed/limits.h

	cp -v gcc/Makefile.in{,.tmp}
	sed 's/^T_CFLAGS =$/& -fomit-frame-pointer/' gcc/Makefile.in.tmp > gcc/Makefile.in

	for file in \
	 $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h)
	do
	  cp -uv $file{,.orig}
	  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/toolchain&@g' \
	  -e 's@/usr@/toolchain@g' $file.orig > $file
	  echo '
	#undef STANDARD_STARTFILE_PREFIX_1
	#undef STANDARD_STARTFILE_PREFIX_2
	#define STANDARD_STARTFILE_PREFIX_1 "/toolchain/lib/"
	#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
	  touch $file.orig
	done

	tar -jxf ${SRCDIR}/mpfr-${MPFRVER}.tar.bz2
	mv -v mpfr-${MPFRVER} mpfr

	tar -Jxf ${SRCDIR}//gmp-${GMPVER}.tar.xz
	mv -v gmp-${GMPVER} gmp
	
	tar -zxf ${SRCDIR}/mpc-${MPCVER}.tar.gz
	mv -v mpc-${MPCVER} mpc

	mkdir -v gcc-build
	cd gcc-build

	CC=${DIST_TGT}-gcc \
	AR=${DIST_TGT}-ar \
	RANLIB=${DIST_TGT}-ranlib \
	../configure \
	--prefix=/toolchain \
	--with-local-prefix=/toolchain \
	--with-native-system-header-dir=/toolchain/include \
	--enable-clocale=gnu \
	--enable-shared \
	--enable-threads=posix \
	--enable-__cxa_atexit \
	--enable-languages=c,c++ \
	--disable-libstdcxx-pch \
	--disable-multilib \
	--disable-bootstrap \
	--disable-libgomp \
	--with-mpfr-include=$(pwd)/../mpfr/src \
	--with-mpfr-lib=$(pwd)/mpfr/src/.libs || die conf
    
    make || die make
    make install || die inst
    
	ln -vs gcc /toolchain/bin/cc
    
	return 0
}
