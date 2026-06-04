# ZSH envioronment

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-256color
export DEFAULT_USER=$USER
export EDITOR='nvim'
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH

# Zinit
export PATH=$ZPFX/bin:$PATH

# Cask
export PATH=$HOME/.cask/bin:$PATH

# Golang
export GO111MODULE=auto
export GOPROXY=https://goproxy.io,direct
export GOPATH=$HOME/go
export PATH=${GOPATH//://bin:}/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH


export ANTHROPIC_BASE_URL="https://www.88code.org/api"
export ANTHROPIC_AUTH_TOKEN="88_b1775d5dcc13dcff231cd7b3a720af033c71d409710ae9e4eb28d954bce72bc1"
export OPENAI_BASE_URL="https://www.88code.org/openai/v1"
export OPENAI_API_KEY="88_0d638d06899b97385520e08083e9e6d4e7d4a24d27f2b647b890f6bd8d8ac1a4"
export GEMINI_API_KEY="AIzaSyABxuillfTnWfOFRNjEteMOmBMZedDPgfU"
. "$HOME/.cargo/env"

