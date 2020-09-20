export LANG="en_US.UTF-8"

export OPENAI_API_KEY=sk-no-key-required

# rvm ruby
export GEM_HOME="$HOME/.rvm/gems/ruby-3.1.2"
export GEM_PATH="$GEM_HOME:$HOME/.rvm/gems/ruby-3.1.2@global"

export GOPATH=$HOME/gocmd
export GOBIN=$GOPATH/bin

# mactex /usr/local/texlive/2022/bin/universal-darwin
PATH="$GOBIN:$HOME/.rvm/rubies/ruby-3.1.2/bin:$HOME/.rvm/gems/ruby-3.1.2/bin:/usr/local/bin:$HOME/.jenv/bin:$HOME/zls:/usr/local/texlive/2023/bin/universal-darwin":/Applications/Ghostty.app/Contents/MacOS:/nix/var/nix/profiles/default/bin
export PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/opt/libpq/bin

alias vim="nvim"

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ---
# copy 'n paste from https://github.com/Thomasdezeeuw/dotfiles/bash_profile
# Returns 1 if the branch is dirty, 0 otherwise.

#
# Note: only works if in a repo.
is_tree_clean() {
	git diff --quiet --ignore-submodules HEAD 2> /dev/null
}

# The current git branch.
git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

# Exit status is 0 if inside a git repo, 1 otherwise.
in_git_repo() {
	git rev-parse --is-inside-work-tree > /dev/null 2> /dev/null
}

# Get a clean directory for the prompt.
# When in a git repo this removes everything before the start of the root of the
# repo, also replaces the home directory with "~".
prompt_dir() {
	# Determine if we're in a git repo. If so we get the full path to the repo,
	# or we'll have an empty string.
	local GIT_DIR=$(git rev-parse --show-toplevel 2> /dev/null)

	if [ ! -z "$GIT_DIR" ]; then
		# If we're in a git repo we'll remove the entire path up to the repo
		# root directory, e.g. given a `GIT_DIR` of "~/src/repo_root" this will
		# be "~/src/".
		local GIT_TRIM_DIR=$(printf "$GIT_DIR" | rev | cut -d'/' -f2- | rev)
		local DIR=$(pwd -P | sed "s#^$GIT_TRIM_DIR/##")
	else
		# Replace the home directory path with "~/".
		local DIR=$(pwd | sed "s#^$HOME#~#")
	fi

	# Remove the last "/".
	printf "$DIR" | sed "s/\/$//"
}

# Set the foreground to a rgb color. Call syntax: `fg_color r255 g255 b255`.
fg_color() {
	printf "\[\x1b[38;2;$1;$2;$3m\]"
}

# The actual prompt.
prompt_command() {
	# Get exit code from previous command, get this here otherwise the commands
	# below will overwrite it.
	local EXIT=$?

	# Print a new line.
	printf "\r\n"

	# Start by resetting the colours.
	PS1="\[\e[0m\]"

	# Show when we're inside Vim.
	if [ -n "$IN_VIM" ]; then
		PS1+="$(fg_color 255 165 0)vim "
	fi
	# Show orange username@hostname, if in a ssh session.
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		PS1+="$(fg_color 255 165 0)\u@\h "
	fi

	PS1+="$(fg_color 93 200 253)$(prompt_dir) " # Blue directory.
	if in_git_repo; then
		# Orange pencil if the git tree is dirty.
		if ! is_tree_clean; then
			PS1+="$(fg_color 237 168 4)Σ "
		fi
		PS1+="$(fg_color 108 108 108)$(git_branch)" # Grey git branch, if in a repo.
	fi

	# Red on failure of the previous command, green otherwise.
	if [ $EXIT != 0 ]; then
		PS1+="$(fg_color 252 93 91)"
	else
		PS1+="$(fg_color 98 245 146)"
	fi
	PS1+="λ\[\e[0m\] " # A lambda and reset the colors.
}

export PROMPT_COMMAND=prompt_command

# No PS2 makes for easier copying.
export PS2=""
# Show file and line number when debugging scripts with `set -x`.
export PS4='+ $0:$LINENO '
# ---

# cd'ing using j
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
eval "$(jenv init -)"
. "$HOME/.cargo/env"

# opam configuration
test -r /Users/hoangtran/.opam/opam-init/init.sh && . /Users/hoangtran/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# direnv
if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi

complete -C /usr/local/bin/packer packer

# Created by `pipx` on 2023-02-28 16:58:42
export PATH="$PATH:$HOME/.local/bin"
