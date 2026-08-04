#!/bin/bash
if [[ -n "${DEBUG:-}" ]]; then
	set -x
fi

set -eu
# no -o pipefail, we rely on a final `cat` to ignore pipefail
# delay set -x until we do startup detection

distro="$(lsb_release -si)"
release="$(lsb_release -sc)"
echo "Updating ${distro} ${release}"

holds=
cleanup_debian() {
	# separate tests rather than -a, which POSIX deprecated and which misbehaves on odd filenames
	if [ -n "$holds" ] && [ -f "$holds" ]; then
		sudo dpkg --set-selections < "$holds"
	fi
}

trap cleanup_debian EXIT

confirm() {
	local reply
	read -r -p "$1 [y/N] " reply
	case "$reply" in
		[yY] | [yY][eE][sS]) return 0 ;;
		*) return 1 ;;
	esac
}

sudo apt update || confirm 'apt update failed. Continue anyway?'
sudo apt full-upgrade --fix-missing || confirm 'full-upgrade failed. Continue anyway?'
sudo apt autoremove

# deborphan can fail if held packages have triggers
holds=$(mktemp)
# cat at the end of the pipe so that no holds doesn't create an error
dpkg --get-selections | grep '[[:space:]]hold$' | cat >"$holds"
cat "$holds" | sed -e 's/hold$/install/' | sudo dpkg --set-selections
sudo dpkg --configure -a
# cleanup EXIT hook will deal with undoing this if orphaner fails otherwise

# orphaner used to come from deborphan package... but it's gone
# sudo orphaner --guess-all

# don't allow the un-holding to affect later stuff
sudo dpkg --set-selections <"$holds"
rm -f "$holds"

sudo apt autoclean

# touch key stamp files associated with unattended-upgrades package
sudo touch -c /var/lib/apt/periodic/{update,download-upgradeable,upgrade,unattended-upgrades}-stamp

# fwupdmgr comes from fwupd package
sudo fwupdmgr get-updates
sudo fwupdmgr update
