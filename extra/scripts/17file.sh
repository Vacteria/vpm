NAME="file"
VERSION="5.11"
SOURCES="ftp://ftp.astron.com/pub/file/file-${VERSION}.tar.gz"

exec_build()
{
	./configure \
	--prefix=/toolchain || die conf
	
	make || die make
	run_test || make check
	make install || die inst
	
	
	return 0
}
