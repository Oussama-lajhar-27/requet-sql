/* -------------------------------------------------------------------------- */
/* بداية السكربت                                   */
/* -------------------------------------------------------------------------- */

-- الاتصال بقاعدة البيانات (ملاحظة: هذا السطر ينفذ عادة في سطر الأوامر وليس داخل محرر SQL)
-- Connect system/isett

/* ========================================================================== */
/* 1. تنظيف قاعدة البيانات (حذف الجداول القديمة)        */
/* ========================================================================== */

-- حذف قيد المفتاح الأجنبي (Foreign Key) المسمى 'fk_responsable' من جدول الأقسام لتجنب أخطاء الحذف
alter table departement  drop constraint fk_responsable 
/
-- حذف قيد المفتاح الأجنبي 'fk_dep_emp' من جدول الموظفين
alter table employe  drop constraint fk_dep_emp 
/
-- حذف جدول الموظفين (employe) نهائياً
drop  table employe 
/
-- حذف جدول (emp) نهائياً
drop  table emp
/
-- حذف جدول الأقسام (departement) نهائياً
drop table departement
/
-- حذف جدول الرتب/الدرجات (grade) نهائياً
drop  table grade
/

/* ========================================================================== */
/* 2. إنشاء الجداول (Create Tables)                     */
/* ========================================================================== */

/* إنشاء جدول الموظفين (employe) ويحتوي على:
- nemp: رقم الموظف (عدد صحيح 3 خانات)
- nom: الاسم (نص، إجباري not null)
- prenom: اللقب (نص، إجباري not null)
- username: اسم المستخدم
- salaire: الراتب (رقم بـ 7 خانات، 2 منها بعد الفاصلة)
- prime: العلاوة/المكافأة
- daterecrut: تاريخ التوظيف (الافتراضي هو تاريخ اليوم sysdate)
*/
Create table employe(
    nemp number(3),
    nom varchar2(15) not null,
    prenom varchar2(15) not null,
    username varchar2(10),
    salaire number(7,2),
    prime number(7,2),
    daterecrut date default sysdate
)
/
-- عرض هيكل جدول الموظفين للتأكد من إنشائه
desc employe
/

/*
إنشاء جدول الأقسام (departement):
- codedep: كود القسم
- nomdep: اسم القسم
- lieu: المكان/الموقع
*/
create table departement(
    codedep number(2),
    nomdep varchar2(15),
    lieu varchar2(15)
)
/
-- عرض هيكل جدول الأقسام
desc departement
/

/*
إنشاء جدول الدرجات (grade):
- grade: رقم الدرجة
- salmin: الحد الأدنى للراتب
- salmax: الحد الأقصى للراتب
*/
create table grade(
    grade number(2),
    salmin number,
    salmax number
)
/
-- عرض هيكل جدول الدرجات
desc grade
/

/* ========================================================================== */
/* 3. التعديل والإدخال (Alter & Insert)                 */
/* ========================================================================== */

-- س3: إضافة عمود جديد اسمه 'fonc' (الوظيفة) لجدول الموظفين
alter table employe add  fonc  varchar2(10) 
/
-- عرض الهيكل للتأكد من إضافة العمود
desc employe 
/

-- س4: إدراج البيانات في الجداول
-- إدراج عدة موظفين دفعة واحدة باستخدام (insert all)
insert all  into employe(nemp,nom,prenom,username,salaire,prime,daterecrut) values(001,'Laribi','Mohammed',null,25000.50,null,'12/10/1992')
            into employe(nemp,nom,prenom,username,salaire,prime,daterecrut) values(002,'Bensliman','Brahim',null,35600.30,null,'06/09/1997')
            into employe(nemp,nom,prenom,username,salaire,prime,daterecrut) values(003,'Kara','Fouad',null,41880.69,null,'03/12/1999')
            into employe(nemp,nom,prenom,username,salaire,prime,daterecrut) values(004,'Laribi','Soumaya',null,29200.98,null,'18/09/2000')
            into employe(nemp,nom,prenom,username,salaire,prime,daterecrut) values(005,'Lezzar','Lila',null,53000.55,null,'11/11/2002')
-- جملة select وهمية لإنهاء أمر insert all
select * from dual
/

-- إدراج بيانات الأقسام (إدارة، بحث، محاسبة، مبيعات، شراء)
insert all  into departement(Codedep,Nomdep,lieu) values(01,'Administration','Alger')
            into departement(Codedep,Nomdep,lieu) values(02,'Recherche','Setif')
            into departement(Codedep,Nomdep,lieu) values(03,'Comptabilité','Alger')  
            into departement(Codedep,Nomdep,lieu) values(04,'Vente','Constantine')  
            into departement(Codedep,Nomdep,lieu) values(05,'Achat','Annaba')       
select * from dual
/

-- إدراج بيانات الدرجات والرواتب
insert all  into grade(grade,salmin,salmax) values(01,7000.00,12000.00)
            into grade(grade,salmin,salmax) values(02,12001.00,14000.00)
            into grade(grade,salmin,salmax) values(03,14001.00,20000.00)
            into grade(grade,salmin,salmax) values(04,20001.00,30000.00)
            into grade(grade,salmin,salmax) values(05,30001.00,90000.00)  
select * from dual
/

-- س5: التأكد من أن البيانات قد أضيفت بنجاح عبر عرض محتوى الجداول
select * from employe
/
select * from departement
/
select * from grade
/

/* ========================================================================== */
/* 4. تحديث البيانات (Updates)                          */
/* ========================================================================== */

