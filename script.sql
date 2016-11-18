/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de création :  12/09/2014 02:34:29                      */
/*==============================================================*/

drop table if exists T_E_ABONNE_ABO cascade;

drop table if exists T_E_AVIS_AVI cascade;

drop table if exists T_E_GERANT_GRT cascade;

drop table if exists T_E_LOCATION_LOC cascade;

drop table if exists T_E_PHOTO_PHO cascade;

drop table if exists T_J_EQUIPEMENTLOCATION_EQL cascade;

drop table if exists T_J_LANGUEGERANT_LGT cascade;

drop table if exists T_J_PAIEMENTGERANT_PAG cascade;

drop table if exists T_J_PLANNINGLOCATION_PLO cascade;

drop table if exists T_J_REPONSEQUESTIONLOC_REL cascade;

drop table if exists T_J_TARIFLOCATION_TAR cascade;

drop table if exists T_J_UTILITE_UTI cascade;

drop table if exists T_R_EQUIPEMENT_EQU cascade;

drop table if exists T_R_LANGUE_LNG cascade;

drop table if exists T_R_PAYS_PAY cascade;

drop table if exists T_R_PERIODETARIF_PET cascade;

drop table if exists T_R_PERIODEVISITE_PER cascade;

drop table if exists T_R_QUESTIONLOCATION_QUL cascade;

drop table if exists T_R_TYPEPAIEMENT_TYP cascade;

drop table if exists T_R_TYPESEJOUR_SEJ cascade;

drop table if exists T_R_TYPEVISITELOCATION_VIL cascade;

/*==============================================================*/
/* Table : T_E_ABONNE_ABO                                       */
/*==============================================================*/
create table T_E_ABONNE_ABO (
   ABO_ID               SERIAL               not null,
   ABO_PSEUDO           VARCHAR(20)          not null,
   ABO_MOTPASSE         VARCHAR(128)         not null,
   ABO_MEL              VARCHAR(80)          not null,
   ABO_NOM              VARCHAR(50)          not null,
   ABO_PRENOM           VARCHAR(50)          not null,
   ABO_ADRLIGNE1        VARCHAR(100)         not null,
   ABO_ADRLIGNE2        VARCHAR(100)         null,
   ABO_CP               VARCHAR(10)          not null,
   ABO_VILLE            VARCHAR(50)          not null,
   ABO_ETAT             VARCHAR(50)          null,
   PAY_ID               INT4                 not null,
   ABO_LATITUDE         FLOAT8               not null,
   ABO_LONGITUDE        FLOAT8               not null,
   ABO_INDICATIF        NUMERIC(4)           not null,
   ABO_TEL              VARCHAR(15)          not null,
   ABO_AEROPORT         VARCHAR(50)          null,
   constraint PK_ABO primary key (ABO_ID)
);

/*==============================================================*/
/* Table : T_E_AVIS_AVI                                         */
/*==============================================================*/
create table T_E_AVIS_AVI (
   AVI_ID               SERIAL               not null,
   ABO_ID               INT4                 not null,
   LOC_ID               INT4                 not null,
   VIS_ID               INT4                 not null,
   PER_ID               INT4                 not null,
   LNG_ID               INT4                 not null,
   AVI_NOMOCCUPANT      VARCHAR(80)          not null,
   AVI_DATE             DATE                 not null default CURRENT_DATE,
   AVI_TITRE            VARCHAR(100)         not null,
   AVI_DETAIL           VARCHAR(2000)        not null,
   AVI_NOTEGLOBALE      NUMERIC(1)           not null,
   AVI_RECOMMANDATIONAMI BOOL                 not null,
   AVI_ReponseAvis		VARCHAR(1000),
   constraint PK_AVI primary key (AVI_ID)
);

/*==============================================================*/
/* Table : T_E_GERANT_GRT                                       */
/*==============================================================*/
create table T_E_GERANT_GRT (
   GRT_ID               SERIAL               not null,
   GRT_NOM              VARCHAR(80)          not null,
   GRT_TAUXREPONSE      NUMERIC(3)           null,
   GRT_DELAIREPONSE     VARCHAR(20)          null,
   GRT_DATEINSCRIPTION  DATE                 not null default CURRENT_DATE,
   GRT_MEL              VARCHAR(80)          not null,
   constraint PK_GRT primary key (GRT_ID)
);

