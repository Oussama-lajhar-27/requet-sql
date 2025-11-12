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





\\lmdpant121
select count(*) as nb_etudiant from Etudiant_21;
update Departement_21 set designation='science computer ' where code='TI';
update Departement_21 set designation='software enginier ' where code='GE';
select * from Departement_21;
delete from Departement_21;
select * from Departement_21;
delete from Etudiant_21;
select * from Etudiant_21;
delete from Departement_211;
select * from Departement_211;
delete from Departement_212;
select * from Departement_212;
delete from Departement_213;
select * from Departement_213;