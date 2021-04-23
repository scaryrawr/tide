function _tide_item_status
    if string match --quiet --invert 0 $_tide_last_pipestatus # If there is a failure anywhere in the pipestatus
        if test "$_tide_last_pipestatus" = 1 # If simple failure
            if not contains prompt_char $tide_left_prompt_items
                set -g tide_status_bg_color $tide_status_failure_bg_color
                set -g tide_status_color $tide_status_failure_color
                tide_status_icon=$tide_status_failure_icon _tide_print_item status 1
            end
        else
            if test $_tide_last_status = 0
                set -g tide_status_bg_color $tide_status_success_bg_color
                set -g tide_status_color $tide_status_success_color
                tide_status_icon=$tide_status_success_icon _tide_print_item status \
                    (fish_status_to_signal $_tide_last_pipestatus | string replace SIG '' | string join '|')
            else
                set -g tide_status_bg_color $tide_status_failure_bg_color
                set -g tide_status_color $tide_status_failure_color
                tide_status_icon=$tide_status_failure_icon _tide_print_item status \
                    (fish_status_to_signal $_tide_last_pipestatus | string replace SIG '' | string join '|')
            end
        end
    else if not contains prompt_char $tide_left_prompt_items
        set -g tide_status_bg_color $tide_status_success_bg_color
        set -g tide_status_color $tide_status_success_color
        tide_status_icon=$tide_status_success_icon _tide_print_item status
    end
end
