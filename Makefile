.PHONY: install clean adopt

install:
	@[ -d $(HOME)/.zplug ] || git clone https://github.com/zplug/zplug $(HOME)/.zplug
	stow -t $(HOME) base

clean:
	stow -D -t $(HOME) base

adopt:
	stow --adopt -t $(HOME) base
