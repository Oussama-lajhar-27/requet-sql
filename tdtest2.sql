connect admin21/admin21
DROP TABLE employes;
DROP TABLE Departement_21;

create table Departement_21 (
  code char(4) not null,
  nom varchar2(30) not null,
  designation varchar2(100) not null,
  constraint pk_departement_21 primary key (code)
);

desc Departement_21;

create table employes (
    cin number(8) not null,
    nom varchar2(30) not null,
    prenom varchar2(30) not null,
    age number(2) not null,
    sexe char(1) not null,
    num_dept char(4) not null,
    constraint pk_employes primary key (cin),
    constraint ck_age_21 check (age>=18 and age<=35),
    constraint ck_sexe_21 check (sexe in ('M','F')),
    constraint fk_dept_21 foreign key (num_dept) references Departement_21(code)
);

desc employes;
insert into Departement_21 (code, nom, designation) values ('TI','Technologies','Technologies de L''Informatique');
insert into Departement_21 (code, nom, designation) values ('GI','Genie ','Genie Informatique');

insert all 
    into employes values (12345678,'oussama','lajhar',22,'M','TI')
    into employes values (87654321,'fatima','zahra',24,'F','GI')
    into employes values (11223344,'ahmed','ali',28,'M','TI')
    into employes values (44332211,'sara','youssef',21,'F','GI')
select * from dual;

/*16*/
SELECT employes.nom, Departement_21.nom
FROM employes, Departement_21
where employes.num_dept = Departement_21.code;

/*17*/
SELECT E.nom
FROM employes E, Departement_21 D
WHERE 