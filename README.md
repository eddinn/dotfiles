# dotfiles

## How to manage dotfiles with GNU stow

### Installation, setup and usage

A set of simple instructions to help you get started
Now let’s create a folder to get started. You can manage your dotfiles repo anywhere. I keep it along side my other code in `~/Prog/dotfiles.` So from here on, I will just refer to it as `$DOT`.

**Clone the dotfiles git repo, export the path and ```cd``` into it:**

```bash
# Create the dir structure you want, or cd into your current project folder
cd ~/Prog
git clone git@github.com:eddinn/dotfiles.git
export DOT=$HOME/Prog/dotfiles
cd $DOT
```

**Remember to replace or modify the dotfiles to your needs:**

```bash
mv ~/.zshrc $DOT/zsh
mv ~/.gitconfig $DOT/git
mv ~/.bashrc $DOT/bash
# You can also move .bash_profile and .profile if you have them
mv ~/.bash_profile $DOT/bash
mv ~/.profile $DOT/bash
```

**Example usage of the `stow` command:**

```bash
stow -v -R -t ~ git
# Output
LINK: .gitconfig => code/dotfiles/git/.gitconfig
ls -latr ~ | grep .git
# Output
lrwxrwxrwx  1 USER USER       28 jun 21 16:55 .gitconfig -> Prog/dotfiles/git/.gitconfig
```

`-v` is verbose, `-R` is recursive, and `-t ~` is the target directory, e.g your Home (`$HOME`) directory.

### The `stowit.sh` script

**Here are the contents of the ```stowit.sh``` script:**

```bash
#!/usr/bin/env bash
# Make sure we have pulled in and updated any submodules
git submodule init
git submodule update
# What directories should be installable by all users including the root user
base=(
    bash
)
# Folders that should, or only need to be installed for a local user
useronly=(
    git
)
# Run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr=$1
    app=$2
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${usr} ${app}
}
echo -e 'Stowing apps for user: ' "${whoami}"
# Install apps available to local users and root
for app in ${base[@]}; do
    stowit "${HOME}" $app
done
# Install only user space folders
for app in ${useronly[@]}; do
    if [[! "$(whoami)" = *"root"*]]; then
        stowit "${HOME}" $app
    fi
done
echo -e '\nAll done!'
```

As you can see, it's relatively straight forward and simple to use..
In the code above, we will install the git directory for only the local user as root doesn’t need that. However bash which we will do next, can be used for both local users and root. We then create a bash function named stowit to run the actual stow command with our required arguments.
The first loop is to install folders for any user, and the second has a check to install for any user unless it is the root user. So lets setup the bash directory.

**So lets run it to install our dotfiles:**

```bash
# Make the stowit.sh file executable
chmod a+x stowit.sh
# Run stowit.sh
./stowit.sh
# Output
Stowing apps for user:
LINK: .profile => Prog/dotfiles/bash/.profile
LINK: .bashrc => Prog/dotfiles/bash/.bashrc
LINK: .gitconfig => Prog/dotfiles/git/.gitconfig
LINK: .zshrc => Prog/dotfiles/zsh/.zshrc

All done!
```

You can see that stow is pretty smart about linking our files and folders. It linked our new bash files. But when we ran stow again it went through our previously linked git files, re re-linked them. You can actually configure how that handles those situations with different flags. stow will also abort stowing folders when it finds new files that have not been stowed before and will tell you what files so you can fix them.
To install the files for root, simply use ```sudo```

```bash
sudo ./stowit.sh
```

**The `bin` directory**

Inside the `$DOT/bin/bin` folder we can place any binary files and scripts we want to keep around for our system.

**Add export path to `.zshrc` or `.bashrc`:**

```bash
# Example with .zshrc
vim ~/.zshrc
export PATH="$HOME/bin:$PATH"
source ~/.zshrc
# Lets check and verify our path
echo $PATH
/home/USER/bin:/home/USER/.local/bin:/home/USER/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin
```

We now have `/home/USER/bin` in our path where we can use to store all our scripts and files that we need to run in our environment as an alternative to `/usr/local/bin`.
