# Dotfiles

Replicates my command line ui.

## How it Works

My main tools are bash, vim, tmux, and fasd. When bash starts, it will source ~/.bash_profile which just sources ~/.bashrc. ~/bashrc does all of it's bash-specific stuff, and then sources ~/.profile which does non-bash-specific stuff as well as sourcing everything in the ~/.profile.d directory.

```
bash -> bash_profile -> bashrc -> profile -> profile.d
```

Because ~/.profile is re-sourced by every interactive shell, anything it does has to be safe to run twice. Use the `path_prepend`/`path_append` helpers it defines rather than assigning to PATH directly.

~/.profile.d is where context-specific config lives, untracked files here are common.

# Dependencies

```
sudo apt install bash git vim tmux fasd
```

`setup` warns about anything missing but still lays the configs down.

# Installation

```
./setup
```

## setup

Creates symlinks into the home directory. Anything it would overwrite that isn't already one of its own links is moved to ~/.old{timestamp} first, so re-running it is safe and leaves no new backups behind.
