spool c:\cprg250\module1\FINALpartB.txt
DROP TABLE MOON;
DROP TABLE PLANET;
DROP TABLE STAR; 

CREATE TABLE STAR
(
	starID number PRIMARY KEY,
	name varchar2(75) NOT NULL UNIQUE ,
	mass number,
	check (mass > 0)
	);
	
	CREATE TABLE MY_TABLE
	(
	MY_NUMBER number, 
	MY_DATE date,
MY_STRING VARCHAR2(5)	
	);
	
	
CREATE TABLE PLANET
(
	planetID number PRIMARY KEY,
	starID number,
	name varchar2(45) NOT NULL UNIQUE,
	mass number,
	length_of_year number(8,2) NOT NULL,
	length_of_day number (8,2) NOT NULL,
	hasRingSystem number(1),
	foreign key (starID) references star(starid),
	check (mass > 0),
	check (hasRingSystem Between 1 and 2)
	);
	
	CREATE TABLE MOON
	(
	moonID number,
	planetID number,
	name varchar2(45),
	mass number,
	speed number
	);
	
	ALTER TABLE MOON
	ADD CONSTRAINT moon_key PRIMARY KEY (moonID);
	
	alter table MOON add constraint Moon_C
foreign key (PLANETID) references PLANET(planetID);
	ALTER TABLE MOON 
	MODIFY PLANETID number NOT NULL;
	ALTER TABLE MOON
	MODIFY NAME varchar2(45) NOT NULL UNIQUE;
	ALTER TABLE MOON 
	MODIFY SPEED number NOT NULL;
	alter table moon add constraint massC
	check (mass > 0);
	
	spool off
	
	