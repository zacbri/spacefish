#!/usr/bin/env fish
# This will create a temporary fish and fisher installation to run tests within

set -l gitRoot (git rev-parse --show-toplevel)
set -l tmpDir /tmp/spacefish

# Install fisher if not installed in temporary fish env
if test ! -f $tmpDir/.config/fish/functions/fisher.fish
	curl https://git.io/fisher --create-dirs -sLo $tmpDir/.config/fish/functions/fisher.fish
end

# Install fishtape and local spacefish into temp env
env HOME=$tmpDir fish -c "fisher add jorgebucaran/fishtape $gitRoot"
env HOME=$tmpDir fish -c "fish_prompt"

if test (count $argv) -gt 0
	# Run an individual test file if it is provided as an argument
	env HOME=$tmpDir fish -c "fishtape $argv[1]"
else
	# Otherwise run all test files
	set -l currentDir (dirname (status --current-filename))
	env HOME=$tmpDir $currentDir/test.fish
end
