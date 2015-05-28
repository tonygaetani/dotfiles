#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# check dependencies
DEPENDENCIES=($(cat dependencies.txt))
for dep in "${DEPENDENCIES[@]}"
do
	if [[ -z $(which "${dep}") ]]; then
		echo "missing dependency: ${dep}"
		exit 100;
	fi
done

# setup
OLDDIR=.old$(echo "" | tai64n)
DOTFILES=(~/.profile \
~/.bash_profile \
~/.zshrc \
~/.zsh \
~/.zsh-git-prompt \
~/.vimrc \
~/.vim \
~/.tmux.conf \
~/.tmux \
~/.oh-my-git \
~/.antigen)
BASEDIR=$(pwd)

# remove the old files
mkdir -p "${OLDDIR}"
for file in "${DOTFILES[@]}"
do
	# we don't care if this fails, hence the || true
	mv "${file}" "${OLDDIR}" > /dev/null 2>&1 || true
done

# profile is a copy, not a symbolic link
cp "${BASEDIR}/shell/profile" ~/.profile
if [[ "$(uname -a)" == "*Darwin*" ]]; then
	echo 'set-option -g default-command "reattach-to-user-namespace -l zsh"' >> ~/.profile
fi

# add environment vars to profile
for file in $(/bin/ls "${BASEDIR}/shell/env")
do
	echo $(basename "${BASEDIR}/shell/env/${file}")=$(cat "${BASEDIR}/shell/env/${file}") >> ~/.profile
done

# bash
ln -s "${BASEDIR}/shell/bash_profile" ~/.bash_profile

# zsh
ln -s "${BASEDIR}/shell/zshrc" ~/.zshrc

# vim
ln -s "${BASEDIR}/vim/vimrc" ~/.vimrc
ln -s "${BASEDIR}/vim/" ~/.vim

# tmux configuration
ln -s "${BASEDIR}/tmux/tmux.conf" ~/.tmux.conf

