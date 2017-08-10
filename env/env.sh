
if test "x$SIMSCRIPTS_PROJECT_ENV" = "xtrue"; then
	export WB_SYS_IP=`dirname $SIMSCRIPTS_DIR`
fi

uname_o=`uname -o`

if test "$uname_o" = "Cygwin"; then
	WB_SYS_IP=`cygpath -w $WB_SYS_IP | sed -e 's%\\\\%/%g'`
fi

export STD_PROTOCOL_IF=$WB_SYS_IP/std_protocol_if
export SV_BFMS=$WB_SYS_IP/ve/sv_bfms
export MEMORY_PRIMITIVES=$WB_SYS_IP/memory_primitives

