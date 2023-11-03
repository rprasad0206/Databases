DROP TABLE phone_extensions;
DROP TABLE staff_titles;
DROP TABLE CSStaff;
DROP TABLE Title;
DROP TABLE Path;
DROP SEQUENCE edgeID_seq;
Drop TABLE Edge;
DROP TABLE Location;


-- Creating the tables
CREATE TABLE Title (
    Acronym VARCHAR2(40),
    TitleName VARCHAR2(60) UNIQUE NOT NULL,
    CONSTRAINT Title_acronym_PK PRIMARY KEY (Acronym)
);

CREATE TABLE Location (
    LocationID VARCHAR2(40),
    LocationName VARCHAR2(40) NOT NULL,
    LocationType VARCHAR2(40) NOT NULL,
    XCoord NUMBER(5) NOT NULL,
    YCoord NUMBER(5) NOT NULL,
    Floor VARCHAR2(40) NOT NULL,
    UNIQUE (XCoord, YCoord, Floor),
    CONSTRAINT Location_locationid_PK PRIMARY KEY (LocationID), 
    CONSTRAINT location_floor_values check (Floor in('1','2','3','A','B'))
);

CREATE TABLE CSStaff (
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    account VARCHAR(255) NOT NULL,
    office VARCHAR(255),
    CONSTRAINT CSStaff_accountname_PK PRIMARY KEY (account)
);

CREATE TABLE staff_titles (
    title_id NUMBER(5) NOT NULL,
    account VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    CONSTRAINT staff_titles_title_FK FOREIGN KEY (title) REFERENCES Title(TitleName),
    CONSTRAINT staff_titles_account_FK FOREIGN KEY (account) REFERENCES CSStaff(account) ON DELETE CASCADE,
    CONSTRAINT staff_titles_title_id_PK PRIMARY KEY (title_id)
);

CREATE TABLE phone_extensions (
    extension_id NUMBER(5) NOT NULL,
    account VARCHAR(255) NOT NULL,
    extension VARCHAR(255) NOT NULL,
    CONSTRAINT phone_extensions_account_FK FOREIGN KEY (account) REFERENCES CSStaff(account) ON DELETE CASCADE,
    CONSTRAINT phone_extensions_id_PK PRIMARY KEY (extension_id)
);

CREATE SEQUENCE edgeID_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE Edge (
    EdgeID NUMBER(5),
    StartLocation VARCHAR2(40),
    EndLocation VARCHAR2(40),
    UNIQUE (StartLocation, EndLocation),
    CONSTRAINT Edge_edgeid_PK PRIMARY KEY (EdgeID),
    CONSTRAINT Edge_startlocation_FK FOREIGN KEY (StartLocation) REFERENCES Location(LocationID) ON DELETE SET NULL,
    CONSTRAINT Edge_endlocation_FK FOREIGN KEY (EndLocation) REFERENCES Location(LocationID) ON DELETE SET NULL
);

