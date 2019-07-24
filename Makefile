.PHONY: tangle all that help
.DEFAULT_GOAL := help

ANSIBLE_VAULT_PASSWORD_FILE := .vault_pass.txt
export ANSIBLE_VAULT_PASSWORD_FILE

#############
## Print help

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-25s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)


###########
## Ansible

all: tangle
	ansible-playbook -i inventory.yml cce.yml 

retry: tangle
	ansible-playbook --limit @/home/cayek/projects/opensource/bastion/bastion.retry -i inventory.yml cce.yml

that: tangle  ## run only task with that tag
	ansible-playbook -i inventory.yml cce.yml --tags "that" -vvv

emacs: tangle
	ansible-playbook -i inventory.yml cce.yml --tags "emacs"

org: tangle
	ansible-playbook -i inventory.yml cce.yml --tags "org"

r: tangle
	ansible-playbook -i inventory.yml cce.yml --tags "r"

inspiration: tangle
	ansible-playbook -i inventory.yml cce.yml --tags "inspiration"

requirements: tangle
	ansible-galaxy install -r requirements.yml

#########
## Tangle

tangle: cce.org  ## tangle the orgmode main file
	@emacs -Q --batch --eval "(progn (require 'ob-tangle) (dolist (file command-line-args-left) (with-current-buffer (find-file-noselect file) (org-babel-tangle))))" "$<"