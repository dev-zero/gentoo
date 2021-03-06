# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-multilib

if [[ ${PV} == *9999 ]] ; then
	: ${EGIT_REPO_URI:="https://github.com/intel/gmmlib"}
	if [[ ${PV%9999} != "" ]] ; then
		: ${EGIT_BRANCH:="release/${PV%.9999}"}
	fi
	inherit git-r3
fi

DESCRIPTION="Intel Graphics Memory Management Library"
HOMEPAGE="https://github.com/intel/gmmlib"
if [[ ${PV} == *9999 ]] ; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/intel/gmmlib/archive/intel-${P}.tar.gz"
	S="${WORKDIR}/${PN}-intel-${P}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-invalid-patch-version.patch"
	)

multilib_src_configure() {
	local mycmakeargs=(
		-DRUN_TEST_SUITE=OFF
	)

	cmake-utils_src_configure
}
