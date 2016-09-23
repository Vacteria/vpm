NAME="grep"
VERSION="2.13"
SOURCES="http://ftp.gnu.org/gnu/grep/grep-${VERSION}.tar.xz"

exec_build()
{
	./configure \
	--prefix=/toolchain || die conf
    
    make || die make
    run_test || make check
    make install || die ints
    
	return 0
}
