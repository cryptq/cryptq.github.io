#!/bin/sh -

cd "`dirname "$0"`"

# for the manifest

manifestfile="manifest.xml"
if [ $# -eq 1 ]; then
	if [ $1 == "-info" ]; then
		if [ -e $manifestfile ]; then
# 			cat $manifestfile
#			cat $manifestfile 2>&1 | tee info.log ; (grep -v time/point info.log 1>&2)
			echo "**** Reading manifest file '$manifestfile' **** "
			grep -v time/point $manifestfile 1>&2
			exit 0
		fi
		echo "cannot find circuit manifest file ('$1')"
		exit 1
	fi
fi

if [ $# -lt 3 ]; then
	echo 1>&2 "Usage: $0 server readport writeport [other-arguments]"
	exit 1
fi

server="$1"
p1="$2"
p2="$3"
shift 3


if [ -z $XPEDION ]; then
    echo "Error: Environment variable \$XPEDION is not defined in '~/.sh'." 1>&2
    exit 1
fi


if [ -z $GOLDENGATE_LICENSE_FILE ]; then
    echo "Error: Environment variable \$XPEDION is not defined in `~/.sh`." 1>&2
    exit 1
fi


# if [ "$server" != localhost -a -n "$SSH_CONNECTION" ]; then
# 	server="`echo "${SSH_CONNECTION%% *}" | cut -d: -f4`"
# fi

if [ "$server" = "RESOLVE_SSH_CLIENT" ]; then
	server="`echo $SSH_CLIENT | cut -d: -f4 | cut -d\  -f1`"
fi

netlist="SIM_IQ_MOD_ENV_ET.gpp"

outputdir=`pwd`/run

RECORD=
# uncomment this to setup record mode (i/o ouptut will be created at <root>/run/record
# RECORD="-record"
if [ -n "" ]; then
        RECORD="-record"
fi

DEBUGGER=
# uncomment this to have liana pause after its start, allowing one to attach a debugger
# to its process (for internal debug only)
# DEBUGGER="-attach_debugger"

logfile="goldengate.out"

exec "$XPEDION/bin/runGoldenGateClient.sh" "$netlist" -o $outputdir  -server "$server" $RECORD $DEBUGGER -p1 "$p1" -p2 "$p2" "$@"
