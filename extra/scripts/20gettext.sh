NAME="gettext"
VERSION="0.18.1.1"
SOURCES="http://ftp.gnu.org/gnu/gettext/gettext-${VERSION}.tar.gz"

exec_build()
{
	find . -name stdio.in.h | xargs sed -i '/gets is a security hole/d'

	cd gettext-tools
	EMACS="no" ./configure \
	--prefix=/toolchain \
	--disable-shared \
	--disable-acl || die conf

	make -C gnulib-lib                   || die make
	make -C src msgfmt msgmerge xgettext || die make

	install -m 0755 src/{msgfmt,msgmerge,xgettext} /toolchain/bin || return 1

	cd ../gettext-runtime
	EMACS="no" ./configure \
	--prefix=/toolchain \
	--disable-shared || die conf

	make -C gnulib-lib  || die make
	make -C src gettext 
	install -m 0755 src/gettext /toolchain/bin || return 1
	
	return 0
}
