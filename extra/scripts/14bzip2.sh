NAME="bzip2"
VERSION="1.0.6"
SOURCES="http://www.bzip.org/${VERSION}/bzip2-${VERSION}.tar.gz"

exec_build()
{
	make || die make
	make PREFIX=/toolchain install || die inst
	
	return 0
}
