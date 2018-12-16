#!/usr/bin/env fish
# This will run tests on your local fish installation

set -l currentDir (dirname (status --current-filename))
set -l testDir $currentDir/../tests
fish -c "fishtape $testDir/*.test.fish"
