# vim: set ft=just sts=2 ts=2 sw=2:

set shell := ["bash", "-cu"]

# -----------------------------------------------------------------------------

alias e := edit

# -----------------------------------------------------------------------------

@default:
  just --list

@edit:
  $EDITOR {{justfile()}}

[confirm]
@clean:
  git clean -fd

@plug what:
  ./dots plug {{what}}

# -----------------------------------------------------------------------------

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

# -----------------------------------------------------------------------------

[group("python")]
[group("format")]
@isort +filename:
  isort --atomic --jobs {{num_cpus()}} {{filename}}

[group("python")]
[group("lint")]
@mypy +filename:
  mypy --no-incremental {{filename}}

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
@python: (_python "dots") (_python "bin/.bin/git-br")
  fd -H -e py -t f -X just _python
