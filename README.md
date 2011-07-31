# Dotfiles 

This repository bundles the config file for 

  * autotest
  * bash
  * git
  * irbrc
  * ...

# Installation 

    cd
    git clone git@vdbsys2.intra.bmlv.at:dbsys-tools/dotfiles.git .dotfiles

    # create symlinks 
    
    cd 
    for item in $(find .dotfiles -maxdepth 1 -type f |grep -v README )
    do
        item=$(basename $item)
        ln -sv .dotfiles/$item .$item
    done

    
