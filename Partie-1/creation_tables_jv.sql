--------------------------------------------------------
--  DDL for Table CATEGORIEJEU
--------------------------------------------------------

CREATE TABLE "CATEGORIEJEU" (
    "IDCATEGORIEJEU" NUMBER(8, 0),
    "NOMCATEGORIEJEU" VARCHAR2(50)
)

/

--------------------------------------------------------
--  DDL for Table CATEGORIEPLATEFORME
--------------------------------------------------------

CREATE TABLE "CATEGORIEPLATEFORME" (
    "IDCATEGORIEPLATEFORME" NUMBER(8, 0),
    "NOMCATEGORIEPLATEFORME" VARCHAR2(100)
)

/

--------------------------------------------------------
--  DDL for Table CLASSIFICATIONAGE
--------------------------------------------------------

CREATE TABLE "CLASSIFICATIONAGE" (
    "IDCLASSIFICATION" NUMBER(8, 0),
    "ORGANISMECLASSIFICATION" VARCHAR2(20),
    "CLASSIFICATION" VARCHAR2(20),
    "SYNOPSISCLASSIFICATION" VARCHAR2(3500)
)

/

--------------------------------------------------------
--  DDL for Table CLASSIFICATIONJEU
--------------------------------------------------------

CREATE TABLE "CLASSIFICATIONJEU" (
    "IDCLASSIFICATION" NUMBER(8, 0),
    "IDJEU" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Table COMPAGNIE
--------------------------------------------------------

CREATE TABLE "COMPAGNIE" (
    "IDCOMPAGNIE" NUMBER(10, 0),
    "NOMCOMPAGNIE" VARCHAR2(100),
    "DESCRCOMPAGNIE" CLOB,
    "PAYSCOMPAGNIE" VARCHAR2(20),
    "DATEFONDATIONCOMPAGNIE" DATE,
    "DATEMAJCOMPAGNIE" DATE,
    "COMPAGNIEPARENT" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Table COMPAGNIEJEU
--------------------------------------------------------

CREATE TABLE "COMPAGNIEJEU" (
    "IDJEU" NUMBER(10, 0),
    "IDCOMPAGNIE" NUMBER(8, 0),
    "ESTDEVELOPPEUR" NUMBER(1, 0),
    "ESTPORTEUR" NUMBER(1, 0),
    "ESTPUBLIEUR" NUMBER(1, 0),
    "ESTSOUTIEN" NUMBER(1, 0)
)

/

--------------------------------------------------------
--  DDL for Table COMPAGNIEMOTEUR
--------------------------------------------------------

CREATE TABLE "COMPAGNIEMOTEUR" (
    "IDCOMPAGNIE" NUMBER(10, 0),
    "IDMOTEUR" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table DATESORTIE
--------------------------------------------------------

CREATE TABLE "DATESORTIE" (
    "IDDATESORTIE" NUMBER(10,0),
    "IDJEU" NUMBER(10, 0),
    "IDPLATEFORME" NUMBER(8, 0),
    "DATESORTIE" DATE,
    "REGIONSORTIE" VARCHAR2(20),
    "STATUTSORTIE" VARCHAR2(50),
    "DATEMAJDATESORTIE" DATE
)

/

--------------------------------------------------------
--  DDL for Table FRANCHISE
--------------------------------------------------------

CREATE TABLE "FRANCHISE" (
    "IDFRANCHISE" NUMBER(8, 0),
    "NOMFRANCHISE" VARCHAR2(100)
)

/

--------------------------------------------------------
--  DDL for Table FRANCHISEJEU
--------------------------------------------------------

CREATE TABLE "FRANCHISEJEU" (
    "IDJEU" NUMBER(10, 0),
    "IDFRANCHISE" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table GENRE
--------------------------------------------------------

CREATE TABLE "GENRE" (
    "IDGENRE" NUMBER(8, 0),
    "NOMGENRE" VARCHAR2(50)
)

/

--------------------------------------------------------
--  DDL for Table GENREJEU
--------------------------------------------------------

CREATE TABLE "GENREJEU" (
    "IDJEU" NUMBER(10, 0),
    "IDGENRE" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table JEU
--------------------------------------------------------

CREATE TABLE "JEU" (
    "IDJEU" NUMBER(10, 0),
    "TITREJEU" VARCHAR2(250),
    "TITREVERSIONJEU" VARCHAR2(100),
    "HISTOIREJEU" CLOB,
    "RESUMEJEU" CLOB,
    "URLJEU" VARCHAR2(200),
    "SCOREAGREGEJEU" NUMBER,
    "NOMBRENOTESAGREGEESJEU" NUMBER(6, 0),
    "SCOREIGDB" NUMBER,
    "NOMBRENOTESIGDBJEU" NUMBER(6, 0),
    "SCOREJEU" NUMBER,
    "NOMBRENOTESJEU" NUMBER(8, 0),
    "TEMPSJEU_NORMAL" NUMBER(10, 0),
    "TEMPSJEU_RAPIDE" NUMBER(10, 0),
    "TEMPSJEU_COMPLET" NUMBER(10, 0),
    "NOMBRETEMPSJEU" NUMBER(8, 0),
    "STATUTJEU" VARCHAR2(20),
    "DATEMAJJEU" DATE,
    "VERSIONPARENT" NUMBER(10, 0),
    "IDJEUPARENT" NUMBER(10, 0),
    "FRANCHISEPRINCIPALEJEU" NUMBER(8, 0),
    "CATEGORIEJEU" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table LOCALISATIONJEU
--------------------------------------------------------

CREATE TABLE "LOCALISATIONJEU" (
    "IDJEU" NUMBER(10, 0),
    "IDREGION" NUMBER(2, 0),
    "TITRELOCALISE" VARCHAR2(400)
)

/

--------------------------------------------------------
--  DDL for Table MODALITE
--------------------------------------------------------

CREATE TABLE "MODALITE" (
    "IDMODALITE" NUMBER(8, 0),
    "NOMMODALITE" VARCHAR2(50)
)

/

--------------------------------------------------------
--  DDL for Table MODALITEJEU
--------------------------------------------------------

CREATE TABLE "MODALITEJEU" (
    "IDMODALITE" NUMBER(8, 0),
    "IDJEU" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Table MOTCLE
--------------------------------------------------------

CREATE TABLE "MOTCLE" (
    "IDMOTCLE" NUMBER(10, 0),
    "NOMMOTCLE" VARCHAR2(150)
)

/

--------------------------------------------------------
--  DDL for Table MOTCLEJEU
--------------------------------------------------------

CREATE TABLE "MOTCLEJEU" (
    "IDMOTCLE" NUMBER(10, 0),
    "IDJEU" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Table MOTEUR
--------------------------------------------------------

CREATE TABLE "MOTEUR" (
    "IDMOTEUR" NUMBER(10, 0),
    "NOMMOTEUR" VARCHAR2(100),
    "DESCRMOTEUR" VARCHAR2(3000),
    "DATEMAJMOTEUR" DATE
)

/

--------------------------------------------------------
--  DDL for Table MOTEURJEU
--------------------------------------------------------

CREATE TABLE "MOTEURJEU" (
    "IDJEU" NUMBER(10, 0),
    "IDMOTEUR" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table MODEMULTIJOUEUR
--------------------------------------------------------

CREATE TABLE "MODEMULTIJOUEUR" (
    "IDMODEMULTIJOUEUR" NUMBER(10, 0),
    "DROPIN" NUMBER(1, 0),
    "MODECOOPCAMPAGNE" NUMBER(1, 0),
    "MODECOOPLAN" NUMBER(1, 0),
    "MODECOOPOFFLINE" NUMBER(1, 0),
    "MODECOOPONLINE" NUMBER(1, 0),
    "MODESPLITSCREEN" NUMBER(1, 0),
    "NBJOUEURSMAXCOOPOFFLINE" NUMBER(6, 0),
    "NBJOUEURSMAXOFFLINE" NUMBER(10, 0),
    "NBJOUEURSMAXCOOPONLINE" NUMBER(6, 0),
    "NBJOUEURSMAXONLINE" NUMBER(10, 0),
    "IDJEU" NUMBER(10, 0),
    "IDPLATEFORME" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table PLATEFORME
--------------------------------------------------------

CREATE TABLE "PLATEFORME" (
    "IDPLATEFORME" NUMBER(8, 0),
    "NOMPLATEFORME" VARCHAR2(75),
    "ABBREVIATIONPLATEFORME" VARCHAR2(20),
    "NOMALTERNATIFPLATEFORME" VARCHAR2(50),
    "GENERATIONPLATEFORME" VARCHAR2(20),
    "DESCRIPTIFPLATEFORME" CLOB,
    "IDCATEGORIEPLATEFORME" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table PLATEFORMEMOTEUR
--------------------------------------------------------

CREATE TABLE "PLATEFORMEMOTEUR" (
    "IDMOTEUR" NUMBER(8, 0),
    "IDPLATEFORME" NUMBER(8, 0)
)

/

--------------------------------------------------------
--  DDL for Table POPULARITE
--------------------------------------------------------

CREATE TABLE "POPULARITE" (
    "IDJEU" NUMBER(10, 0),
    "MESUREPOPULARITE" VARCHAR2(25),
    "VALEURPOPULARITE" DECIMAL(21,20)
)

/

--------------------------------------------------------
--  DDL for Table REGION
--------------------------------------------------------

CREATE TABLE "REGION" (
    "IDREGION" NUMBER(2, 0),
    "NOMREGION" VARCHAR2(20)
)

/

--------------------------------------------------------
--  DDL for Table SIMILARITE
--------------------------------------------------------

CREATE TABLE "SIMILARITE" (
    "IDJEU" NUMBER(10, 0),
    "IDJEUSIMILAIRE" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Table THEME
--------------------------------------------------------

CREATE TABLE "THEME" (
    "IDTHEME" NUMBER(8, 0),
    "NOMTHEME" VARCHAR2(50)
)

/

--------------------------------------------------------
--  DDL for Table THEMEJEU
--------------------------------------------------------

CREATE TABLE "THEMEJEU" (
    "IDTHEME" NUMBER(8, 0),
    "IDJEU" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Table TITREALTERNATIF
--------------------------------------------------------

CREATE TABLE "TITREALTERNATIF" (
    "IDTITREALTERNATIF" NUMBER(10, 0),
    "LIBELLETITREALTERNATIF" VARCHAR2(400),
    "IDJEU" NUMBER(10, 0)
)

/

--------------------------------------------------------
--  DDL for Index CATEGORIEJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "CATEGORIEJEU_PK" ON "CATEGORIEJEU" ("IDCATEGORIEJEU")

/

--------------------------------------------------------
--  DDL for Index CATEGORIEPLATEFORME_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "CATEGORIEPLATEFORME_PK" ON "CATEGORIEPLATEFORME" ("IDCATEGORIEPLATEFORME")

/

--------------------------------------------------------
--  DDL for Index CLASSIFICATIONAGE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "CLASSIFICATIONAGE_PK" ON "CLASSIFICATIONAGE" ("IDCLASSIFICATION")

/

--------------------------------------------------------
--  DDL for Index CLASSIFICATIONJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "CLASSIFICATIONJEU_PK" ON "CLASSIFICATIONJEU" ("IDCLASSIFICATION", "IDJEU")

/

--------------------------------------------------------
--  DDL for Index COMPAGNIE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "COMPAGNIE_PK" ON "COMPAGNIE" ("IDCOMPAGNIE")

/

--------------------------------------------------------
--  DDL for Index COMPAGNIEJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "COMPAGNIEJEU_PK" ON "COMPAGNIEJEU" ("IDJEU", "IDCOMPAGNIE")

/

--------------------------------------------------------
--  DDL for Index COMPAGNIEMOTEUR_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "COMPAGNIEMOTEUR_PK" ON "COMPAGNIEMOTEUR" ("IDCOMPAGNIE", "IDMOTEUR")

/

--------------------------------------------------------
--  DDL for Index DATESORTIE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "DATESORTIE_PK" ON "DATESORTIE" ("IDDATESORTIE")

/

--------------------------------------------------------
--  DDL for Index FRANCHISE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "FRANCHISE_PK" ON "FRANCHISE" ("IDFRANCHISE")

/

--------------------------------------------------------
--  DDL for Index FRANCHISEJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "FRANCHISEJEU_PK" ON "FRANCHISEJEU" ("IDJEU", "IDFRANCHISE")

/

--------------------------------------------------------
--  DDL for Index GENRE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "GENRE_PK" ON "GENRE" ("IDGENRE")

/

--------------------------------------------------------
--  DDL for Index GENREJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "GENREJEU_PK" ON "GENREJEU" ("IDGENRE", "IDJEU")

/

--------------------------------------------------------
--  DDL for Index JEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "JEU_PK" ON "JEU" ("IDJEU")

/

--------------------------------------------------------
--  DDL for Index LOCALISATIONJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "LOCALISATIONJEU_PK" ON "LOCALISATIONJEU" ("IDJEU", "IDREGION")

/

--------------------------------------------------------
--  DDL for Index MODALITE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MODALITE_PK" ON "MODALITE" ("IDMODALITE")

/

--------------------------------------------------------
--  DDL for Index MODALITEJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MODALITEJEU_PK" ON "MODALITEJEU" ("IDMODALITE", "IDJEU")

/

--------------------------------------------------------
--  DDL for Index MOTCLE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MOTCLE_PK" ON "MOTCLE" ("IDMOTCLE")

/

--------------------------------------------------------
--  DDL for Index MOTCLEJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MOTCLEJEU_PK" ON "MOTCLEJEU" ("IDMOTCLE", "IDJEU")

/

--------------------------------------------------------
--  DDL for Index MOTEUR_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MOTEUR_PK" ON "MOTEUR" ("IDMOTEUR")

/

--------------------------------------------------------
--  DDL for Index MOTEURJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MOTEURJEU_PK" ON "MOTEURJEU" ("IDJEU", "IDMOTEUR")

/

--------------------------------------------------------
--  DDL for Index MODEMULTIJOUEUR_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "MODEMULTIJOUEUR_PK" ON "MODEMULTIJOUEUR" ("IDMODEMULTIJOUEUR")

/

--------------------------------------------------------
--  DDL for Index PLATEFORME_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "PLATEFORME_PK" ON "PLATEFORME" ("IDPLATEFORME")

/

--------------------------------------------------------
--  DDL for Index PLATEFORMEMOTEUR_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "PLATEFORMEMOTEUR_PK" ON "PLATEFORMEMOTEUR" ("IDMOTEUR", "IDPLATEFORME")

/

--------------------------------------------------------
--  DDL for Index POPULARITE
--------------------------------------------------------

CREATE UNIQUE INDEX "POPULARITE_PK" ON "POPULARITE" ("IDJEU", "MESUREPOPULARITE")

/

--------------------------------------------------------
--  DDL for Index REGION_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "REGION_PK" ON "REGION" ("IDREGION")

/

--------------------------------------------------------
--  DDL for Index SIMILARITE_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "SIMILARITE_PK" ON "SIMILARITE" ("IDJEUSIMILAIRE", "IDJEU")

/

--------------------------------------------------------
--  DDL for Index THEME_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "THEME_PK" ON "THEME" ("IDTHEME")

/

--------------------------------------------------------
--  DDL for Index THEMEJEU_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "THEMEJEU_PK" ON "THEMEJEU" ("IDTHEME", "IDJEU")

/

--------------------------------------------------------
--  DDL for Index TITREALTERNATIF_PK
--------------------------------------------------------

CREATE UNIQUE INDEX "TITREALTERNATIF_PK" ON "TITREALTERNATIF" ("IDTITREALTERNATIF")

/

--------------------------------------------------------
--  Constraints for Table CATEGORIEJEU
--------------------------------------------------------

ALTER TABLE "CATEGORIEJEU" MODIFY (
    "IDCATEGORIEJEU" NOT NULL ENABLE
)

/

ALTER TABLE "CATEGORIEJEU" MODIFY (
    "NOMCATEGORIEJEU" NOT NULL ENABLE
)

/

ALTER TABLE "CATEGORIEJEU"
    ADD CONSTRAINT "CATEGORIEJEU_PK" PRIMARY KEY (
        "IDCATEGORIEJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table CATEGORIEPLATEFORME
--------------------------------------------------------

ALTER TABLE "CATEGORIEPLATEFORME" MODIFY (
    "IDCATEGORIEPLATEFORME" NOT NULL ENABLE
)

/

ALTER TABLE "CATEGORIEPLATEFORME" MODIFY (
    "NOMCATEGORIEPLATEFORME" NOT NULL ENABLE
)

/

ALTER TABLE "CATEGORIEPLATEFORME"
    ADD CONSTRAINT "CATEGORIEPLATEFORME_PK" PRIMARY KEY (
        "IDCATEGORIEPLATEFORME"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table CLASSIFICATIONAGE
--------------------------------------------------------

ALTER TABLE "CLASSIFICATIONAGE" MODIFY (
    "ORGANISMECLASSIFICATION" NOT NULL ENABLE
)

/

ALTER TABLE "CLASSIFICATIONAGE" MODIFY (
    "CLASSIFICATION" NOT NULL ENABLE
)

/

ALTER TABLE "CLASSIFICATIONAGE" MODIFY (
    "IDCLASSIFICATION" NOT NULL ENABLE
)

/

ALTER TABLE "CLASSIFICATIONAGE"
    ADD CONSTRAINT "CLASSIFICATIONAGE_PK" PRIMARY KEY (
        "IDCLASSIFICATION"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table CLASSIFICATIONJEU
--------------------------------------------------------

ALTER TABLE "CLASSIFICATIONJEU" MODIFY (
    "IDCLASSIFICATION" NOT NULL ENABLE
)

/

ALTER TABLE "CLASSIFICATIONJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "CLASSIFICATIONJEU"
    ADD CONSTRAINT "CLASSIFICATIONJEU_PK" PRIMARY KEY (
        "IDCLASSIFICATION",
        "IDJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table COMPAGNIE
--------------------------------------------------------

ALTER TABLE "COMPAGNIE" MODIFY (
    "IDCOMPAGNIE" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIE" MODIFY (
    "NOMCOMPAGNIE" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIE" MODIFY (
    "DATEMAJCOMPAGNIE" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIE"
    ADD CONSTRAINT "COMPAGNIE_PK" PRIMARY KEY (
        "IDCOMPAGNIE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table COMPAGNIEJEU
--------------------------------------------------------

ALTER TABLE "COMPAGNIEJEU" MODIFY (
    "ESTDEVELOPPEUR" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEJEU" MODIFY (
    "ESTPORTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEJEU" MODIFY (
    "ESTPUBLIEUR" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEJEU" MODIFY (
    "ESTSOUTIEN" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEJEU" MODIFY (
    "IDCOMPAGNIE" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEJEU"
    ADD CONSTRAINT "COMPAGNIEJEU_PK" PRIMARY KEY (
        "IDJEU",
        "IDCOMPAGNIE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table COMPAGNIEMOTEUR
--------------------------------------------------------

ALTER TABLE "COMPAGNIEMOTEUR" MODIFY (
    "IDCOMPAGNIE" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEMOTEUR" MODIFY (
    "IDMOTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "COMPAGNIEMOTEUR"
    ADD CONSTRAINT "COMPAGNIEMOTEUR_PK" PRIMARY KEY (
        "IDCOMPAGNIE",
        "IDMOTEUR"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table DATESORTIE
--------------------------------------------------------

ALTER TABLE "DATESORTIE" MODIFY (
    "REGIONSORTIE" NOT NULL ENABLE
)

/

ALTER TABLE "DATESORTIE" MODIFY (
    "DATEMAJDATESORTIE" NOT NULL ENABLE
)

/

ALTER TABLE "DATESORTIE"
    ADD CONSTRAINT "DATESORTIE_PK" PRIMARY KEY (
        "IDDATESORTIE"
    ) USING INDEX ENABLE

/

ALTER TABLE "DATESORTIE" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "DATESORTIE" MODIFY (
    "IDPLATEFORME" NOT NULL ENABLE
)

/

--------------------------------------------------------
--  Constraints for Table FRANCHISE
--------------------------------------------------------
ALTER TABLE "FRANCHISE" MODIFY (
    "IDFRANCHISE" NOT NULL ENABLE
)

/

ALTER TABLE "FRANCHISE" MODIFY (
    "NOMFRANCHISE" NOT NULL ENABLE
)

/

ALTER TABLE "FRANCHISE"
    ADD CONSTRAINT "FRANCHISE_PK" PRIMARY KEY (
        "IDFRANCHISE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table FRANCHISEJEU
--------------------------------------------------------

ALTER TABLE "FRANCHISEJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "FRANCHISEJEU" MODIFY (
    "IDFRANCHISE" NOT NULL ENABLE
)

/

ALTER TABLE "FRANCHISEJEU"
    ADD CONSTRAINT "FRANCHISEJEU_PK" PRIMARY KEY (
        "IDJEU",
        "IDFRANCHISE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table GENRE
--------------------------------------------------------

ALTER TABLE "GENRE" MODIFY (
    "NOMGENRE" NOT NULL ENABLE
)

/

ALTER TABLE "GENRE"
    ADD CONSTRAINT "GENRE_PK" PRIMARY KEY (
        "IDGENRE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table GENREJEU
--------------------------------------------------------

ALTER TABLE "GENREJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "GENREJEU" MODIFY (
    "IDGENRE" NOT NULL ENABLE
)

/

ALTER TABLE "GENREJEU"
    ADD CONSTRAINT "GENREJEU_PK" PRIMARY KEY (
        "IDGENRE",
        "IDJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table JEU
--------------------------------------------------------

ALTER TABLE "JEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "JEU" MODIFY (
    "TITREJEU" NOT NULL ENABLE
)

/

ALTER TABLE "JEU" MODIFY (
    "URLJEU" NOT NULL ENABLE
)

/

ALTER TABLE "JEU" MODIFY (
    "DATEMAJJEU" NOT NULL ENABLE
)

/

ALTER TABLE "JEU"
    ADD CONSTRAINT "JEU_PK" PRIMARY KEY (
        "IDJEU"
    ) USING INDEX ENABLE

/

ALTER TABLE "JEU" MODIFY (
    "CATEGORIEJEU" NOT NULL ENABLE
)

/

--------------------------------------------------------
--  Constraints for Table LOCALISATIONJEU
--------------------------------------------------------
ALTER TABLE "LOCALISATIONJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "LOCALISATIONJEU" MODIFY (
    "IDREGION" NOT NULL ENABLE
)

/

ALTER TABLE "LOCALISATIONJEU"
    ADD CONSTRAINT "LOCALISATIONJEU_PK" PRIMARY KEY (
        "IDJEU",
        "IDREGION"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MODALITE
--------------------------------------------------------

ALTER TABLE "MODALITE" MODIFY (
    "NOMMODALITE" NOT NULL ENABLE
)

/

ALTER TABLE "MODALITE"
    ADD CONSTRAINT "MODALITE_PK" PRIMARY KEY (
        "IDMODALITE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MODALITEJEU
--------------------------------------------------------

ALTER TABLE "MODALITEJEU" MODIFY (
    "IDMODALITE" NOT NULL ENABLE
)

/

ALTER TABLE "MODALITEJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "MODALITEJEU"
    ADD CONSTRAINT "MODALITEJEU_PK" PRIMARY KEY (
        "IDMODALITE",
        "IDJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MOTCLE
--------------------------------------------------------

ALTER TABLE "MOTCLE" MODIFY (
    "IDMOTCLE" NOT NULL ENABLE
)

/

ALTER TABLE "MOTCLE" MODIFY (
    "NOMMOTCLE" NOT NULL ENABLE
)

/

ALTER TABLE "MOTCLE"
    ADD CONSTRAINT "MOTCLE_PK" PRIMARY KEY (
        "IDMOTCLE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MOTCLEJEU
--------------------------------------------------------

ALTER TABLE "MOTCLEJEU" MODIFY (
    "IDMOTCLE" NOT NULL ENABLE
)

/

ALTER TABLE "MOTCLEJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "MOTCLEJEU"
    ADD CONSTRAINT "MOTCLEJEU_PK" PRIMARY KEY (
        "IDMOTCLE",
        "IDJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MOTEUR
--------------------------------------------------------

ALTER TABLE "MOTEUR" MODIFY (
    "IDMOTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "MOTEUR" MODIFY (
    "NOMMOTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "MOTEUR" MODIFY (
    "DATEMAJMOTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "MOTEUR"
    ADD CONSTRAINT "MOTEUR_PK" PRIMARY KEY (
        "IDMOTEUR"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MOTEURJEU
--------------------------------------------------------
ALTER TABLE "MOTEURJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "MOTEURJEU" MODIFY (
    "IDMOTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "MOTEURJEU"
    ADD CONSTRAINT "MOTEURJEU_PK" PRIMARY KEY (
        "IDJEU",
        "IDMOTEUR"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table MODEMULTIJOUEUR
--------------------------------------------------------

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "IDMODEMULTIJOUEUR" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR"
    ADD CONSTRAINT "MODEMULTIJOUEUR_PK" PRIMARY KEY (
        "IDMODEMULTIJOUEUR"
    ) USING INDEX ENABLE

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "MODECOOPCAMPAGNE" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "DROPIN" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "MODECOOPLAN" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "MODECOOPOFFLINE" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "MODECOOPONLINE" NOT NULL ENABLE
)

/

ALTER TABLE "MODEMULTIJOUEUR" MODIFY (
    "MODESPLITSCREEN" NOT NULL ENABLE
)

/

--------------------------------------------------------
--  Constraints for Table PLATEFORME
--------------------------------------------------------
ALTER TABLE "PLATEFORME" MODIFY (
    "IDPLATEFORME" NOT NULL ENABLE
)

/

ALTER TABLE "PLATEFORME" MODIFY (
    "NOMPLATEFORME" NOT NULL ENABLE
)

/

ALTER TABLE "PLATEFORME"
    ADD CONSTRAINT "PLATEFORME_PK" PRIMARY KEY (
        "IDPLATEFORME"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table PLATEFORMEMOTEUR
--------------------------------------------------------

ALTER TABLE "PLATEFORMEMOTEUR" MODIFY (
    "IDMOTEUR" NOT NULL ENABLE
)

/

ALTER TABLE "PLATEFORMEMOTEUR" MODIFY (
    "IDPLATEFORME" NOT NULL ENABLE
)

/

ALTER TABLE "PLATEFORMEMOTEUR"
    ADD CONSTRAINT "PLATEFORMEMOTEUR_PK" PRIMARY KEY (
        "IDMOTEUR",
        "IDPLATEFORME"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table PLATEFORMEMOTEUR
--------------------------------------------------------

ALTER TABLE "POPULARITE" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "POPULARITE" MODIFY (
    "MESUREPOPULARITE" NOT NULL ENABLE
)

/

ALTER TABLE "POPULARITE" MODIFY (
    "VALEURPOPULARITE" NOT NULL ENABLE
)

/

ALTER TABLE "POPULARITE"
    ADD CONSTRAINT "POPULARITE_PK" PRIMARY KEY (
        "IDJEU",
        "MESUREPOPULARITE"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table REGION
--------------------------------------------------------

ALTER TABLE "REGION" MODIFY (
    "IDREGION" NOT NULL ENABLE
)

/

ALTER TABLE "REGION" MODIFY (
    "NOMREGION" NOT NULL ENABLE
)

/

ALTER TABLE "REGION"
    ADD CONSTRAINT "REGION_PK" PRIMARY KEY (
        "IDREGION"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table SIMILARITE
--------------------------------------------------------

ALTER TABLE "SIMILARITE" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "SIMILARITE" MODIFY (
    "IDJEUSIMILAIRE" NOT NULL ENABLE
)

/

ALTER TABLE "SIMILARITE"
    ADD CONSTRAINT "SIMILARITE_PK" PRIMARY KEY (
        "IDJEUSIMILAIRE",
        "IDJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table THEME
--------------------------------------------------------

ALTER TABLE "THEME" MODIFY (
    "IDTHEME" NOT NULL ENABLE
)

/

ALTER TABLE "THEME" MODIFY (
    "NOMTHEME" NOT NULL ENABLE
)

/

ALTER TABLE "THEME"
    ADD CONSTRAINT "THEME_PK" PRIMARY KEY (
        "IDTHEME"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table THEMEJEU
--------------------------------------------------------

ALTER TABLE "THEMEJEU" MODIFY (
    "IDTHEME" NOT NULL ENABLE
)

/

ALTER TABLE "THEMEJEU" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "THEMEJEU"
    ADD CONSTRAINT "THEMEJEU_PK" PRIMARY KEY (
        "IDTHEME",
        "IDJEU"
    ) USING INDEX ENABLE

/

--------------------------------------------------------
--  Constraints for Table TITREALTERNATIF
--------------------------------------------------------

ALTER TABLE "TITREALTERNATIF" MODIFY (
    "IDTITREALTERNATIF" NOT NULL ENABLE
)

/

ALTER TABLE "TITREALTERNATIF" MODIFY (
    "LIBELLETITREALTERNATIF" NOT NULL ENABLE
)

/

ALTER TABLE "TITREALTERNATIF" MODIFY (
    "IDJEU" NOT NULL ENABLE
)

/

ALTER TABLE "TITREALTERNATIF"
    ADD CONSTRAINT "TITREALTERNATIF_PK" PRIMARY KEY (
        "IDTITREALTERNATIF"
    ) USING INDEX ENABLE

/