/*==============================================================*/
/* Table : T_E_LOCATION_LOC                                     */
/*==============================================================*/
create table T_E_LOCATION_LOC (
   LOC_ID               SERIAL               not null,
   GRT_ID               INT4                 not null,
   LOC_TITRE            VARCHAR(80)          not null,
   LOC_TYPE             VARCHAR(20)          not null
      constraint CK_LOC_TYPE check (LOC_TYPE in ('Appartement','Logement')),
   LOC_DESCRIPTION      VARCHAR(2000)         not null,
   LOC_NBCHAMBRES       NUMERIC(2)           not null,
   LOC_NBCOUCHAGES      NUMERIC(2)           not null,
   LOC_NBSALLESBAIN     NUMERIC(2)           not null,
   LOC_NBOCCUPANTS      NUMERIC(3)           not null,
   LOC_CODERESERVATIONTRIP INT4       		 not null,
   	  constraint CK_LOC_CODERESERVATIONTRIP check (LOC_CODERESERVATIONTRIP in (0, 1)),
   LOC_ADRLIGNE1        VARCHAR(100)         not null,
   LOC_ADRLIGNE2        VARCHAR(100)         null,
   LOC_CP               VARCHAR(10)          not null,
   LOC_VILLE            VARCHAR(50)          not null,
   LOC_ETAT             VARCHAR(50)          null,
   PAY_ID               INT4                 not null,
   LOC_LATITUDE         FLOAT8               not null,
   LOC_LONGITUDE        FLOAT8               not null,
   constraint PK_LOC primary key (LOC_ID)
);

/*==============================================================*/
/* Table : T_E_PHOTO_PHO                                        */
/*==============================================================*/
create table T_E_PHOTO_PHO (
   PHO_ID               SERIAL               not null,
   LOC_ID               INT4                 null,
   AVI_ID               INT4                 null,
   PHO_URL              VARCHAR(100)         not null,
   constraint PK_PHO primary key (PHO_ID)
);

/*==============================================================*/
/* Table : T_J_EQUIPEMENTLOCATION_EQL                           */
/*==============================================================*/
create table T_J_EQUIPEMENTLOCATION_EQL (
   LOC_ID               INT4                 not null,
   EQU_ID               INT4                 not null,
   EQL_NOMBRE           NUMERIC(2)           not null,
   constraint PK_EQL primary key (EQU_ID, LOC_ID)
);

/*==============================================================*/
/* Table : T_J_LANGUEGERANT_LGT                                 */
/*==============================================================*/
create table T_J_LANGUEGERANT_LGT (
   GRT_ID               INT4                 not null,
   LNG_ID               INT4                 not null,
   constraint PK_LGT primary key (LNG_ID, GRT_ID)
);

/*==============================================================*/
/* Table : T_J_PAIEMENTGERANT_PAG                               */
/*==============================================================*/
create table T_J_PAIEMENTGERANT_PAG (
   GRT_ID               INT4                 not null,
   TYP_ID               INT4                 not null,
   constraint PK_PAG primary key (GRT_ID, TYP_ID)
);

/*==============================================================*/
/* Table : T_J_PLANNINGLOCATION_PLO                             */
/*==============================================================*/
create table T_J_PLANNINGLOCATION_PLO (
   LOC_ID               INT4                 not null,
   PLO_DATELOCATION     DATE                 not null,
   PLO_DISPONIBILITE    BOOL                 not null,
   constraint PK_PLO primary key (PLO_DATELOCATION, LOC_ID)
);

/*==============================================================*/
/* Table : T_J_REPONSEQUESTIONLOC_REL                           */
/*==============================================================*/
create table T_J_REPONSEQUESTIONLOC_REL (
   AVI_ID               INT4                 not null,
   QUL_ID               INT4                 not null,
   REL_REPONSE          VARCHAR(100)         not null,
   constraint PK_REL primary key (AVI_ID, QUL_ID)
);

/*==============================================================*/
/* Table : T_J_TARIFLOCATION_TAR                                */
/*==============================================================*/
create table T_J_TARIFLOCATION_TAR (
   LOC_ID               INT4                 not null,
   PET_ID               INT4                 not null,
   SEJ_ID               INT4                 not null,
   TAR_PRIX             NUMERIC(6,2)         not null,
   constraint PK_TAR primary key (LOC_ID, PET_ID, SEJ_ID)
);

