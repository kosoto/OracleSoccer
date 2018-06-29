set echo off
set feedback off
set linesize 512

prompt
prompt All User Roles in Database
prompt

SELECT ROLE, PASSWORD_REQUIRED
	FROM SYS.DBA_ROLES
	WHERE ROLE NOT IN (
	'AQ_ADMINISTRATOR_ROLE',
	'AQ_USER_ROLE',
	'CONNECT',
	'CTXAPP',
	'DBA',
	'DELETE_CATALOG_ROLE',
	'EXECUTE_CATALOG_ROLE',
	'EXP_FULL_DATABASE',
	'GLOBAL_AQ_USER_ROLE',
	'HS_ADMIN_ROLE',
	'IMP_FULL_DATABASE',
	'JAVADEBUGPRIV',
	'JAVAIDPRIV',
	'JAVASYSPRIV',
	'JAVAUSERPRIV',
	'JAVA_ADMIN',
	'JAVA_DEPLOY',
	'OEM_MONITOR',
	'OLAP_DBA',
	'RECOVERY_CATALOG_OWNER',
	'RESOURCE',
	'SELECT_CATALOG_ROLE',
	'SNMPAGENT',
	'WKADMIN',
	'WKUSER'
	);