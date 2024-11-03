set -x GPG_TTY tty

alias reload 'source ~/.config/fish/config.fish'

# Define the path to private.fish
set private_fish_path "$HOME/.config/fish/private.fish"

# Check if private.fish exists, and create it if it doesn't
if not test -f $private_fish_path
    touch $private_fish_path
    echo "# Private Fish configuration" > $private_fish_path
    echo "set -x MY_CODE $HOME/code" >> $private_fish_path
    echo "Created $private_fish_path for private variables and custom configuration."
end

# Source private.fish if it exists
if test -f $private_fish_path
    source $private_fish_path
end

if test -d $MY_CODE/devops/docs/scripts/fish
    source $MY_CODE/devops/docs/scripts/fish/go.fish
    source $MY_CODE/devops/docs/scripts/fish/k8s.fish
    source $MY_CODE/devops/docs/scripts/fish/sdlc.fish
    set -x PATH $MY_CODE/devops/docs/scripts/bin $PATH
end

set -x PATH $MY_CODE/devops/bin $PATH

set -x PATH /opt/homebrew/bin /opt/homebrew/sbin $PATH
set -x PATH ~/Library/Application\ Support/JetBrains/Toolbox/scripts $PATH

set -x LSCOLORS
