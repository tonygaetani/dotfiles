# Dotfiles

Replicates my command line ui.

## How it Works

My main tools are bash, vim, tmux, and fasd. When bash starts, it will source ~/.bash_profile which just sources ~/.bashrc. ~/bashrc does all of it's bash-specific stuff, and then sources ~/.profile which does non-bash-specific stuff as well as sourcing everything in the ~/.profile.d directory.

```
bash -> bash_profile -> bashrc -> profile -> profile.d
```

# Dependencies

Start by making sure vim, tmux, and a recent version of bash is installed.

## fasd

A command line productivity booster.

```
  git clone https://github.com/clvv/fasd
  cd fasd
  make install
```

See fasd/README.md for (much) more information.

# Installation

Ensure all dependencies are satisfied and then run setup:

```
./setup
```

## setup

Saves any files/folders that it might overwrite to .old{timestamp}, then copies files and creates symbolic links to configure the environment.
