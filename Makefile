install:
	@ln -sfnv $(PWD)/zsh/.zshrc.symlink $(HOME)/.zshrc
	@ln -sfnv $(PWD)/tmux/.tmux.conf.symlink $(HOME)/.tmux.conf
	@ln -sfnv $(PWD)/git/.gitconfig.symlink $(HOME)/.gitconfig
	@ln -sfnv $(PWD)/git/.gitignore.symlink $(HOME)/.gitignore
	@ln -sfnv $(PWD)/git/.git-commit-template.symlink $(HOME)/.git-commit-template
	@ln -sfnv $(PWD)/emacs/.emacs $(HOME)/.emacs
	@ln -sfnv $(PWD)/vim/.vimrc.symlink $(HOME)/.vimrc
