#!/bin/bash

# This script connects the computer to a vpn server using openconnect without pain

prog_name=$(basename $0)
subcommand=$1
username=$2
server=$3

function help {
	echo "Usage: $prog_name [-u username] [-c server] [-d]"
	echo
	echo "Options"
	echo "    -c, --connect <subdomain>  Connect to the specified VPN server $server"
	echo "    -d, --disconnect           Disconnect the running VPN"
	echo
}

function connect {
	echo "Connecting to $server..."
	sudo openconnect -u $username -b $server
}

function disconnect {
	echo "Disconnecting..."
	sudo pkill -SIGINT openconnect
}

case $subcommand in
	"" | "-h" | "--help")
	help
	;;
	"-c" | "--connect")
	shift
	connect $@
	;;
	"-d" | "--disconnect")
	disconnect
	;;
	*)
	echo "Error: '$subcommand' is not a known command." >&2
	echo "       Run '$prog_name --help' for a list of known commands." >&2
	exit 1
	;;
esac
