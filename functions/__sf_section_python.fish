# pyenv
#

function __sf_section_pyenv -d "Show current version of venv/pyenv Python, including system."
	# ------------------------------------------------------------------------------
	# Configuration
	# ------------------------------------------------------------------------------

	__sf_util_set_default SPACEFISH_PYTHON_SHOW false
	__sf_util_set_default SPACEFISH_PYTHON_PREFIX $SPACEFISH_PROMPT_DEFAULT_PREFIX
	__sf_util_set_default SPACEFISH_PYTHON_SUFFIX $SPACEFISH_PROMPT_DEFAULT_SUFFIX
	__sf_util_set_default SPACEFISH_PYTHON_SYMBOL "🐍 "
	__sf_util_set_default SPACEFISH_PYTHON_COLOR yellow

	# ------------------------------------------------------------------------------
	# Section
	# ------------------------------------------------------------------------------

	# Show venv/pyenv python version
	[ $SPACEFISH_PYTHON_SHOW = false ]; and return

	# Check if the current directory running via Virtualenv
	# otherwise ensure the pyenv command is available
	test -n "$VIRTUAL_ENV"; or type -q pyenv; or return

	# Show venv/pyenv python version only for Python-specific folders
	if not test -n "$VIRTUAL_ENV" \
	    -o test -n "$PYENV_VERSION" \
		-o -f .python-version \
		-o -f requirements.txt \
		-o -f pyproject.toml \
		-o (count *.py) -gt 0
		return
	end

	if test -n "$VIRTUAL_ENV"
		set -l python_status (python -V | awk '{print $2}')
	else
		set -l python_status (pyenv version-name 2>/dev/null) # This line needs explicit testing in an enviroment that has pyenv.
	end

	__sf_lib_section \
		$SPACEFISH_PYENV_COLOR \
		$SPACEFISH_PYENV_PREFIX \
		"$SPACEFISH_PYENV_SYMBOL""$python_status" \
		$SPACEFISH_PYENV_SUFFIX
end
