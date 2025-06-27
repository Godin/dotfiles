install:
	@ln -sfnv $(PWD)/zsh/.zshrc.symlink $(HOME)/.zshrc
	@ln -sfnv $(PWD)/zsh/dircolors $(HOME)/.dircolors
	@ln -sfnv $(PWD)/tmux/.tmux.conf.symlink $(HOME)/.tmux.conf
	@ln -sfnv $(PWD)/git/.gitconfig.symlink $(HOME)/.gitconfig
	@ln -sfnv $(PWD)/git/.gitignore.symlink $(HOME)/.gitignore
	@ln -sfnv $(PWD)/git/.git-commit-template.symlink $(HOME)/.git-commit-template
	@ln -sfnv $(PWD)/mercurial/.hgrc.symlink $(HOME)/.hgrc
	@ln -sfnv $(PWD)/mercurial/.hgignore.symlink $(HOME)/.hgignore
	@ln -sfnv $(PWD)/emacs/.emacs $(HOME)/.emacs
	@ln -sfnv $(PWD)/vim/.vimrc.symlink $(HOME)/.vimrc
	@ln -sfnv $(PWD)/vim/ideavimrc $(HOME)/.ideavimrc
	@ln -sfnv $(PWD)/vscode/settings.jsonc $(HOME)/Library/Application\ Support/Cursor/User/settings.json