/*==============================================================*/
/* Table : T_J_UTILITE_UTI                                      */
/*==============================================================*/
create table T_J_UTILITE_UTI (
   ABO_ID               INT4                 not null,
   AVI_ID               INT4                 not null,
   constraint PK_UTI primary key (ABO_ID, AVI_ID)
);

/*==============================================================*/
/* Table : T_R_EQUIPEMENT_EQU                                   */
/*==============================================================*/
create table T_R_EQUIPEMENT_EQU (
   EQU_ID               SERIAL               not null,
   EQU_LIBELLE          VARCHAR(30)          not null,
   constraint PK_EQU primary key (EQU_ID)
);

/*==============================================================*/
/* Table : T_R_LANGUE_LNG                                       */
/*==============================================================*/
create table T_R_LANGUE_LNG (
   LNG_ID               SERIAL               not null,
   LNG_LIBELLE          VARCHAR(20)          not null,
   constraint PK_LNG primary key (LNG_ID)
);

/*==============================================================*/
/* Table : T_R_PAYS_PAY                                         */
/*==============================================================*/
create table T_R_PAYS_PAY (
   PAY_ID               SERIAL               not null,
   PAY_NOM              VARCHAR(50)          not null,
   constraint PK_PAY primary key (PAY_ID)
);

/*==============================================================*/
/* Table : T_R_PERIODETARIF_PET                                 */
/*==============================================================*/
create table T_R_PERIODETARIF_PET (
   PET_ID               SERIAL               not null,
   PET_INTITULE         VARCHAR(30)          null,
   PET_DATEDEB          DATE                 null,
   PET_DATEFIN          DATE                 null,
   constraint PK_PET primary key (PET_ID)
);

/*==============================================================*/
/* Table : T_R_PERIODEVISITE_PER                                */
/*==============================================================*/
create table T_R_PERIODEVISITE_PER (
   PER_ID               SERIAL               not null,
   PER_MOIS             NUMERIC(2)           not null
      constraint CK_PER_MOIS check (PER_MOIS between 1 and 12),
   PER_ANNEE            NUMERIC(4)           not null,
   constraint PK_PER primary key (PER_ID),
   constraint UQ_PER unique (PER_MOIS, PER_ANNEE)
);

/*==============================================================*/
/* Table : T_R_QUESTIONLOCATION_QUL                             */
/*==============================================================*/
create table T_R_QUESTIONLOCATION_QUL (
   QUL_ID               SERIAL               not null,
   QUL_QUESTION         VARCHAR(200)         not null,
   constraint PK_QUL primary key (QUL_ID)
);

/*==============================================================*/
/* Table : T_R_TYPEPAIEMENT_TYP                                 */
/*==============================================================*/
create table T_R_TYPEPAIEMENT_TYP (
   TYP_ID               SERIAL               not null,
   TYP_LIBELLE          VARCHAR(20)          not null,
   constraint PK_TYP primary key (TYP_ID)
);

/*==============================================================*/
/* Table : T_R_TYPESEJOUR_SEJ                                   */
/*==============================================================*/
create table T_R_TYPESEJOUR_SEJ (
   SEJ_ID               SERIAL               not null,
   SEJ_LIBELLE          VARCHAR(20)          not null,
   constraint PK_SEJ primary key (SEJ_ID)
);

/*==============================================================*/
/* Table : T_R_TYPEVISITELOCATION_VIL                           */
/*==============================================================*/
create table T_R_TYPEVISITELOCATION_VIL (
   VIL_ID               SERIAL               not null,
   VIL_LIBELLE          VARCHAR(50)          not null,
   constraint PK_VIL primary key (VIL_ID)
);

alter table T_E_ABONNE_ABO
   add constraint FK_ABO_PAY foreign key (PAY_ID)
      references T_R_PAYS_PAY (PAY_ID)
      on delete restrict on update restrict;
create index IX_ABO_PAY_ID on T_E_ABONNE_ABO(PAY_ID);

