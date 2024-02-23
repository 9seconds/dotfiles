# vim: set noet ft=make:

.PHONY: lua
lua:
	fd -H -e lua -X stylua

.PHONY: python
python: python-black python-isort python-flake8 python-mypy

python-%: .venv
	fd -H -e py -X poetry run $*

.venv:
	poetry install --sync

.PHONY: clean
clean:
	rm -rf .venv .mypy-cache
