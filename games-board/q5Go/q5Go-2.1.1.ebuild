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

inherit desktop qmake-utils xdg-utils ${SCM}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="
    dev-qt/qtgui
    dev-qt/qtsvg
    dev-qt/qtmultimedia
    doc? (
        app-text/pandoc
    )
    "
RDEPEND="${DEPEND}"

QA_PREBUILT=""

S="${WORKDIR}/q5Go-q5go-${PV}"


src_configure() {
    eqmake5 ${S}/src/q5go.pro
}

src_compile() {
    emake
}

src_install() {
    dobin ${PN,,}
    make_desktop_entry "${PN,,}" "q5Go" "/usr/share/icons/Bowl.png" "Game"
    doicon "${S}/src/images/clientwindow/Bowl.png" -s 32
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
    xdg_mimeinfo_database_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
    xdg_mimeinfo_database_update
}
