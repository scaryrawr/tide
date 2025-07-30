# Test for _tide_item_gh_user

set -l test_hosts_file (mktemp)
set -l gh_hosts_file $HOME/.config/gh/hosts.yml
set -l backup_hosts_file

# Backup existing hosts.yml if it exists
if test -f $gh_hosts_file
    set backup_hosts_file (mktemp)
    cp $gh_hosts_file $backup_hosts_file
end

# Prepare a mock hosts.yml
mkdir -p ~/.config/gh
printf 'github.com:\n    git_protocol: https\n    users:\n        testuser:\n    user: testuser\n' > $test_hosts_file
cp $test_hosts_file $gh_hosts_file

# Set icon and color for test
set -g tide_gh_user_icon 'ï'
set -g tide_gh_user_color 0087AF
set -g tide_gh_user_bg_color normal

# Capture output
set -g _tide_side right
set -l output (_tide_item_gh_user)

# Clean up test files
rm $test_hosts_file

# Restore original hosts.yml or remove test file
if test -n "$backup_hosts_file"
    cp $backup_hosts_file $gh_hosts_file
    rm $backup_hosts_file
else
    rm $gh_hosts_file
end

# Assert output contains icon and username
string match -q '*ï testuser*' -- $output
