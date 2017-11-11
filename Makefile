SHELL = /usr/bin/env bash -euo pipefail
KARABINER_CONFIG = .config/karabiner/karabiner.json
DOT_FILES = $(shell ls -1A | grep -E '^\.[a-zA-Z0-9]*' | grep -vE '^\.git(ignore|modules)|\.config' | grep -vE '^\.git$$')

clean:
	@echo $(DOT_FILES) | xargs -P1 -I%% -t -n1 rm $$HOME/%%

make_directory:
	@[[ -d $$HOME/.aws ]] || mkdir $$HOME/.aws
	@[[ -d $$HOME/.config/karabiner ]] || mkdir -p $$HOME/.config/karabiner

# FIX: karabiner does't support symlink?
copy_karabiner_config:
	@cp -pv $$PWD/$(KARABINER_CONFIG) $$HOME/$(KARABINER_CONFIG)

symlink: make_directory copy_karabiner_config
	@for dot_file in $(DOT_FILES); do \
		[[ $$dot_file == ".aws" ]] && dot_file=".aws/cli/alias"; \
		dot_file_source=$$PWD/$$dot_file; \
		dot_file_target=$$HOME/$$dot_file; \
		[[ -f $$dot_file_target && ! -s $$dot_file_target ]] \
			&& mv -iv $$dot_file_target $$dot_file_target.$$(date '+%Y-%m-%d-%H:%M:%S'); \
		ln -shf $$dot_file_source $$dot_file_target; \
	done

submodule:
	@git submodule update --init --recursive

all: symlink submodule

.PHONY: clean make_directory copy_karabiner_config symlink submodule all
