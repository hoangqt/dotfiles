# Runs when opens terminal on Linux but MacOS may
# not follow this convention
alias k=kubectl
source <(kubectl completion bash)
complete -F __start_kubectl k

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C /usr/local/bin/terraform terraform

eval "$(direnv hook bash)"

eval "$(zoxide init bash)"
