#!/bin/sh

#-------------------------------------------------------
# File: execute_stored_procedure.sh
# Desc: Perform Execute - Single Stored Procedure
# Runs: Four Times per Month = 0 0 1,8,15,22 * *
# Parm: 1 - Stored Procedure Owner
# Parm: 2 - Stored Procedure to Execute
# Parm: 3 - String for Parameter list "('a','b',1,2)"
#-------------------------------------------------------
#  1.0  07/11/2002  Initial script creation
#  1.1  07/12/2002  Added whenever sqlerror
#  1.2  07/19/2002  Fixed parms embed space error
#  1.3  08/08/2002  Added Added TJS_SQL_SET2
#-------------------------------------------------------

if [ $# -lt 2 ]
then
  echo "Usage: `basename $0` SCHEMA PROCEDURE {PARAMETER_LIST}"
  exit 1
fi

TJS_SCHEMA=$1
TJS_PROCEDURE=$2
shift 2
TJS_PARMS="$*"

TJS_LOG_TRAIL="$TJS_SCHEMA.$TJS_PROCEDURE"
export TJS_LOG_TRAIL
. $TJS_DIR/tjs_start_log.sh

$ORACLE_HOME/bin/sqlplus -s <<EOF
$ORACLE_DBA_UID/$ORACLE_DBA_UPW
WHENEVER SQLERROR EXIT FAILURE
$TJS_SQL_SET2
set serveroutput on
execute $TJS_SCHEMA.$TJS_PROCEDURE $TJS_PARMS
EOF
TJS_RETURN_CODE=$?

. $TJS_DIR/tjs_stop_log.sh