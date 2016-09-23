NAME="perl"
VERSION="5.16.1"
SOURCES="http://www.cpan.org/src/5.0/perl-${VERSION}.tar.bz2"
PATCHES="http://www.linuxfromscratch.org/patches/lfs/development/perl-${VERSION}-libc-2.patch"

exec_build()
{
	sh Configure -des -Dprefix=/toolchain || die conf
	make || die make
	cp -v perl cpan/podlators/pod2man /toolchain/bin
	mkdir -pv /toolchain/lib/perl5/${VERSION}
	cp -Rv lib/* /toolchain/lib/perl5/${VERSION}

	return 0
}
