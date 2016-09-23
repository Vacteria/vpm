NAME="wget"
VERSION="1.13.4"
SOURCES="http://ftp.gnu.org/gnu/wget/wget-${VERSION}.tar.xz"

exec_build()
{
	find . -name stdio.in.h | xargs sed -i '/gets is a security hole/d'

	./configure \
	--prefix=/toolchain \
	--with-ssl=no
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
