connect sys as sysdba
disconnect
connect system/dsi21
select sysdate from dual;
select user from dual;
disconnect
connect admin21/admin21
select sysdate , user from dual;
disconnect
connect admin21/admin21
select TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') as "date ",user as "name utilisateur" from dual;
disconnect