CREATE TABLE Path (
    PathID NUMBER(5) NOT NULL,
    LocationOrder NUMBER(5) NOT NULL,
    LocationID VARCHAR2(40) NOT NULL,
    CONSTRAINT Path_PathID_LocationOrder_PK PRIMARY KEY (PathID, LocationOrder),
    CONSTRAINT Path_LocationID_FK FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- Populating Titles Table
INSERT INTO Title VALUES ('Adj Assoc Prof', 'Adjunct Associate Professor');
INSERT INTO Title VALUES ('Admin 5', 'Administrative Assistant V');
INSERT INTO Title VALUES ('Admin 6', 'Administrative Assistant VI');
INSERT INTO Title VALUES ('Asst Prof', 'Assistant Professor');
INSERT INTO Title VALUES ('Asst TProf', 'Assistant Teaching Professor');
INSERT INTO Title VALUES ('Assoc Prof', 'Associate Professor');
INSERT INTO Title VALUES ('C-MGRG', 'Coordinator of Mobile Graphics Research Group');
INSERT INTO Title VALUES ('DeptHead', 'Department Head');
INSERT INTO Title VALUES ('Dir-DS', 'Director of Data Science');
INSERT INTO Title VALUES ('Dir-LST', 'Director of Learn Sciences and Technologies');
INSERT INTO Title VALUES ('GradAdmin', 'Graduate Admin Coordinator');
INSERT INTO Title VALUES ('Lab1', 'Lab Manager I');
INSERT INTO Title VALUES ('Lab2', 'Lab Manager II');
INSERT INTO Title VALUES ('Prof', 'Professor');
INSERT INTO Title VALUES ('SrInst', 'Senior Instructor');
INSERT INTO Title VALUES ('TProf', 'Teaching Professor');

-- Populating Locations Table
INSERT INTO Location VALUES ('307', 'FL307', 'Office', 900, 440, 3);
INSERT INTO Location VALUES ('308', 'FL308', 'Office', 900, 335, 3);
INSERT INTO Location VALUES ('311', 'FL311', 'Conference Room', 900, 375, 3);
INSERT INTO Location VALUES ('312', 'FL312', 'Office', 945, 510, 3);
INSERT INTO Location VALUES ('314', 'FL314', 'Office', 845, 660, 3);
INSERT INTO Location VALUES ('316', 'FL316', 'Office', 845, 760, 3);
INSERT INTO Location VALUES ('317', 'FL317', 'Office', 925, 670, 3);
INSERT INTO Location VALUES ('318', 'FL318', 'Office', 950, 700, 3);
INSERT INTO Location VALUES ('319', 'FL319', 'Office', 925, 735, 3);
INSERT INTO Location VALUES ('320', 'FL320', 'Lecture Hall', 900, 920, 3);
INSERT INTO Location VALUES ('3E1', '3rd Floor Elevator', 'Elevator', 820, 415, 3);
INSERT INTO Location VALUES ('3H1', 'FL3H1', 'Hallway', 790, 150, 3);
INSERT INTO Location VALUES ('3H2', 'FL3H2', 'Hallway', 790, 340, 3);
INSERT INTO Location VALUES ('3H3', 'FL3H3', 'Hallway', 790, 375, 3);
INSERT INTO Location VALUES ('3H4', 'FL3H4', 'Hallway', 790, 420, 3);
INSERT INTO Location VALUES ('3H5', 'FL3H5', 'Hallway', 790, 465, 3);
INSERT INTO Location VALUES ('3H6', 'FL3H6', 'Hallway', 900, 465, 3);
INSERT INTO Location VALUES ('3H7', 'FL3H7', 'Hallway', 900, 510, 3);
INSERT INTO Location VALUES ('3H8', 'FL3H8', 'Hallway', 790, 660, 3);
INSERT INTO Location VALUES ('3H9', 'FL3H9', 'Hallway', 790, 700, 3);
INSERT INTO Location VALUES ('3H10', 'FL3H10', 'Hallway', 925, 700, 3);
INSERT INTO Location VALUES ('3H11', 'FL3H11', 'Hallway', 790, 755, 3);
INSERT INTO Location VALUES ('3H12', 'FL3H12', 'Hallway', 790, 925, 3);
INSERT INTO Location VALUES ('3H13', 'FL3H13', 'Hallway', 840, 920, 3);
INSERT INTO Location VALUES ('3S1', '3rd Floor Staircase 1', 'Staircase', 835, 340, 3);
INSERT INTO Location VALUES ('3S2', '3rd Floor Staircase 2', 'Staircase', 840, 965, 3);

-- Populating CSStaff Table
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Carolina', 'Ruiz', 'ruiz', '232');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Charles', 'Rich', 'rich', 'B25b');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Christine', 'Caron', 'ccaron', '233');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Craig', 'Shue', 'cshue', '236');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Craig', 'Wills', 'cew', '234');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Daniel', 'Dougherty', 'dd', '231');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Douglas', 'Selent', 'deselent', '144');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Elke', 'Rundensteiner', 'rundenst', '135');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Emmanuel', 'Agu', 'emmanuel', '139');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('George', 'Heineman', 'heineman', 'B20');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Glynis', 'Hamel', 'ghamel', '132');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Hugh', 'Lauer', 'lauer', '144');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('John', 'Leveillee', 'jleveillee', '244');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Joseph', 'Beck', 'josephbeck', '138');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Kathryn', 'Fisler', 'kfisler', '130');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Krishna', 'Venkatasubramanian', 'kven', '137');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Mark', 'Claypool', 'claypool', 'B24');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Micha', 'Hofri', 'hofri', '133');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Michael', 'Ciaraldi', 'ciaraldi', '129');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Michael', 'Voorhis', 'mvoorhis', '245');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Mohamed', 'Eltabakh', 'meltabakh', '235');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Neil', 'Heffernan', 'nth', '237');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Nicole', 'Caligiuri', 'nkcaligiuri', '233');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Refie', 'Cane', 'rcane', '233');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Thomas', 'Gannon', 'tgannon', '243');
INSERT INTO CSStaff (first_name, last_name, account, office) VALUES ('Wilson', 'Wong', 'wwong2', 'B19');

