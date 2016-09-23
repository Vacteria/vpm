NAME="nano"
VERSION="2.3.1"
SOURCES="http://www.nano-editor.org/dist/v2.3/nano-${VERSION}.tar.gz"

exec_build()
{
	./configure \
	--prefix=/toolchain
	
	make || die make
	run_test || make check
	make install || die inst

	return 0
}
