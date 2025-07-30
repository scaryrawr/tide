function _tide_item_gh_user
    # Default icon
    set -q tide_gh_user_icon; or set -l tide_gh_user_icon ''

    # Default config path
    set -l gh_hosts_file ~/.config/gh/hosts.yml
    set -l user

    if test -f $gh_hosts_file
        # Find the first 'user:' line after a host (e.g. github.com:)
        set user (cat $gh_hosts_file | string match -rg '^[ ]*user:[ ]*(.+)$')
    end

    if test -n "$user"
        _tide_print_item gh_user $tide_gh_user_icon' '$user
    end
end