alter table T_E_AVIS_AVI
   add constraint FK_AVI_VIS foreign key (VIS_ID)
      references T_R_TYPEVISITELOCATION_VIL (VIL_ID)
      on delete restrict on update restrict;
create index IX_AVI_VIS_ID on T_E_AVIS_AVI(VIS_ID);

alter table T_E_AVIS_AVI
   add constraint FK_AVI_PER foreign key (PER_ID)
      references T_R_PERIODEVISITE_PER (PER_ID)
      on delete restrict on update restrict;
create index IX_AVI_PER_ID on T_E_AVIS_AVI(PER_ID);

alter table T_E_AVIS_AVI
   add constraint FK_AVI_ABO foreign key (ABO_ID)
      references T_E_ABONNE_ABO (ABO_ID)
      on delete restrict on update restrict;
create index IX_AVI_ABO_ID on T_E_AVIS_AVI(ABO_ID);

alter table T_E_AVIS_AVI
   add constraint FK_AVI_LOC foreign key (LOC_ID)
      references T_E_LOCATION_LOC (LOC_ID)
      on delete restrict on update restrict;
create index IX_AVI_LOC_ID on T_E_AVIS_AVI(LOC_ID);

alter table T_E_AVIS_AVI
   add constraint FK_AVI_LNG foreign key (LNG_ID)
      references T_R_LANGUE_LNG (LNG_ID)
      on delete restrict on update restrict;
create index IX_AVI_LNG_ID on T_E_AVIS_AVI(LNG_ID);

alter table T_E_LOCATION_LOC
   add constraint FK_LOC_PAY foreign key (PAY_ID)
      references T_R_PAYS_PAY (PAY_ID)
      on delete restrict on update restrict;
create index IX_LOC_PAY_ID on T_E_LOCATION_LOC(PAY_ID);

alter table T_E_LOCATION_LOC
   add constraint FK_LOC_GRT foreign key (GRT_ID)
      references T_E_GERANT_GRT (GRT_ID)
      on delete restrict on update restrict;
create index IX_LOC_GRT_ID on T_E_LOCATION_LOC(GRT_ID);

alter table T_E_PHOTO_PHO
   add constraint FK_PHO_AVI foreign key (AVI_ID)
      references T_E_AVIS_AVI (AVI_ID)
      on delete restrict on update restrict;
create index IX_PHO_AVI_ID on T_E_PHOTO_PHO(AVI_ID);

alter table T_E_PHOTO_PHO
   add constraint FK_PHO_LOC foreign key (LOC_ID)
      references T_E_LOCATION_LOC (LOC_ID)
      on delete restrict on update restrict;
create index IX_PHO_LOC_ID on T_E_PHOTO_PHO(LOC_ID);

alter table T_J_EQUIPEMENTLOCATION_EQL
   add constraint FK_EQL_EQU foreign key (EQU_ID)
      references T_R_EQUIPEMENT_EQU (EQU_ID)
      on delete restrict on update restrict;
create index IX_EQL_EQU_ID on T_J_EQUIPEMENTLOCATION_EQL(EQU_ID);

alter table T_J_EQUIPEMENTLOCATION_EQL
   add constraint FK_EQL_LOC foreign key (LOC_ID)
      references T_E_LOCATION_LOC (LOC_ID)
      on delete restrict on update restrict;
create index IX_EQL_LOC_ID on T_J_EQUIPEMENTLOCATION_EQL(LOC_ID);

alter table T_J_LANGUEGERANT_LGT
   add constraint FK_LGT_LNG foreign key (LNG_ID)
      references T_R_LANGUE_LNG (LNG_ID)
      on delete restrict on update restrict;
create index IX_LGT_LNG_ID on T_J_LANGUEGERANT_LGT(LNG_ID);

alter table T_J_LANGUEGERANT_LGT
   add constraint FK_LGT_GRT foreign key (GRT_ID)
      references T_E_GERANT_GRT (GRT_ID)
      on delete restrict on update restrict;
create index IX_LGT_GRT_ID on T_J_LANGUEGERANT_LGT(GRT_ID);

alter table T_J_PAIEMENTGERANT_PAG
   add constraint FK_PAG_TYP foreign key (TYP_ID)
      references T_R_TYPEPAIEMENT_TYP (TYP_ID)
      on delete restrict on update restrict;
