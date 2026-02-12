# RUN: %fish %s
_tide_parent_dirs

function _gh_user
    _tide_decolor (_tide_item_gh_user)
end

set -l tmpdir (mktemp -d)
set -lx HOME $tmpdir
set -lx tide_gh_user_icon 
set -l gh_hosts_file $HOME/.config/gh/hosts.yml

# No hosts.yml → no output
command rm -f $gh_hosts_file
_gh_user # CHECK:

# Create a mock hosts.yml
mkdir -p (path dirname $gh_hosts_file)
printf 'github.com:\n    git_protocol: https\n    users:\n        testuser:\n    user: testuser\n' >$gh_hosts_file

_gh_user # CHECK:  testuser

command rm -r $tmpdir
