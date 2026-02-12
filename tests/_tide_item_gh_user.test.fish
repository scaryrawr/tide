# RUN: %fish %s

function _gh_user
    _tide_decolor (_tide_item_gh_user)
end

set -lx tide_gh_user_icon 

set -l gh_hosts_file $HOME/.config/gh/hosts.yml
set -l backup_hosts_file

# Backup existing hosts.yml if it exists
if test -f $gh_hosts_file
    set backup_hosts_file (mktemp)
    cp $gh_hosts_file $backup_hosts_file
end

# No hosts.yml → no output
command rm -f $gh_hosts_file
_gh_user # CHECK:

# Create a mock hosts.yml
mkdir -p (path dirname $gh_hosts_file)
printf 'github.com:\n    git_protocol: https\n    users:\n        testuser:\n    user: testuser\n' >$gh_hosts_file

_gh_user # CHECK:  testuser

# Restore original hosts.yml or remove test file
if test -n "$backup_hosts_file"
    cp $backup_hosts_file $gh_hosts_file
    command rm -f $backup_hosts_file
else
    command rm -f $gh_hosts_file
end
