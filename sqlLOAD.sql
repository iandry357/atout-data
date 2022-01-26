select year(`DATE DE CLASSEMENT`) as y, month(`DATE DE CLASSEMENT`) as m, day(`DATE DE CLASSEMENT`) as d,
`DATE DE CLASSEMENT`
from Hebergements;

-- TABLE DATE
SET @row_number = 0; 
create table DateClassement as
(SELECT 
    (@row_number:=@row_number + 1) AS dateId, 
    dt, y, m, d
FROM
(select distinct date(`DATE DE CLASSEMENT`) as dt,
year(`DATE DE CLASSEMENT`) as y, month(`DATE DE CLASSEMENT`) as m, day(`DATE DE CLASSEMENT`) as d 
from Hebergements) t);

-- TYPE ETABLISSEMENT
SET @row_number = 0; drop table if exists TypeEtablissement;
create table TypeEtablissement as
(SELECT 
    (@row_number:=@row_number + 1) AS typeId, 
    `TYPOLOGIE ETABLISSEMENT` as value
FROM
(select distinct `TYPOLOGIE ETABLISSEMENT` 
from Hebergements) t);

-- CLASSEMENT
SET @row_number = 0; drop table if exists Classement;
create table Classement as
(SELECT 
    (@row_number:=@row_number + 1) AS classeId, 
    `CLASSEMENT` as value
FROM
(select distinct `CLASSEMENT` 
from Hebergements) t);

-- CATEGORIE
SET @row_number = 0; drop table if exists Categorie;
create table Categorie as
(SELECT 
    (@row_number:=@row_number + 1) AS categorieId, 
    `CATEGORIE` as value
FROM
(select distinct `CATEGORIE` 
from Hebergements) t);


-- MENTION
SET @row_number = 0; drop table if exists Mention;
create table Mention as
(SELECT 
    (@row_number:=@row_number + 1) AS mentionId, 
    `MENTION (villages de vacances)` as value
FROM
(select distinct `MENTION (villages de vacances)` 
from Hebergements) t);


-- TYPE SEJOUR
SET @row_number = 0; drop table if exists Sejour;
create table Sejour as
(SELECT 
    (@row_number:=@row_number + 1) AS sejourId, 
    `TYPE DE SEJOUR` as value
FROM
(select distinct `TYPE DE SEJOUR` 
from Hebergements) t);

-- TABLE
SET @row_number = 0; drop table if exists HebergementInfo;
create table HebergementInfo as
(
select distinct dateId, typeId, classeId, categorieId, mentionId, sejourId, 
`NOM COMMERCIAL` as nom, adresse, `CODE POSTAL` as cp, code_departement, code_region,  
if( `CAPACITÉ D ACCUEIL (PERSONNES)`=0, '-', `CAPACITÉ D ACCUEIL (PERSONNES)`) as accueil, 
if(`NOMBRE DE CHAMBRES`=0, '-', `NOMBRE DE CHAMBRES`) as nbChambre,
if(`NOMBRE D EMPLACEMENTS`=0, '-', `NOMBRE D EMPLACEMENTS`) nbEmplacement, 
if(`NOMBRE D UNITES D HABITATION (résidences de tourisme)`=0, '-', `NOMBRE D UNITES D HABITATION (résidences de tourisme)`) nbHabitation,
if(`NOMBRE DE LOGEMENTS (villages de vacances)`=0, '-', `NOMBRE DE LOGEMENTS (villages de vacances)`) nbLogement
from Hebergements h, DateClassement dc, Categorie cat, 
TypeEtablissement te, Classement cla, Mention m, Sejour s, Localisation l
where h.`TYPOLOGIE ETABLISSEMENT` = te.value and 
h.CLASSEMENT = cla.value and 
h.CATEGORIE = cat.value and 
h.`MENTION (villages de vacances)` = m.value and 
h.`TYPE DE SEJOUR` = s.value and 
h.`DATE DE CLASSEMENT` = dc.`dt` and
h.`CODE POSTAL` = l.code_postal
);


select distinct dateId, typeId, classeId, categorieId, mentionId, sejourId, 
`NOM COMMERCIAL` as nom, adresse, `CODE POSTAL` as cp, code_departement, code_region,  
if( `CAPACITÉ D ACCUEIL (PERSONNES)`=0, '-', `CAPACITÉ D ACCUEIL (PERSONNES)`) as accueil, 
if(`NOMBRE DE CHAMBRES`=0, '-', `NOMBRE DE CHAMBRES`) as nbChambre,
if(`NOMBRE D EMPLACEMENTS`=0, '-', `NOMBRE D EMPLACEMENTS`) nbEmplacement, 
if(`NOMBRE D UNITES D HABITATION (résidences de tourisme)`=0, '-', `NOMBRE D UNITES D HABITATION (résidences de tourisme)`) nbHabitation,
if(`NOMBRE DE LOGEMENTS (villages de vacances)`=0, '-', `NOMBRE DE LOGEMENTS (villages de vacances)`) nbLogement
from Hebergements h, DateClassement dc, Categorie cat, 
TypeEtablissement te, Classement cla, Mention m, Sejour s, Localisation l
where h.`TYPOLOGIE ETABLISSEMENT` = te.value and 
h.CLASSEMENT = cla.value and 
h.CATEGORIE = cat.value and 
h.`MENTION (villages de vacances)` = m.value and 
h.`TYPE DE SEJOUR` = s.value and 
h.`DATE DE CLASSEMENT` = dc.`dt` and
h.`CODE POSTAL` = l.code_postal;