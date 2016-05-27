# Dotfiles

Replicates my command line ui.

# Dependencies

## fasd

a command line productivity booster

```
  git clone https://github.com/clvv/fasd
  cd fasd
  make install
```

see fasd/README.md for (much) more information

# Installation

Ensure all dependencies are satisfied and then run setup:

```
./setup
```

## setup

Saves any files/folders that it might overwrite to .old{timestamp} where timestamp is a tai64n format timestamp, then copies files and creates symbolic links to configure the environment.

