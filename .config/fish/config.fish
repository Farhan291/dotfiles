set -gx EDITOR nvim
set -gx VISUAL nvim

# --- Auto-start SSH agent ---
if not set -q SSH_AUTH_SOCK
    eval (ssh-agent -c)
end

# --- Auto-add key if not already added ---
ssh-add -l >/dev/null 2>&1; or ssh-add ~/.ssh/id_ed25519_main

function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source

    # Aliases
    alias ls 'eza --icons'
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias lg 'lazygit'
    alias ssh_phone="ssh -p 8022 u0_a662@192.168.1.4"
    alias gcc="/usr/bin/gcc -O2 -Wall -Wextra"
    alias g++="/usr/bin/g++ -O2 -Wall -Wextra"
    alias v="nvim"
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias ......='cd ../../../../..'
    alias sysd='systemd-manager-tui'
    alias ping='ping google.com'
    alias pingip= 'ping 8.8.8.8'
    
    # Fedora
    alias up='sudo dnf upgrade'
    alias i='sudo dnf install'
    
end
set -gx PATH $PATH /home/light/.dotnet/tools
fish_add_path /usr/local/go/bin
#yazi setup
function y
    set tmp (mktemp -t "yazi_cwd.XXXXXX")

    yazi $argv --cwd-file=$tmp

    if test -s $tmp
        cd (cat $tmp)
    end

    rm -f $tmp
end

#zoxide 
zoxide init fish | source


# pnpm
set -gx PNPM_HOME "/home/light/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
# Install Ruby Gems to ~/gems
set -gx GEM_HOME $HOME/gems
set -gx PATH $HOME/gems/bin $PATH
set -U fish_user_paths $fish_user_paths ~/.opencode/bin
set --export BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

#odin 
set -gx ODIN_ROOT $HOME/.local/odin 
set -gx PATH $ODIN_ROOT $PATH
