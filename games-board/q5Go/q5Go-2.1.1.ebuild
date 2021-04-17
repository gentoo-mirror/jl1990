# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="This is a tool for Go players"
HOMEPAGE="https://github.com/bernds/q5Go"
RESTRICT="mirror strip bindist"

if [[ ${PV} == "9999" ]]; then
	SCM="git-r3"
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/bernds/q5Go.git"
	EGIT_BRANCH="develop"
else
	SRC_URI="https://github.com/bernds/q5Go/archive/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit eutils desktop xdg-utils ${SCM}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-qt/qtgui-5.15.2-r1"

DESTPATH="/opt/${PN}"

QA_PREBUILT="${DESTPATH}/${PN}"

S="${WORKDIR}/q5Go-q5go-${PV}"


src_compile() {
	qmake ${S}/src/q5go.pro PREFIX=${DESTPATH} || die "build failed"
    make || die "build failed"
}

src_install() {
	insinto ${DESTPATH}
	exeinto ${DESTPATH}
	doexe ${PN}

    dosym "../../${DESTPATH}" "/usr/bin/${PN}"
    make_desktop_entry "${PN}" "q5Go" "${PN}" "Games"
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_mimeinfo_database_update
}
