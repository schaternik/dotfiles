# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yyyy"

# Plugins
plugins=(
  docker
  docker-compose
  fast-syntax-highlighting
  git
  minikube
  zsh-autocomplete
  zsh-autosuggestions
  # zsh-syntax-highlighting # disabled in favor of fast-syntax-highlighting
)

# brew completions
if (( $+commands[brew] )) then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit
compinit

# get zsh complete kubectl
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
  compdef kubecolor=kubectl # bind autocompletion for kubecolor from kubectl
  compdef k=kubectl # bind autocompletion for k from kubectl
fi

# --- Check Kubernetes tools ---
for cmd in kubectl kubectx kubens kubecolor; do
  if ! (( $+commands[$cmd] )); then
      echo "⚠️ $cmd is not installed"
  fi
done

# ENV vars
export KUBECOLOR_PRESET="light"
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# Aliases
alias kubectl=kubecolor
alias k=kubectl
alias kctx=kubectx
alias kns=kubens

# Start oh-my-zsh
source "$ZSH/oh-my-zsh.sh"
