FILES = $(shell ls -1A | grep -E '^\.[a-zA-Z0-9]*' | grep -vE '^\.git(ignore|modules)' | grep -vE '^\.git$$')

clean:
	@echo $(FILES) | xargs -P1 -I%% -t -n1 rm $$HOME/%%

symlink:
	@for file in $(FILES); do \
		echo $$HOME/$$file; \
		[ -f $$HOME/$$file ] && [ ! -s $$HOME/$$file ] && mv -iv $$HOME/$$file $$HOME/$$file.`date '+%Y-%m-%d-%H:%M:%S'`; \
		ln -shf $$PWD/$$file $$HOME/$$file; \
	done

submodule:
	@git submodule update --init --recursive

all: symlink submodule

.PHONY: clean symlink submodule all
