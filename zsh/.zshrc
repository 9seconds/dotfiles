#
# Antigen
#
source "$HOME/.zsh/antigen/antigen.zsh"
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  autojump
  command-not-found
  gitfast
  ssh-agent

  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen apply

source "$HOME/.zsh/init.sh"
source "$HOME/.zsh/functions.sh"
source "$HOME/.zsh/aliases.sh"
source "$HOME/.zsh/binds.sh"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"
