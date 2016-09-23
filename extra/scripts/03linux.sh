NAME="linux"
VERSION="3.5.1"
SOURCES="http://www.kernel.org/pub/linux/kernel/v3.x/linux-${VERSION}.tar.xz"

exec_build()
{
	make mrproper || die make
	make headers_check || die make
	make INSTALL_HDR_PATH=dest headers_install || die inst

	cp -rv dest/include/* /toolchain/include

	return 0
}
