#!/bin/bash

# Simple defaults browser for ginas project
# https://github.com/ginas/ginas/

# Script uses 'view' command from vim package as convinient pager

# Tips:
#  - you can search for "role:" to jump between roles
#  - run without options to browse all defaults
#  - specify list of role names separated by spaces to see only those roles
#  - pipe to a command or file to manipulate output (for example grep)


if [ $# -gt 0 ]; then
	role_list=${@}
fi

function aggregate_defaults() {
	if [ -n "${role_list}" ]; then
		for role in ${role_list}; do
			cat playbooks/roles/${role}/defaults/main.yml
		done
	else
		cat playbooks/roles/*/defaults/main.yml
	fi
}

if [ -t 1 ]; then
	# if script is run as standalone, redirect to view
	( aggregate_defaults ) | view '+set ft=yaml' -
else
	# else, send everything to stdout
	aggregate_defaults
fi

