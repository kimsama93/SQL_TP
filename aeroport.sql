-- Création de la base de données
CREATE DATABASE IF NOT EXISTS aeroport;


-- Sélection de la base de données
USE aeroport;



-- Création de la table pilotes
CREATE TABLE IF NOT EXISTS pilotes
(
id INT NOT NULL AUTO_INCREMENT,
nom VARCHAR(50) NOT NULL,
prenom VARCHAR(50) NOT NULL,
adresse VARCHAR(100),
PRIMARY KEY(id)
);

-- Création de la table avions
CREATE TABLE IF NOT EXISTS avions
(
id INT NOT NULL AUTO_INCREMENT,
fabricant VARCHAR(50) NOT NULL,
model VARCHAR(50) NOT NULL,
localisation VARCHAR(100) NOT NULL,
capacite INT,
PRIMARY KEY(id)
);

-- Création de la table vols
CREATE TABLE IF NOT EXISTS vols
(
id INT NOT NULL AUTO_INCREMENT,
num_vol char(10) NOT NULL,
ville_depart VARCHAR(50) NOT NULL,
ville_arrivee VARCHAR(50) NOT NULL,
heure_depart TIME,
heure_arrivee TIME,
PRIMARY KEY(id),
id_pilote INT NOT NULL,
id_avion INT NOT NULL,
FOREIGN KEY(id_pilote)
REFERENCES pilotes (id),
FOREIGN KEY(id_avion)
REFERENCES avions (id)
);

-- TP2
-- creation de données pour l'exercice
-- INSERT INTO pilotes (nom,prenom,adresse) VALUES
-- ('Milles','Robert','2 Square Spaghetti, 700 cedex 1 PARIS'),
-- ('Delacour','Yvette','260 bis avenue des Martyrs, 46476 Montrevault'),
-- ('Wilson','Mounir','68 rue des Buissson, 65476 Vallet'),
-- ('Potter','Henri','6 voie 9 1/4, 54874 Poudlard'),
-- ('Robot','Bender','0 Bis voie Lactée'),
-- ('Granger','Hermoine','8 voie 9 1/4, 54874 Poudlard');

-- INSERT INTO vols(num_vol,ville_depart,ville_arrivee,heure_depart,heure_arrivee,id_pilote,id_avion) VALUES
-- ('IT100','SIDNEY','TOKYO', '03:15:59', null,5,1),
-- ('IT101','MILAN','BERLIN', '16:34:06', null,3,2),
-- ('IT102','QUEBEC','TORONTO', '12:15:46', '13:30:54',4,3),
-- ('IT104','NANTES','PARIS', null, null,1,4);

-- consigne 1
-- INSERT INTO avions (fabricant,model,capacite,localisation)
-- VALUES
-- ('BOEING', '787', 300,'NAIROBI'),
-- ('BOEING', '737', 250,'SIDNEY'),
-- ('AIRBUS', '320', 220,'MILAN'),
-- ('AVIC', '250', 150,'PEKIN');

-- consigne 2
SELECT * FROM avions;
SELECT * FROM avions ORDER BY fabricant ASC;
SELECT model,capacite FROM avions;
SELECT DISTINCT(localisation) from avions;
SELECT * FROM avions WHERE localisation = "NAIROBI" OR localisation = "MILAN";
UPDATE avions SET capacite=400 WHERE id=3;
DELETE FROM avions WHERE capacite < 200;
SELECT MAX(capacite) as "Capacite maximum", MIN(capacite) as "Capacite minimale", AVG(capacite) as "Capacite moyenne" FROM avions; 
SELECT * FROM avions WHERE capacite = (SELECT MIN(capacite) FROM avions);
SELECT * FROM avions WHERE capacite > (SELECT AVG(capacite) FROM avions);
SELECT pilotes.nom, pilotes.prenom, pilotes.adresse, vols.num_vol from pilotes JOIN vols ON pilotes.id = vols.id_pilote WHERE vols.num_vol = "IT100" OR vols.num_vol = "IT104";
SELECT pilotes.nom, pilotes.prenom, pilotes.adresse, vols.num_vol from pilotes JOIN vols ON pilotes.id = vols.id_pilote WHERE ISNULL(vols.heure_arrivee) AND NOT ISNULL(vols.heure_depart);
SELECT pilotes.nom, pilotes.prenom, pilotes.adresse, vols.num_vol from pilotes JOIN vols ON pilotes.id = vols.id_pilote WHERE (NOT ISNULL(vols.heure_arrivee) AND NOT ISNULL(vols.heure_depart)) OR (ISNULL(vols.heure_arrivee) AND ISNULL(vols.heure_depart));

-- Suppression des tables
-- DROP TABLE vols;
-- DROP TABLE avions;
-- DROP TABLE pilotes;
