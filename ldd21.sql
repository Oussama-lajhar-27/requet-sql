connect system/dsi21
create table departenent (
    code char(2),
    designation varchar(100)
);
desc departenent;
connect system/dsi21
create table etudiant (
    cin number(8),
    nom varchar(100),
    sexe char(1),
    age number(2),
    num_dup char(2)
);
desc etudiant;
create table departenent_1 as select code from departenent;
desc departenent_1; 
create table departenent_2 as select designation from departenent;
desc departenent_2;
create table departenent_3 as select * from departenent;
desc departenent_3;
select table_name from user_tables;
select * from user_tables;
select TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') as "date ",user as "name utilisateur" from dual;
disconnect