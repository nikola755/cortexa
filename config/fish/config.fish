if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # Better ls
    command -v eza &> /dev/null && alias ls='eza --icons --group-directories-first -1'
    # sudo pacman -S eza

    # ls
    abbr l 'ls'
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'

    # aliases
    alias i="sudo pacman -S"
    alias r="sudo pacman -R"
    alias up="sudo pacman -Syu"

    alias p="paru -S"
    alias f="fastfetch"
    alias sf="somefetch"

    # etc
    alias n='nvim'
    abbr c 'clear'
    alias wtf="pwd"

end

function fish_greeting
  fastfetch  
end
