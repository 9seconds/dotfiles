#!/usr/bin/env fish
#
# This file contains all things related to locales

set -l locales (locale -a 2>/dev/null)

if contains en_US.utf8 $locales
  set locale_to_set en_US.utf8
else if contains en_US.UTF-8
  set locale_to_set en_US.UTF-8
else if contains C.UTF-8
  set locale_to_set C.UTF-8
end

if set -q locale_to_set
  set -gx LANG $locale_to_set
  set -gx LANGUAGE $locale_to_set
  set -gx LC_ALL $locale_to_set
end