-- س6: توليد اسم المستخدم (username) بدمج أول حرف من الاسم + أول 7 أحرف من اللقب
-- عرض الجدول قبل التعديل
select * from employe
/
-- تنفيذ عملية التحديث
update employe set username=concat(substr(nom,0,1),substr(prenom,0,7))
/
-- عرض الجدول بعد التعديل للتحقق
select * from employe
/

-- س7: رفع رواتب الموظفين الذين يتقاضون أقل من 30000 لتصبح 32000.45
update employe set salaire=32000.45 where salaire <30000
/

-- س8: حساب المكافأة (Prime)
-- إذا كان الراتب أكبر من 40000، المكافأة تكون 4%
update employe set prime=salaire*0.04 where salaire>40000
/
-- إذا كان الراتب 40000 أو أقل، المكافأة تكون 5%
update employe set prime=salaire*0.05 where salaire<=40000
/

/* ========================================================================== */
/* 5. التعامل مع جدول EMP (نسخ وحذف)                    */
/* ========================================================================== */

-- س9: إنشاء جدول جديد 'emp' كنسخة من جدول 'employe' يحتوي على أعمدة محددة فقط
create table emp as select nemp,nom,salaire,daterecrut from employe
/

-- س10: حذف عمود تاريخ التوظيف من جدول emp
alter table emp drop column daterecrut 
/
-- التأكد من الحذف
desc emp
/

-- س11: حذف آخر موظف تم إضافته (صاحب أكبر رقم وظيفي) من جدول emp
delete from emp where nemp= (select max(nemp) from emp)
/
-- التحقق من الحذف
select * from emp
/

-- س12: حذف جميع البيانات داخل جدول emp (تفريغ الجدول)
delete from emp 
/
-- التأكد أن الجدول فارغ
select * from emp
/

/* ========================================================================== */
/* 6. القيود والعلاقات (Constraints)                    */
/* ========================================================================== */

-- س13: إضافة عمود 'coddep' لجدول الموظفين لربط الموظف بالقسم
alter table employe add coddep number(2)
/
desc employe
/

-- س14: محاولة إدراج موظف بقسم رقم 20 (هذا الكود سيتم تنفيذه لكن لا يوجد قسم 20 حالياً لأنه لا يوجد رابط رسمي foreign key بعد)
insert into employe(nemp,nom,prenom,username,salaire,coddep)  
values(6,'houem', 'hasna','h.houem',30000.00, 20)
/

-- س15: إضافة القيد (Foreign Key)
-- أولاً: جعل 'codedep' في جدول الأقسام مفتاحاً أساسياً (Primary Key)
alter table departement add constraint pk_dep primary key(codedep)
/
-- حذف الموظف رقم 6 الذي أضفناه سابقاً لأنه يملك رقم قسم غير موجود (لتجنب خطأ عند إنشاء القيد)
delete from employe where nemp=6
/
-- ثانياً: ربط عمود 'coddep' في الموظفين مع 'codedep' في الأقسام (Foreign Key)
alter table employe add constraint fk_dep_emp foreign key(coddep) references departement(codedep)
/

-- س16: محاولة إدراج موظف بقسم رقم 20 الآن
-- (سيحدث خطأ هنا لأن القيد مفعل والقسم 20 غير موجود في جدول الأقسام)
insert into employe(nemp,nom,prenom,username,coddep)  values(7,'bouchemal', 'fouad','fbouchemal',20)
/

-- س17: محاولة الإدراج بقسم رقم 2 (سيتم بنجاح لأن القسم 2 موجود)
insert into employe(nemp,nom,prenom,username,coddep)  values(7,'bouchemal', 'fouad','fbouchemal',2)
/

-- س18: تعديل عمود username ليصبح غير قابل للقيم الفارغة (Not Null)
alter table employe modify username varchar2(10) not null 
/

-- س19: محاولة إدراج موظف بدون username (سيحدث خطأ بسبب القيد Not Null)
insert into employe(nemp,nom,prenom)  values(13,'kara’, ‘mostefa')
/

-- س20: إضافة قيد (Check) للتأكد أن الراتب دائماً أكبر من الصفر
alter table employe add constraint ck_salaire check(salaire >0)
/

-- س21: محاولة إدراج راتب سالب (-50) (سيحدث خطأ بسبب قيد Check)
insert into employe(nemp,nom,prenom,username,salaire)  values(14, 'harbi', 'mohammed', 'm.harbi', -50)
/

-- س22: إضافة قيد في جدول الدرجات للتأكد أن الحد الأدنى للراتب أقل من الحد الأقصى
alter table grade add constraint ck_sal_grade check(salmin<salmax)
/

-- س23: محاولة إدراج درجة حيث الحد الأدنى أكبر من الأقصى (45000 > 36000) (سيحدث خطأ)
insert into grade values (6, 45000.34, 36000.50)
/

-- س24: إضافة عمود 'responsable' (المسؤول) في جدول الأقسام وربطه بجدول الموظفين
-- حذف الموظف 7 لتنظيف البيانات (اختياري حسب السياق)
delete from employe where nemp=7;
/
-- جعل رقم الموظف مفتاحاً أساسياً (Primary Key) لكي يمكن الإشارة إليه
alter table employe add constraint pk_emp primary key(nemp)
/
-- إضافة عمود المسؤول في جدول الأقسام
alter table departement add responsable number(3) 
/
-- جعل عمود المسؤول مفتاحاً أجنبي يشير إلى رقم الموظف
alter table departement add constraint fk_responsable foreign key(responsable) references employe(nemp) 
