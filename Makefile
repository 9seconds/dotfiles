# vim: set noet ft=make:

PYTHON_FILES := dots $(shell fd -H -e py)
PYTHON_TARGETS := $(addprefix black-,$(PYTHON_FILES)) \
				  $(addprefix flake8-,$(PYTHON_FILES)) \
				  $(addprefix isort-,$(PYTHON_FILES)) \
				  $(addprefix mypy-,$(PYTHON_FILES))

LUA_FILES := $(shell fd -H -e lua)
LUA_TARGETS := $(addprefix stylua-,$(LUA_FILES))
ALL_TARGETS = $(PYTHON_TARGETS) $(LUA_TARGETS)

.PHONY: $(PYTHON_FILES) $(PYTHON_TARGETS) \
		$(LUA_FILES) $(LUA_TARGETS)

python: $(PYTHON_FILES)
lua: $(LUA_FILES)
all: python lua

$(PYTHON_FILES): %: black-% flake8-% mypy-%

$(filter black-%,$(PYTHON_TARGETS)): black-%: isort-% .venv
	black $*

$(filter flake8-%,$(PYTHON_TARGETS)): flake8-%: black-% isort-% .venv
	flake8 $*

$(filter mypy-%,$(PYTHON_TARGETS)): mypy-%: .venv
	mypy $*

$(filter isort-%,$(PYTHON_TARGETS)): isort-%: .venv
	isort $*

$(LUA_FILES): %: stylua-%

$(filter stylua-%,$(LUA_TARGETS)): stylua-%:
	stylua $*

.venv:
	poetry install --sync

.PHONY: clean
clean:
	rm -rf .venv .mypy-cache

.PHONY: up
up: poetry-up

.PHONY: poetry-up
poetry-up:
	poetry up --latest
