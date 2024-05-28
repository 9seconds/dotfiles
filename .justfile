# vim: set ft=just sts=2 ts=2 sw=2:

set shell := ["bash", "-cu"]

@default:
  just --list

[confirm]
@clean:
  git clean -fd
  rm -rf .venv

@setup: clean
  poetry self add -- poetry-plugin-up@latest
  poetry install --no-root


[group("update")]
@poetry-up:
  poetry up --latest

[group("update")]
@up: poetry-up


[group("lua")]
[group("format")]
@stylua +filename:
  stylua {{filename}}

[group("lua")]
[group("lint")]
@selene +filename:
  selene {{filename}}

@_lua +filename: (stylua filename) (selene filename)

[group("lua")]
@lua:
  fd -H -e lua -t f -X just _lua


[group("python")]
[group("format")]
@isort +filename:
  poetry run isort --atomic --jobs {{num_cpus()}} {{filename}}

[group("python")]
[group("lint")]
@mypy +filename:
  poetry run mypy --no-incremental {{filename}}

[group("python")]
[group("lint")]
@ruff-c +filename:
  ruff check --no-cache {{filename}}

[group("python")]
[group("format")]
@ruff-f +filename:
  ruff format --no-cache {{filename}}

@_python +filename: (isort filename) (mypy filename) (ruff-c filename) (ruff-f filename)

[group("python")]
@python: (_python "dots")
  fd -H -e py -t f -X just _python