INSERT INTO staff_titles (title_id, account, title) VALUES (1, 'ruiz', 'Associate Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (2, 'rich', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (3, 'ccaron', 'Administrative Assistant VI');
INSERT INTO staff_titles (title_id, account, title) VALUES (4, 'cshue', 'Assistant Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (5, 'cew', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (6, 'cew', 'Department Head');
INSERT INTO staff_titles (title_id, account, title) VALUES (7, 'dd', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (8, 'deselent', 'Assistant Teaching Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (9, 'rundenst', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (10, 'rundenst', 'Director of Data Science');
INSERT INTO staff_titles (title_id, account, title) VALUES (11, 'emmanuel', 'Associate Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (12, 'emmanuel', 'Coordinator of Mobile Graphics Research Group');
INSERT INTO staff_titles (title_id, account, title) VALUES (13, 'heineman', 'Associate Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (14, 'ghamel', 'Senior Instructor');
INSERT INTO staff_titles (title_id, account, title) VALUES (15, 'lauer', 'Teaching Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (16, 'jleveillee', 'Lab Manager I');
INSERT INTO staff_titles (title_id, account, title) VALUES (17, 'josephbeck', 'Associate Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (18, 'kfisler', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (19, 'kven', 'Assistant Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (20, 'claypool', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (21, 'hofri', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (22, 'ciaraldi', 'Senior Instructor');
INSERT INTO staff_titles (title_id, account, title) VALUES (23, 'mvoorhis', 'Lab Manager II');
INSERT INTO staff_titles (title_id, account, title) VALUES (24, 'meltabakh', 'Associate Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (25, 'nth', 'Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (26, 'nth', 'Director of Learn Sciences and Technologies');
INSERT INTO staff_titles (title_id, account, title) VALUES (27, 'nkcaligiuri', 'Administrative Assistant V');
INSERT INTO staff_titles (title_id, account, title) VALUES (28, 'rcane', 'Graduate Admin Coordinator');
INSERT INTO staff_titles (title_id, account, title) VALUES (29, 'tgannon', 'Adjunct Associate Professor');
INSERT INTO staff_titles (title_id, account, title) VALUES (30, 'wwong2', 'Assistant Professor');


INSERT INTO phone_extensions (extension_id, account, extension) VALUES (1, 'ruiz', '5640');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (2, 'rich', '5945');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (3, 'ccaron', '5678');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (4, 'cshue', '4933');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (5, 'cew', '5357');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (6, 'cew', '5622');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (7, 'dd', '5621');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (8, 'deselent', '5493');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (9, 'rundenst', '5815');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (10, 'emmanuel', '5568');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (11, 'heineman', '5502');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (12, 'ghamel', '5252');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (13, 'lauer', '5493');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (14, 'jleveillee', '5822');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (15, 'josephbeck', '6156');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (16, 'kfisler', '5118');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (17, 'kven', '6571');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (18, 'claypool', '5409');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (19, 'hofri', '6911');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (20, 'ciaraldi', '5117');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (21, 'mvoorhis', '5669');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (22, 'mvoorhis', '5674');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (23, 'meltabakh', '6421');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (24, 'nth', '5569');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (25, 'nkcaligiuri', '5357');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (26, 'rcane', '5357');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (27, 'tgannon', '5357');
INSERT INTO phone_extensions (extension_id, account, extension) VALUES (28, 'wwong2', '5706');


-- Edges
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H1', '3H2');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H2', '3H1');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H2', '3H3');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H3', '3H2');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H3', '3H4');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H4', '3H3');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H4', '3H5');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H5', '3H4');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H5', '3H6');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H6', '3H5');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H6', '3H7');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H7', '3H6');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H7', '3H8');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H8', '3H7');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H8', '3H9');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H9', '3H8');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H9', '3H10');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H10', '3H9');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H10', '3H11');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H11', '3H10');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H11', '3H12');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H12', '3H11');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H12', '3H13');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H13', '3H12');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H3', '311');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '311', '3H3');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '311', '308');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '308', '311');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H6', '307');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '307', '3H6');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H10', '317');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '317', '3H10');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H10', '319');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '319', '3H10');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H11', '316');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '316', '3H11');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H13', '320');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '320', '3H13');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3H13', '3S2');
INSERT INTO Edge VALUES (edgeID_seq.nextval, '3S2', '3H13');

-- Paths
INSERT INTO Path VALUES (1, 1, '3E1');
INSERT INTO Path VALUES (1, 2, '3H4');
INSERT INTO Path VALUES (1, 3, '3H5');
INSERT INTO Path VALUES (1, 4, '3H6');
INSERT INTO Path VALUES (1, 5, '3H7');
INSERT INTO Path VALUES (1, 6, '3H8'); 
INSERT INTO Path VALUES (1, 7, '3H12');
INSERT INTO Path VALUES (1, 8, '3H13');
INSERT INTO Path VALUES (1, 9, '320');
INSERT INTO Path VALUES (2, 1, '312');
INSERT INTO Path VALUES (2, 2, '3H7');
INSERT INTO Path VALUES (2, 3, '3H10');
INSERT INTO Path VALUES (2, 4, '319');
INSERT INTO Path VALUES (3, 1, '3S2');
INSERT INTO Path VALUES (3, 2, '3H13');
INSERT INTO Path VALUES (3, 3, '3H12');
INSERT INTO Path VALUES (3, 4, '3H11');
INSERT INTO Path VALUES (3, 5, '3H8'); 
INSERT INTO Path VALUES (3, 6, '3H7');
INSERT INTO Path VALUES (3, 7, '3H6');
INSERT INTO Path VALUES (3, 8, '3H3');
INSERT INTO Path VALUES (3, 9, '311');
INSERT INTO Path VALUES (3, 10, '308');