# Dotfiles
Replicates my command line ui.

# Dependencies
See dependencies.txt, all commands must be discoverable by `which`.

### tai64n

a precise timestamp utility provided by daemontools
```
  apt-get install daemontools
```

```
  brew install daemontools
```

### fasd

a command line productivity booster
```
  git clone https://github.com/clvv/fasd
  cd fasd
  make install
```

see fasd/README.md for (much) more information

# Installation
Install all dependencies are satisfied and then run setup.bash.

### setup.bash

Saves any files/folders that it might overwrite to .old{timestamp} where timestamp is a tai64n format timestamp, then copies files and creates symbolic links to configure the environment.

# Other
My iTerm2 configuration files are also included, but not set up by `setup.bash`.