create index IX_PAG_TYP_ID on T_J_PAIEMENTGERANT_PAG(TYP_ID);

alter table T_J_PAIEMENTGERANT_PAG
   add constraint FK_PAG_GRT foreign key (GRT_ID)
      references T_E_GERANT_GRT (GRT_ID)
      on delete restrict on update restrict;
create index IX_PAG_GRT_ID on T_J_PAIEMENTGERANT_PAG(GRT_ID);

alter table T_J_PLANNINGLOCATION_PLO
   add constraint FK_PLO_LOC foreign key (LOC_ID)
      references T_E_LOCATION_LOC (LOC_ID)
      on delete restrict on update restrict;
create index IX_PLO_LOC_ID on T_J_PLANNINGLOCATION_PLO(LOC_ID);

alter table T_J_REPONSEQUESTIONLOC_REL
   add constraint FK_REL_AVI foreign key (AVI_ID)
      references T_E_AVIS_AVI (AVI_ID)
      on delete restrict on update restrict;
create index IX_REL_AVI_ID on T_J_REPONSEQUESTIONLOC_REL(AVI_ID);

alter table T_J_REPONSEQUESTIONLOC_REL
   add constraint FK_REL_QUL foreign key (QUL_ID)
      references T_R_QUESTIONLOCATION_QUL (QUL_ID)
      on delete restrict on update restrict;
create index IX_REL_QUL_ID on T_J_REPONSEQUESTIONLOC_REL(QUL_ID);

alter table T_J_TARIFLOCATION_TAR
   add constraint FK_TAR_LOC foreign key (LOC_ID)
      references T_E_LOCATION_LOC (LOC_ID)
      on delete restrict on update restrict;
create index IX_TAR_LOC_ID on T_J_TARIFLOCATION_TAR(LOC_ID);

alter table T_J_TARIFLOCATION_TAR
   add constraint FK_TAR_PET foreign key (PET_ID)
      references T_R_PERIODETARIF_PET (PET_ID)
      on delete restrict on update restrict;
create index IX_TAR_PET_ID on T_J_TARIFLOCATION_TAR(PET_ID);

alter table T_J_TARIFLOCATION_TAR
   add constraint FK_TAR_SEJ foreign key (SEJ_ID)
      references T_R_TYPESEJOUR_SEJ (SEJ_ID)
      on delete restrict on update restrict;
create index IX_TAR_SEJ_ID on T_J_TARIFLOCATION_TAR(SEJ_ID);

alter table T_J_UTILITE_UTI
   add constraint FK_UTI_ABO foreign key (ABO_ID)
      references T_E_ABONNE_ABO (ABO_ID)
      on delete restrict on update restrict;
create index IX_UTI_ABO_ID on T_J_UTILITE_UTI(ABO_ID);

alter table T_J_UTILITE_UTI
   add constraint FK_UTI_AVI foreign key (AVI_ID)
      references T_E_AVIS_AVI (AVI_ID)
      on delete restrict on update restrict;
create index IX_UTI_AVI_ID on T_J_UTILITE_UTI(AVI_ID);


/*==============================================================*/
/* INSERT                    */
/*==============================================================*/

insert into t_r_langue_lng(lng_libelle) values ('English');
insert into t_r_langue_lng(lng_libelle) values ('Français');

