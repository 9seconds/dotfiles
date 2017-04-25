source "$HOME/.zsh/antigen/antigen.zsh"

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  autojump
  colored-man-pages
  command-not-found
  gitfast
  ssh-agent
  taskwarrior

  mafredri/zsh-async
  sindresorhus/pure

  hcgraf/zsh-sudo
  hlissner/zsh-autopair
  Tarrasch/zsh-bd

  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES
antigen apply

source "$HOME/.zsh/init.sh"
source "$HOME/.zsh/functions.sh"
source "$HOME/.zsh/aliases.sh"
source "$HOME/.zsh/binds.sh"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f "$HOME/.zshrc.private" ]] && source "$HOME/.zshrc.private"
