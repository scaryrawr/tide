#!/bin/bash
set -e

# Install tide and test dependencies via fish/fisher
fish -c '
    type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher; end
    fisher install . >/dev/null
    type -q mock || fisher install IlanCosman/clownfish
'

# Download littlecheck test runner
curl -sL https://raw.githubusercontent.com/ridiculousfish/littlecheck/HEAD/littlecheck/littlecheck.py -o littlecheck.py