insert into t_r_typepaiement_typ(typ_libelle) values ('CB');
insert into t_r_typepaiement_typ(typ_libelle) values ('Paypal');

Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Gregory House', 70, 'En quelques heures',  current_date-1000, 'GregoryHouse@gmail.com'); 

Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (1,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (1,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (2,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (3,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (4,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (4,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (5,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (5,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (6,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (7,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (8,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (8,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (9,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (10,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (11,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (12,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (13,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (14,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (14,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (15,1);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (21,2);
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (22,2);
insert into t_j_languegerant_lgt values(2,2);
insert into t_j_languegerant_lgt values(3,2);
insert into t_j_languegerant_lgt values(4,2);
insert into t_j_languegerant_lgt values(5,2);
insert into t_j_languegerant_lgt values(6,2);
insert into t_j_languegerant_lgt values(7,2);
insert into t_j_languegerant_lgt values(8,1);
insert into t_j_languegerant_lgt values(8,2);
insert into t_j_languegerant_lgt values(9,1);
insert into t_j_languegerant_lgt values(9,2);
insert into t_j_languegerant_lgt values(10,1);
insert into t_j_languegerant_lgt values(10,2);
insert into t_j_languegerant_lgt values(11,1);
insert into t_j_languegerant_lgt values(11,2);
insert into t_j_languegerant_lgt values(12,1);
insert into t_j_languegerant_lgt values(13,1);
insert into t_j_languegerant_lgt values(13,2);
insert into t_j_languegerant_lgt values(14,1);
insert into t_j_languegerant_lgt values(15,1);
insert into t_j_languegerant_lgt values(16,1);
insert into t_j_languegerant_lgt values(16,2);
insert into t_j_languegerant_lgt values(17,1);
insert into t_j_languegerant_lgt values(18,1);
insert into t_j_languegerant_lgt values(18,2);
insert into t_j_languegerant_lgt values(19,1);
insert into t_j_languegerant_lgt values(20,1);
insert into t_j_languegerant_lgt values(20,2);
insert into t_j_languegerant_lgt values(21,1);
insert into t_j_languegerant_lgt values(22,1);
insert into t_j_languegerant_lgt values(22,2);

Insert into t_r_equipement_equ(equ_libelle) values('Bouilloire');
Insert into t_r_equipement_equ(equ_libelle) values('Canapés-lits');
Insert into t_r_equipement_equ(equ_libelle) values('Chaîne stéréo');
Insert into t_r_equipement_equ(equ_libelle) values('Congélateur');
Insert into t_r_equipement_equ(equ_libelle) values('Draps fournis');
Insert into t_r_equipement_equ(equ_libelle) values('Entretien inclus');
Insert into t_r_equipement_equ(equ_libelle) values('Fer à repasser');
Insert into t_r_equipement_equ(equ_libelle) values('Four');
Insert into t_r_equipement_equ(equ_libelle) values('Grille-pain');
Insert into t_r_equipement_equ(equ_libelle) values('Guides/cartes des environs');
Insert into t_r_equipement_equ(equ_libelle) values('Machine à laver');
Insert into t_r_equipement_equ(equ_libelle) values('Micro-ondes');
Insert into t_r_equipement_equ(equ_libelle) values('Pêche privée en Lac/Rivière');
Insert into t_r_equipement_equ(equ_libelle) values('Réfrigérateur');
Insert into t_r_equipement_equ(equ_libelle) values('Réveil');
Insert into t_r_equipement_equ(equ_libelle) values('Savon/shampooing fournis');
Insert into t_r_equipement_equ(equ_libelle) values('Sèche-cheveux');
Insert into t_r_equipement_equ(equ_libelle) values('Serviettes fournies');
Insert into t_r_equipement_equ(equ_libelle) values('Télévision');
Insert into t_r_equipement_equ(equ_libelle) values('Vue sur la montagne');
Insert into t_r_equipement_equ(equ_libelle) values('Accès internet');
Insert into t_r_equipement_equ(equ_libelle) values('Chauffage central');
Insert into t_r_equipement_equ(equ_libelle) values('Lecteur de cassettes vidéo');
Insert into t_r_equipement_equ(equ_libelle) values('Wi-Fi');
Insert into t_r_equipement_equ(equ_libelle) values('Télévision par satellite');
Insert into t_r_equipement_equ(equ_libelle) values('Vue sur la mer');
Insert into t_r_equipement_equ(equ_libelle) values('Balcon');
Insert into t_r_equipement_equ(equ_libelle) values('Chaise haute');
Insert into t_r_equipement_equ(equ_libelle) values('Jardin privé');
Insert into t_r_equipement_equ(equ_libelle) values('Livres');
Insert into t_r_equipement_equ(equ_libelle) values('Parking');
Insert into t_r_equipement_equ(equ_libelle) values('Salon extérieur');
Insert into t_r_equipement_equ(equ_libelle) values('Sèche-linge');
Insert into t_r_equipement_equ(equ_libelle) values('Terrasse');

Insert into t_r_pays_pay(pay_nom) values('Afghanistan');
Insert into t_r_periodevisite_per(per_mois, per_annee) values(1, 2010);

insert into t_r_periodetarif_pet(pet_intitule, pet_datedeb, pet_datefin) values('Hors saison', to_date('01/01/2016', 'DD/MM/YYYY'), to_date('30/06/2016', 'DD/MM/YYYY'));
insert into t_r_periodetarif_pet(pet_intitule, pet_datedeb, pet_datefin) values('Saison haute', to_date('01/07/2016', 'DD/MM/YYYY'), to_date('31/08/2016', 'DD/MM/YYYY'));
insert into t_r_periodetarif_pet(pet_intitule, pet_datedeb, pet_datefin) values('Hors saison', to_date('01/09/2016', 'DD/MM/YYYY'), to_date('31/12/2016', 'DD/MM/YYYY'));

insert into t_j_tariflocation_tar values (1, 2, 1, 180);
insert into t_j_tariflocation_tar values (1, 2, 2, 400);
insert into t_j_tariflocation_tar values (1, 2, 3, 1000);
insert into t_j_tariflocation_tar values (1, 3, 1, 250);
insert into t_j_tariflocation_tar values (1, 3, 2, 600);
insert into t_j_tariflocation_tar values (1, 3, 3, 1500);
insert into t_j_tariflocation_tar values (1, 4, 1, 180);
insert into t_j_tariflocation_tar values (1, 4, 2, 400);
insert into t_j_tariflocation_tar values (1, 4, 3, 1000);
insert into t_j_tariflocation_tar values (2, 1, 1, 120);
insert into t_j_tariflocation_tar values (2, 1, 2, 300);
insert into t_j_tariflocation_tar values (2, 1, 3, 800);
Insert into t_r_questionlocation_qul(qul_question) values ('L''itinéraire donné était-il correct ?'); --2
Insert into t_r_questionlocation_qul(qul_question) values ('La remise des clés/l''accès à la location ont-ils été faciles ?'); --3
Insert into t_r_questionlocation_qul(qul_question) values ('État général de la location'); --4
Insert into t_r_questionlocation_qul(qul_question) values ('Literie'); --5
Insert into t_r_questionlocation_qul(qul_question) values ('Cuisine et ustensiles'); --6
Insert into t_r_questionlocation_qul(qul_question) values ('Propreté de la salle de bains'); --7
Insert into t_r_questionlocation_qul(qul_question) values ('Autres services'); --8
Insert into t_r_questionlocation_qul(qul_question) values ('Service clientèle général'); --9
Insert into t_r_questionlocation_qul(qul_question) values ('La location était-elle conforme à l''annonce ?'); --10
Insert into t_r_questionlocation_qul(qul_question) values ('Recommanderiez-vous cette location ?'); --11
Insert into t_r_questionlocation_qul(qul_question) values ('Le rapport qualité-prix était-il bon ?'); --12
Insert into t_r_questionlocation_qul(qul_question) values ('La location était-elle équipée d''un accès Internet ?'); --13
Insert into t_r_questionlocation_qul(qul_question) values ('Votre caution vous a-t-elle été restituée dans les délais prévus ?'); -- 14
Insert into t_r_questionlocation_qul(qul_question) values ('Qu''avez-vous préféré ?'); --15
Insert into t_r_questionlocation_qul(qul_question) values ('Qu''avez-vous le moins aimé ?'); --16

insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 1, 'Fantastique');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 2, 'Fantastique');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 3, 'Bon');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 4, 'Fantastique');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 5, 'Bon');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 6, 'Bon');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 7, 'Bon');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 8, 'n/a');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 9, 'n/a');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 10, 'Oui');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 11, 'Oui');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 12, 'Oui');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 13, 'Oui');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 14, 'n/a');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 15, 'La décoration est magnifique. Les propriétaires sont très sympathiques.');
insert into T_J_ReponseQuestionLoc_REL(avi_id, qul_id, rel_reponse) values (1, 16, 'Rien');

Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(null, 2, 'images/img15.jpg');  
insert into t_j_utilite_uti values (1,1);
insert into t_j_utilite_uti values (2,1);
insert into t_j_utilite_uti values (3,1);
insert into t_j_utilite_uti values (3,2);
insert into t_j_utilite_uti values (4,2);
insert into t_j_utilite_uti values (5,2);
insert into t_j_utilite_uti values (1,2);