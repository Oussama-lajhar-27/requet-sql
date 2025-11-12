connect system/dsi21
drop table Etudiant_21;
drop table Departement_21;
drop table Departement_211;
drop table Departement_212;
drop sequence seq_dept_212;
drop table Departement_213;
drop sequence seq_dept_213;
create table Departement_21 (
 code char(4) not null,
 designation varchar2(100) not null,
 constraint pk_departement_21 primary key (code)
);
desc Departement_21;
create table Etudiant_21 (
    cin number(8) not null,
    nom varchar2(30) not null,
    prenom varchar2(30) not null,
    age number(2) not null,
    sexe char(1) not null,
    num_dept char(4) not null,
    constraint pk_etudiant_21 primary key (cin),
    constraint ck_age_21 check (age>=18 and age<=35),
    constraint ck_sexe_21 check (sexe in ('M','F')),
    constraint fk_dept_21 foreign key (num_dept) references Departement_21(code)
);
desc Etudiant_21;
insert into Departement_21 (code, designation) values ('TI','Technologies de L''Informatique');
insert into Departement_21 (code, designation) values ('GI','Genie Informatique');
insert all into 
Departement_21 values ('GE','Genie Electrique')
           into Departement_21 values ('GE','Genie Mecanique')
           into Departement_21 values ('GC','Genie Civil')
select * from dual;
select count(*) as nb_dept from Departement_21;
create table Departement_211 (
 code char(6) not null,
 designation varchar2(100) not null,
 constraint pk_departement_211 primary key (code)
);
insert into Departement_211 select code, designation from Departement_21 where code like 'G%';
select count(*) as nb_dept_211 from Departement_211;
select * from Departement_211;
create table Departement_212 (
    code number(6) not null,
    designation varchar2(100) not null,
    constraint pk_departement_212 primary key (code)
);
create sequence seq_dept_212 start with 1 increment by 1;
insert into Departement_212 select seq_dept_212.nextval, designation from Departement_21 where code like 'G%';
select * from Departement_212;
create table Departement_213 (
    code number(6) not null,
    designation varchar2(100) not null,
    constraint pk_departement_213 primary key (code)
);
create sequence seq_dept_213 start with 2010 increment by 10;
insert into Departement_213 select seq_dept_213.nextval, designation from Departement_21 where code like 'G%';
select * from Departement_21;
insert all into Etudiant_21 values (12345678,'oussama','lajhar',22,'M','TI')
           into Etudiant_21 values (23456789,'ahmed','ahmed',19,'M','GI')
           into Etudiant_21 values (34567890,'selmi','nour',21,'F','GE')
           into Etudiant_21 values (45678901,'rami','ahlem',20,'F','TI')
           into Etudiant_21 values (56789012,'mouradi','khaled',23,'M','GC')
           into Etudiant_21 values (67890123,'rachidda','basmma',18,'F','GI')
           into Etudiant_21 values (25896436,'warda','hala',25,'F','TI')
           into Etudiant_21 values (89012345,'moas','sami',30,'M','TI')
           into Etudiant_21 values (90123456,'foayda','sarah',28,'F','GI')
           into Etudiant_21 values (11234567,'kamer','amira',27,'F','GE')
           into Etudiant_21 values (22345678,'mahamed','ali',24,'M','GM')
           into Etudiant_21 values (33456789,'mohamed','anis',29,'M','GC')
           into Etudiant_21 values (44567890,'mohamed','asma',26,'F','GI')
           into Etudiant_21 values (55678901,'roae','aya',21,'F','TI')
           into Etudiant_21 values (66789012,'Abdalah','benali',22,'M','GE')
           into Etudiant_21 values (77890123,'sara','sarra',20,'F','GI')
select * from dual;
commit;

select nom , prenom ,cin, num_dept
from Etudiant_21
where nom like 'A%'
and prenom like 'b%'
and sexe='M'
and upper(num_dept)='GE';

select nom , prenom ,cin, num_dept
from Etudiant_21 e , Departement_21 d
where nom like 'A%'
and prenom like 'b%'
and sexe='M'
and upper(num_dept)='GE'
and e.num_dept =d.code,