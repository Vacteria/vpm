NAME="getopt"
VERSION="1.1.4"
SOURCES="http://software.frodo.looijaard.name/getopt/files/getopt-${VERSION}.tar.gz"

exec_build()
{
	make prefix=/toolchain || die make
	make prefix=/toolchain install || die inst
	
	return 0
}