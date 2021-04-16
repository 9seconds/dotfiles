#!/usr/bin/env fish
#
# This file contains everything related to prompt.

not functions -q tide; and exit

set -g tide_left_prompt_items pwd virtual_env git cmd_duration newline prompt_char
set -g tide_right_prompt_items

set -g tide_prompt_char_icon ➜
set -g tide_chruby_icon
set -g tide_cmd_duration_icon
set -g tide_jobs_icon
set -g tide_nvm_icon
set -g tide_php_icon
set -g tide_prompt_char_vi_default_icon
set -g tide_prompt_char_vi_insert_icon
set -g tide_prompt_char_vi_replace_icon
set -g tide_prompt_char_vi_visual_icon
set -g tide_prompt_connection_icon
set -g tide_pwd_dir_icon
set -g tide_pwd_home_icon
set -g tide_pwd_unwritable_icon
set -g tide_rust_icon
set -g tide_status_failure_icon
set -g tide_status_success_icon
set -g tide_vi_mode_default_icon
set -g tide_vi_mode_insert_icon
set -g tide_vi_mode_replace_icon
set -g tide_vi_mode_visual_icon
set -g tide_virtual_env_icon
