function _tide_decolor
    string replace --all -r '\e(\[[\d;]*|\(B\e\[)m(\co)?' '' "$argv"
end
funcsave _tide_decolor

echo "\
set TERM xterm-256color
set -g _tide_side right
set -g _tide_pad ''
set -g tide_left_prompt_separator_diff_color ''
set -g tide_right_prompt_separator_diff_color ''
set -g tide_left_prompt_separator_same_color ''
set -g tide_right_prompt_separator_same_color ''
set -g tide_left_prompt_prefix ''
set -g tide_right_prompt_prefix ''
set -g tide_cmd_duration_icon ''
set -g tide_git_icon ''" >$__fish_config_dir/conf.d/tide_test_setup.fish
