# Consistent set of make tasks
.DEFAULT_GOAL := help # because is is a safe task.

clean:  # Remove the virtual environment.
	rm -rf .venv

.PHONY: help
help:  # Show the help for each of the recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

kill: # Kill the servers on ports 8090 to 8093 if they are still running.
	lsof -i tcp:8090-8093 | awk 'NR!=1 {print $$2}' | xargs kill 2>/dev/null || true

report:  # Repot the python version and list the installed pip packages.
	.venv/bin/python --version
	.venv/bin/python -m pip list -venv

test: # Run the integration tests.
	.venv/bin/python -m pytest ./tests

venv:  # Created the virtual environment
	python -m venv .venv
	.venv/bin/python -m pip install --requirement requirements.txt
