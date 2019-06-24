#!/usr/bin/env bash

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

USERNAME=$(whoami)

# what directories should be installable by all users including the root user
base=(
    bash
    zsh
)

# folders that should, or only need to be installed for a local user
useronly=(
    git
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    USR=$1
    APP=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t "$USR" "$APP"
}

echo ""
echo "Stowing apps for user: $USERNAME"

# install apps available to local users and root
for APP in "${base[@]}"; do
    stowit "$HOME" "$APP" 
done

# install only user space folders
for APP in "${useronly[@]}"; do
    if [[ ! "$USERNAME" = *"root"* ]]; then
        stowit "$HOME" "$APP" 
    fi
done
