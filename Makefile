.PHONY: install clean adopt zplug

install: zplug
	stow -t $(HOME) base

zplug:
	@[ -d $(HOME)/.zplug ] || git clone https://github.com/zplug/zplug $(HOME)/.zplug

clean:
	stow -D -t $(HOME) base

adopt:
	stow --adopt -t $(HOME) base
