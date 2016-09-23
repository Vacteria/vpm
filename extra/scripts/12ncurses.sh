NAME="ncurses"
VERSION="5.9"
SOURCES="ftp://ftp.gnu.org/gnu/ncurses/ncurses-${VERSION}.tar.gz"

exec_build()
{
	./configure \
	--prefix=/toolchain \
	--with-shared \
    --without-debug \
    --without-ada \
    --enable-overwrite || die conf
    
    make || die make
    make install || die inst
    
	return 0
}
