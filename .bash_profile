# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,custom_aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

###-tns-completion-start-###
if [ -f ~/.tnsrc ]; then
    source ~/.tnsrc
fi
###-tns-completion-end-###

if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

# Powerline
if [ -f /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi


export NVM_DIR="~/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

###-tns-completion-start-###
if [ -f ~/.tnsrc ]; then
    source ~/.tnsrc
fi
###-tns-completion-end-###

# Load direnv
eval "$(direnv hook bash)"

# PATH
export PATH='~/.rvm/gems/ruby-1.9.2-p320/bin:~/.rvm/gems/ruby-1.9.2-p320@global/bin:~/.rvm/rubies/ruby-1.9.2-p320/bin:~/.rvm/bin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/Applications/apache-ant-1.9.2/bin/:~/Development/android/sdk/tools/:~/Development/android/sdk/platform-tools/'
export PATH=${PATH}:/Development/android-sdk-macosx/platform-tools:/Development/android-sdk-macosx/tools:/Users/mgechev/Development/wabt/out/clang/Debug:$HOME/Library/Haskell/bin
export PATH=$GOPATH/bin:$PATH
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:/usr/local/git/bin
export PATH="/usr/local/heroku/bin:$PATH"
export PATH=/usr/texbin:$PATH
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH="$PATH:/usr/local/git/bin:$HOME/.golang/bin"
export PATH="$PATH:$DART_SDK/bin"
export PATH="$PATH:/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:/usr/texbin:/usr/local/heroku/bin:~/bin:/bin:/opt/local/bin:/opt/local/sbin:~/.rvm/gems/ruby-2.0.0-p576/bin:~/.rvm/gems/ruby-2.0.0-p576@global/bin:~/.rvm/rubies/ruby-2.0.0-p576/bin:~/.rvm/bin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/Applications/apache-ant-1.9.2/bin:~/Development/android/sdk/tools:~/Development/android/sdk/platform-tools/:/Development/android-sdk-macosx/platform-tools:/Development/android-sdk-macosx/tools:/usr/local/git/bin:~/.rvm/bin:/usr/local/git/bin:/usr/local/opt/dart/libexec/bin:/Applications/Julia-0.6.app/Contents/Resources/julia/bin"
export PATH="$HOME/.node/bin:$PATH"
export PATH="$PATH:$HOME/.npm-packages/bin";

export ANDROID_HOME=~/Development/android/sdk
export TERMINFO="$HOME/.terminfo"

export GOPATH="$HOME/Projects/golang"
export DARTIUM_BIN="/usr/local/opt/dart/Chromium.app"
export DART_SDK="/usr/local/opt/dart/libexec"
export ANDROID_HOME="/usr/local/Cellar/android-sdk/24.4/"
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

