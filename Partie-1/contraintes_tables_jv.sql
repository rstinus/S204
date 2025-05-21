--------------------------------------------------------
--  Ref Constraints for Table CLASSIFICATIONJEU
--------------------------------------------------------

ALTER TABLE "CLASSIFICATIONJEU"
    ADD CONSTRAINT "CLASSIFICATIONJEU_FK1" FOREIGN KEY (
        "IDCLASSIFICATION"
    )
        REFERENCES "CLASSIFICATIONAGE" (
            "IDCLASSIFICATION"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "CLASSIFICATIONJEU"
    ADD CONSTRAINT "CLASSIFICATIONJEU_FK2" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table COMPAGNIE
--------------------------------------------------------

ALTER TABLE "COMPAGNIE"
    ADD CONSTRAINT "COMPAGNIE_FK1" FOREIGN KEY (
        "COMPAGNIEPARENT"
    )
        REFERENCES "COMPAGNIE" (
            "IDCOMPAGNIE"
        ) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table COMPAGNIEJEU
--------------------------------------------------------

ALTER TABLE "COMPAGNIEJEU"
    ADD CONSTRAINT "COMPAGNIEJEU_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "COMPAGNIEJEU"
    ADD CONSTRAINT "COMPAGNIEJEU_FK2" FOREIGN KEY (
        "IDCOMPAGNIE"
    )
        REFERENCES "COMPAGNIE" (
            "IDCOMPAGNIE"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table COMPAGNIEMOTEUR
--------------------------------------------------------

ALTER TABLE "COMPAGNIEMOTEUR"
    ADD CONSTRAINT "COMPAGNIEMOTEUR_FK1" FOREIGN KEY (
        "IDCOMPAGNIE"
    )
        REFERENCES "COMPAGNIE" (
            "IDCOMPAGNIE"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "COMPAGNIEMOTEUR"
    ADD CONSTRAINT "COMPAGNIEMOTEUR_FK2" FOREIGN KEY (
        "IDMOTEUR"
    )
        REFERENCES "MOTEUR" (
            "IDMOTEUR"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table DATESORTIE
--------------------------------------------------------

ALTER TABLE "DATESORTIE"
    ADD CONSTRAINT "DATESORTIE_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "DATESORTIE"
    ADD CONSTRAINT "DATESORTIE_FK2" FOREIGN KEY (
        "IDPLATEFORME"
    )
        REFERENCES "PLATEFORME" (
            "IDPLATEFORME"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table FRANCHISEJEU
--------------------------------------------------------

ALTER TABLE "FRANCHISEJEU"
    ADD CONSTRAINT "FRANCHISEJEU_FK1" FOREIGN KEY (
        "IDFRANCHISE"
    )
        REFERENCES "FRANCHISE" (
            "IDFRANCHISE"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "FRANCHISEJEU"
    ADD CONSTRAINT "FRANCHISEJEU_FK2" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table GENREJEU
--------------------------------------------------------

ALTER TABLE "GENREJEU"
    ADD CONSTRAINT "GENREJEU_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "GENREJEU"
    ADD CONSTRAINT "GENREJEU_FK2" FOREIGN KEY (
        "IDGENRE"
    )
        REFERENCES "GENRE" (
            "IDGENRE"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table JEU
--------------------------------------------------------

ALTER TABLE "JEU"
    ADD CONSTRAINT "JEU_FK1" FOREIGN KEY (
        "VERSIONPARENT"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED ENABLE

/

ALTER TABLE "JEU"
    ADD CONSTRAINT "JEU_FK2" FOREIGN KEY (
        "IDJEUPARENT"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED ENABLE

/

ALTER TABLE "JEU"
    ADD CONSTRAINT "JEU_FK3" FOREIGN KEY (
        "FRANCHISEPRINCIPALEJEU"
    )
        REFERENCES "FRANCHISE" (
            "IDFRANCHISE"
        ) DEFERRABLE INITIALLY DEFERRED ENABLE

/

ALTER TABLE "JEU"
    ADD CONSTRAINT "JEU_FK4" FOREIGN KEY (
        "CATEGORIEJEU"
    )
        REFERENCES "CATEGORIEJEU" (
            "IDCATEGORIEJEU"
        ) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table LOCALISATIONJEU
--------------------------------------------------------

ALTER TABLE "LOCALISATIONJEU"
    ADD CONSTRAINT "LOCALISATIONJEU_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "LOCALISATIONJEU"
    ADD CONSTRAINT "LOCALISATIONJEU_FK2" FOREIGN KEY (
        "IDREGION"
    )
        REFERENCES "REGION" (
            "IDREGION"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table MODALITEJEU
--------------------------------------------------------

ALTER TABLE "MODALITEJEU"
    ADD CONSTRAINT "MODALITEJEU_FK1" FOREIGN KEY (
        "IDMODALITE"
    )
        REFERENCES "MODALITE" (
            "IDMODALITE"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "MODALITEJEU"
    ADD CONSTRAINT "MODALITEJEU_FK2" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table MOTCLEJEU
--------------------------------------------------------

ALTER TABLE "MOTCLEJEU"
    ADD CONSTRAINT "MOTCLEJEU_FK1" FOREIGN KEY (
        "IDMOTCLE"
    )
        REFERENCES "MOTCLE" (
            "IDMOTCLE"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "MOTCLEJEU"
    ADD CONSTRAINT "MOTCLEJEU_FK2" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table MOTEURJEU
--------------------------------------------------------

ALTER TABLE "MOTEURJEU"
    ADD CONSTRAINT "MOTEURJEU_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "MOTEURJEU"
    ADD CONSTRAINT "MOTEURJEU_FK2" FOREIGN KEY (
        "IDMOTEUR"
    )
        REFERENCES "MOTEUR" (
            "IDMOTEUR"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table MODEMULTIJOUEUR
--------------------------------------------------------

ALTER TABLE "MODEMULTIJOUEUR"
    ADD CONSTRAINT "MODEMULTIJOUEUR_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "MODEMULTIJOUEUR"
    ADD CONSTRAINT "MODEMULTIJOUEUR_FK2" FOREIGN KEY (
        "IDPLATEFORME"
    )
        REFERENCES "PLATEFORME" (
            "IDPLATEFORME"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table PLATEFORME
--------------------------------------------------------

ALTER TABLE "PLATEFORME"
    ADD CONSTRAINT "PLATEFORME_FK1" FOREIGN KEY (
        "IDCATEGORIEPLATEFORME"
    )
        REFERENCES "CATEGORIEPLATEFORME" (
            "IDCATEGORIEPLATEFORME"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table PLATEFORMEMOTEUR
--------------------------------------------------------

ALTER TABLE "PLATEFORMEMOTEUR"
    ADD CONSTRAINT "PLATEFORMEMOTEUR_FK1" FOREIGN KEY (
        "IDMOTEUR"
    )
        REFERENCES "MOTEUR" (
            "IDMOTEUR"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "PLATEFORMEMOTEUR"
    ADD CONSTRAINT "PLATEFORMEMOTEUR_FK2" FOREIGN KEY (
        "IDPLATEFORME"
    )
        REFERENCES "PLATEFORME" (
            "IDPLATEFORME"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table POPULARITE
--------------------------------------------------------

ALTER TABLE "POPULARITE"
    ADD CONSTRAINT "POPULARITE_FK" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table SIMILARITE
--------------------------------------------------------

ALTER TABLE "SIMILARITE"
    ADD CONSTRAINT "SIMILARITE_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "SIMILARITE"
    ADD CONSTRAINT "SIMILARITE_FK2" FOREIGN KEY (
        "IDJEUSIMILAIRE"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table THEMEJEU
--------------------------------------------------------

ALTER TABLE "THEMEJEU"
    ADD CONSTRAINT "THEMEJEU_FK1" FOREIGN KEY (
        "IDTHEME"
    )
        REFERENCES "THEME" (
            "IDTHEME"
        ) ON DELETE CASCADE ENABLE

/

ALTER TABLE "THEMEJEU"
    ADD CONSTRAINT "THEMEJEU_FK2" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/

--------------------------------------------------------
--  Ref Constraints for Table TITREALTERNATIF
--------------------------------------------------------

ALTER TABLE "TITREALTERNATIF"
    ADD CONSTRAINT "TITREALTERNATIF_FK1" FOREIGN KEY (
        "IDJEU"
    )
        REFERENCES "JEU" (
            "IDJEU"
        ) ON DELETE CASCADE ENABLE

/