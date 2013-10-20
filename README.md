# Dotfiles 

This repository bundles the config files for 

  * bash
  * git

# Installation 

    cd
    git clone https://github.com/sohooo/dotfiles.git .dotfiles

    # create symlinks 
    for item in $(find .dotfiles -maxdepth 1 -type f |grep -v README )
    do
        item=$(basename $item)
        ln -sv .dotfiles/$item .$item
    done

    
