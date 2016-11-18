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

Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Gregory House', 70, 'En quelques heures',  current_date-1000, 'GregoryHouse@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Lisa Cuddy', 80, 'en deux jours',  current_date-900, 'LisaCuddy@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('James Wilson', 90, 'en quelques heures',  current_date-800, 'JamesWilson@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Eric Foreman', 50, 'en 24 heures',  current_date-700, 'EricForeman@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Allison Cameron', 96, 'en 24 heures',  current_date-600, 'AllisonCameron@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Robert Chase', 99, 'en 24 heures',  current_date-500, 'RobertChase@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Chris Taub', 90, 'en 24 heures',  current_date-400, 'ChrisTaub@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Remy Hadley', 89, 'en 24 heures', current_date-300, 'RemyHadley@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Lawrence Kutner', 99, 'en deux jours',  current_date-200, 'LawrenceKutner@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Martha M. Masters', 100, 'en quelques heures',  current_date-100, 'MarthaM.Masters@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Jessica Adams', 90, 'en deux jours',  current_date-90, 'JessicaAdams@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Chi Park', 90, 'en quelques heures',  current_date-80, 'ChiPark@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Patrick Jane', 20, 'en deux jours',  current_date-70, 'PatrickJane@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Teresa Lisbon', 90, 'en quelques heures',  current_date-60, 'TeresaLisbon@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Kimball Cho', 100, 'en 24 heures',  current_date-50, 'KimballCho@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Wayne Rigsby', 95, 'en 24 heures',  current_date-40, 'WayneRigsby@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Grace Van Pelt', 15, 'En quelques heures',  current_date-30, 'GraceVanPelt@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Dennis Abbot', 82, 'en deux jours',  current_date-20, 'DennisAbbot@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Kim Fisher', 90, 'en quelques heures',  current_date-10, 'KimFisher@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Jason Wylie', 90, 'En quelques heures',  current_date-0, 'JasonWylie@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('Michelle Vega', 100, 'en deux jours',  current_date-10, 'MichelleVega@gmail.com'); Insert into t_e_gerant_grt(grt_nom, grt_tauxreponse, grt_delaireponse, grt_dateinscription, grt_mel) values('John le Rouge', 35, 'en quelques heures',  current_date-20, 'JohnleRouge@gmail.com'); 

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
Insert into T_J_PaiementGerant_PAG(GRT_ID, TYP_ID) values (22,2);insert into t_j_languegerant_lgt values(1,2);
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

Insert into t_r_pays_pay(pay_nom) values('Afghanistan');Insert into t_r_pays_pay(pay_nom) values('Afrique du Sud');Insert into t_r_pays_pay(pay_nom) values('Albanie');Insert into t_r_pays_pay(pay_nom) values('Algérie');Insert into t_r_pays_pay(pay_nom) values('Allemagne');Insert into t_r_pays_pay(pay_nom) values('Angola');Insert into t_r_pays_pay(pay_nom) values('Antigua-et-Barbuda');Insert into t_r_pays_pay(pay_nom) values('Arabie saoudite');Insert into t_r_pays_pay(pay_nom) values('Argentine');Insert into t_r_pays_pay(pay_nom) values('Arménie');Insert into t_r_pays_pay(pay_nom) values('Australie');Insert into t_r_pays_pay(pay_nom) values('Autriche');Insert into t_r_pays_pay(pay_nom) values('Azerbaïdjan');Insert into t_r_pays_pay(pay_nom) values('Bahamas');Insert into t_r_pays_pay(pay_nom) values('Bahreïn');Insert into t_r_pays_pay(pay_nom) values('Bangladesh');Insert into t_r_pays_pay(pay_nom) values('Barbade');Insert into t_r_pays_pay(pay_nom) values('Belau');Insert into t_r_pays_pay(pay_nom) values('Belgique');Insert into t_r_pays_pay(pay_nom) values('Belize');Insert into t_r_pays_pay(pay_nom) values('Bénin');Insert into t_r_pays_pay(pay_nom) values('Bhoutan');Insert into t_r_pays_pay(pay_nom) values('Biélorussie');Insert into t_r_pays_pay(pay_nom) values('Birmanie');Insert into t_r_pays_pay(pay_nom) values('Bolivie');Insert into t_r_pays_pay(pay_nom) values('Bosnie-Herzégovine');Insert into t_r_pays_pay(pay_nom) values('Botswana');Insert into t_r_pays_pay(pay_nom) values('Brésil');Insert into t_r_pays_pay(pay_nom) values('Brunei');Insert into t_r_pays_pay(pay_nom) values('Bulgarie');Insert into t_r_pays_pay(pay_nom) values('Burkina');Insert into t_r_pays_pay(pay_nom) values('Burundi');Insert into t_r_pays_pay(pay_nom) values('Cambodge');Insert into t_r_pays_pay(pay_nom) values('Cameroun');Insert into t_r_pays_pay(pay_nom) values('Canada');Insert into t_r_pays_pay(pay_nom) values('Cap-Vert');Insert into t_r_pays_pay(pay_nom) values('Chili');Insert into t_r_pays_pay(pay_nom) values('Chine');Insert into t_r_pays_pay(pay_nom) values('Chypre');Insert into t_r_pays_pay(pay_nom) values('Colombie');Insert into t_r_pays_pay(pay_nom) values('Comores');Insert into t_r_pays_pay(pay_nom) values('Congo');Insert into t_r_pays_pay(pay_nom) values('Cook');Insert into t_r_pays_pay(pay_nom) values('Corée du Nord');Insert into t_r_pays_pay(pay_nom) values('Corée du Sud');Insert into t_r_pays_pay(pay_nom) values('Costa Rica');Insert into t_r_pays_pay(pay_nom) values('Côte d''Ivoire');Insert into t_r_pays_pay(pay_nom) values('Croatie');Insert into t_r_pays_pay(pay_nom) values('Cuba');Insert into t_r_pays_pay(pay_nom) values('Danemark');Insert into t_r_pays_pay(pay_nom) values('Djibouti');Insert into t_r_pays_pay(pay_nom) values('Dominique');Insert into t_r_pays_pay(pay_nom) values('Écosse');Insert into t_r_pays_pay(pay_nom) values('Égypte');Insert into t_r_pays_pay(pay_nom) values('Émirats arabes unis');Insert into t_r_pays_pay(pay_nom) values('Équateur');Insert into t_r_pays_pay(pay_nom) values('Érythrée');Insert into t_r_pays_pay(pay_nom) values('Espagne');Insert into t_r_pays_pay(pay_nom) values('Estonie');Insert into t_r_pays_pay(pay_nom) values('États-Unis');Insert into t_r_pays_pay(pay_nom) values('Éthiopie');Insert into t_r_pays_pay(pay_nom) values('Fidji');Insert into t_r_pays_pay(pay_nom) values('Finlande');Insert into t_r_pays_pay(pay_nom) values('France');Insert into t_r_pays_pay(pay_nom) values('Gabon');Insert into t_r_pays_pay(pay_nom) values('Gambie');Insert into t_r_pays_pay(pay_nom) values('Géorgie');Insert into t_r_pays_pay(pay_nom) values('Ghana');Insert into t_r_pays_pay(pay_nom) values('Grèce');Insert into t_r_pays_pay(pay_nom) values('Grenade');Insert into t_r_pays_pay(pay_nom) values('Guatemala');Insert into t_r_pays_pay(pay_nom) values('Guinée');Insert into t_r_pays_pay(pay_nom) values('Guinée-Bissao');Insert into t_r_pays_pay(pay_nom) values('Guinée équatoriale');Insert into t_r_pays_pay(pay_nom) values('Guyana');Insert into t_r_pays_pay(pay_nom) values('Haïti');Insert into t_r_pays_pay(pay_nom) values('Honduras');Insert into t_r_pays_pay(pay_nom) values('Hongrie');Insert into t_r_pays_pay(pay_nom) values('Inde');Insert into t_r_pays_pay(pay_nom) values('Indonésie');Insert into t_r_pays_pay(pay_nom) values('Iran');Insert into t_r_pays_pay(pay_nom) values('Irak');Insert into t_r_pays_pay(pay_nom) values('Irlande');Insert into t_r_pays_pay(pay_nom) values('Islande');Insert into t_r_pays_pay(pay_nom) values('Israël');Insert into t_r_pays_pay(pay_nom) values('Italie');Insert into t_r_pays_pay(pay_nom) values('Jamaïque');Insert into t_r_pays_pay(pay_nom) values('Japon');Insert into t_r_pays_pay(pay_nom) values('Jordanie');Insert into t_r_pays_pay(pay_nom) values('Kazakhstan');Insert into t_r_pays_pay(pay_nom) values('Kenya');Insert into t_r_pays_pay(pay_nom) values('Kirghizistan');Insert into t_r_pays_pay(pay_nom) values('Kiribati');Insert into t_r_pays_pay(pay_nom) values('Koweït');Insert into t_r_pays_pay(pay_nom) values('Laos');Insert into t_r_pays_pay(pay_nom) values('Lesotho');Insert into t_r_pays_pay(pay_nom) values('Lettonie');Insert into t_r_pays_pay(pay_nom) values('Liban');Insert into t_r_pays_pay(pay_nom) values('Liberia');Insert into t_r_pays_pay(pay_nom) values('Libye');Insert into t_r_pays_pay(pay_nom) values('Liechtenstein');Insert into t_r_pays_pay(pay_nom) values('Lituanie');Insert into t_r_pays_pay(pay_nom) values('Luxembourg');Insert into t_r_pays_pay(pay_nom) values('Macédoine');Insert into t_r_pays_pay(pay_nom) values('Madagascar');Insert into t_r_pays_pay(pay_nom) values('Malaisie');Insert into t_r_pays_pay(pay_nom) values('Malawi');Insert into t_r_pays_pay(pay_nom) values('Maldives');Insert into t_r_pays_pay(pay_nom) values('Mali');Insert into t_r_pays_pay(pay_nom) values('Malte');Insert into t_r_pays_pay(pay_nom) values('Maroc');Insert into t_r_pays_pay(pay_nom) values('Marshall');Insert into t_r_pays_pay(pay_nom) values('Maurice');Insert into t_r_pays_pay(pay_nom) values('Mauritanie');Insert into t_r_pays_pay(pay_nom) values('Mexique');Insert into t_r_pays_pay(pay_nom) values('Micronésie');Insert into t_r_pays_pay(pay_nom) values('Moldavie');Insert into t_r_pays_pay(pay_nom) values('Monaco');Insert into t_r_pays_pay(pay_nom) values('Mongolie');Insert into t_r_pays_pay(pay_nom) values('Mozambique');Insert into t_r_pays_pay(pay_nom) values('Namibie');Insert into t_r_pays_pay(pay_nom) values('Nauru');Insert into t_r_pays_pay(pay_nom) values('Népal');Insert into t_r_pays_pay(pay_nom) values('Nicaragua');Insert into t_r_pays_pay(pay_nom) values('Niger');Insert into t_r_pays_pay(pay_nom) values('Nigeria');Insert into t_r_pays_pay(pay_nom) values('Niue');Insert into t_r_pays_pay(pay_nom) values('Norvège');Insert into t_r_pays_pay(pay_nom) values('Nouvelle-Zélande');Insert into t_r_pays_pay(pay_nom) values('Oman');Insert into t_r_pays_pay(pay_nom) values('Ouganda');Insert into t_r_pays_pay(pay_nom) values('Ouzbékistan');Insert into t_r_pays_pay(pay_nom) values('Pakistan');Insert into t_r_pays_pay(pay_nom) values('Palestine');Insert into t_r_pays_pay(pay_nom) values('Panama');Insert into t_r_pays_pay(pay_nom) values('Papouasie - Nouvelle Guinée');Insert into t_r_pays_pay(pay_nom) values('Paraguay');Insert into t_r_pays_pay(pay_nom) values('Pays-Bas');Insert into t_r_pays_pay(pay_nom) values('Pérou');Insert into t_r_pays_pay(pay_nom) values('Philippines');Insert into t_r_pays_pay(pay_nom) values('Pologne');Insert into t_r_pays_pay(pay_nom) values('Portugal');Insert into t_r_pays_pay(pay_nom) values('Qatar');Insert into t_r_pays_pay(pay_nom) values('République centrafricaine');Insert into t_r_pays_pay(pay_nom) values('République démocratique du Congo');Insert into t_r_pays_pay(pay_nom) values('République dominicaine');Insert into t_r_pays_pay(pay_nom) values('République tchèque');Insert into t_r_pays_pay(pay_nom) values('Roumanie');Insert into t_r_pays_pay(pay_nom) values('Royaume-Uni');Insert into t_r_pays_pay(pay_nom) values('Russie');Insert into t_r_pays_pay(pay_nom) values('Rwanda');Insert into t_r_pays_pay(pay_nom) values('Saint-Christophe-et-Niévès');Insert into t_r_pays_pay(pay_nom) values('Sainte-Lucie');Insert into t_r_pays_pay(pay_nom) values('Saint-Marin');Insert into t_r_pays_pay(pay_nom) values('Saint-Siège');Insert into t_r_pays_pay(pay_nom) values('Saint-Vincent-et-les-Grenadine');Insert into t_r_pays_pay(pay_nom) values('Salomon');Insert into t_r_pays_pay(pay_nom) values('Salvador');Insert into t_r_pays_pay(pay_nom) values('Samoa occidentales');Insert into t_r_pays_pay(pay_nom) values('Sao Tomé-et-Principe');Insert into t_r_pays_pay(pay_nom) values('Sénégal');Insert into t_r_pays_pay(pay_nom) values('Seychelles');Insert into t_r_pays_pay(pay_nom) values('Sierra Leone');Insert into t_r_pays_pay(pay_nom) values('Singapour');Insert into t_r_pays_pay(pay_nom) values('Slovaquie');Insert into t_r_pays_pay(pay_nom) values('Slovénie');Insert into t_r_pays_pay(pay_nom) values('Somalie');Insert into t_r_pays_pay(pay_nom) values('Soudan');Insert into t_r_pays_pay(pay_nom) values('Sri Lanka');Insert into t_r_pays_pay(pay_nom) values('Suède');Insert into t_r_pays_pay(pay_nom) values('Suisse');Insert into t_r_pays_pay(pay_nom) values('Suriname');Insert into t_r_pays_pay(pay_nom) values('Swaziland');Insert into t_r_pays_pay(pay_nom) values('Syrie');Insert into t_r_pays_pay(pay_nom) values('Tadjikistan');Insert into t_r_pays_pay(pay_nom) values('Tanzanie');Insert into t_r_pays_pay(pay_nom) values('Tchad');Insert into t_r_pays_pay(pay_nom) values('Thaïlande');Insert into t_r_pays_pay(pay_nom) values('Togo');Insert into t_r_pays_pay(pay_nom) values('Tonga');Insert into t_r_pays_pay(pay_nom) values('Trinité-et-Tobago');Insert into t_r_pays_pay(pay_nom) values('Tunisie');Insert into t_r_pays_pay(pay_nom) values('Turkménistan');Insert into t_r_pays_pay(pay_nom) values('Turquie');Insert into t_r_pays_pay(pay_nom) values('Tuvalu');Insert into t_r_pays_pay(pay_nom) values('Ukraine');Insert into t_r_pays_pay(pay_nom) values('Uruguay');Insert into t_r_pays_pay(pay_nom) values('Vanuatu');Insert into t_r_pays_pay(pay_nom) values('Venezuela');Insert into t_r_pays_pay(pay_nom) values('Viêt Nam');Insert into t_r_pays_pay(pay_nom) values('Yémen');Insert into t_r_pays_pay(pay_nom) values('Yougoslavie');Insert into t_r_pays_pay(pay_nom) values('Zambie');Insert into t_r_pays_pay(pay_nom) values('Zimbabwe');Insert into t_r_typevisitelocation_vil(vil_libelle) values('Seul(e)');Insert into t_r_typevisitelocation_vil(vil_libelle) values('Avec mon époux(se) / partenaire');Insert into t_r_typevisitelocation_vil(vil_libelle) values('Avec mes amis');Insert into t_r_typevisitelocation_vil(vil_libelle) values('En famille avec jeune(s) enfant(s)');Insert into t_r_typevisitelocation_vil(vil_libelle) values('En famille avec adolescent(s)');Insert into t_r_typevisitelocation_vil(vil_libelle) values('En famille élargie');Insert into t_r_typevisitelocation_vil(vil_libelle) values('En grand groupe / Visite guidée');Insert into t_r_typevisitelocation_vil(vil_libelle) values('Autre');
Insert into t_r_periodevisite_per(per_mois, per_annee) values(1, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(2, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(3, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(4, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(5, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(6, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(7, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(8, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(9, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(10, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(11, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(12, 2010);Insert into t_r_periodevisite_per(per_mois, per_annee) values(1, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(2, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(3, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(4, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(5, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(6, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(7, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(8, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(9, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(10, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(11, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(12, 2013);Insert into t_r_periodevisite_per(per_mois, per_annee) values(1, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(2, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(3, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(4, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(5, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(6, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(7, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(8, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(9, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(10, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(11, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(12, 2014);Insert into t_r_periodevisite_per(per_mois, per_annee) values(1, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(2, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(3, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(4, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(5, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(6, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(7, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(8, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(9, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(10, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(11, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(12, 2015);Insert into t_r_periodevisite_per(per_mois, per_annee) values(1, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(2, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(3, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(4, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(5, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(6, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(7, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(8, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(9, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(10, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(11, 2016);Insert into t_r_periodevisite_per(per_mois, per_annee) values(12, 2016);Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Jean-Michel', 'info', 'jean-michel.aulas@gmail.com', 'AULAS', 'Jean-Michel', '10 Avenue Général Frère', '69008', 'Lyon', 64, 45.729394, 4.879395, 33, '401020304', 'Lyon');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Yohann', 'info', 'yohann.gourcuf@gmail.com', 'GOURCUF', 'Yohann', 'Rue Maryse Bastié', '69500', 'Bron', 64, 45.726888, 4.922322, 33, '401020305', 'Lyon');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Tony', 'info', 'tony.parker@gmail.com', 'PARKER', 'Tony', '3 rue du 8 mai 1945', '69100', 'Villeurbanne', 64, 45.781412, 4.891292, 33, '401020305', 'Lyon');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Juninho', 'info', 'juninho.pernambucano@gmail.com', 'PERNAMBUCANO', 'Juninho', '10 rue des 3 Rois', '69007', 'Lyon', 64, 45.75398, 4.842775, 33, '401020305', 'Lyon');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Homer', 'info', 'homer.simpson@gmail.com', 'SIMPSON', 'Homer', '11 rue Sommeiller', '74000', 'Annecy', 64, 45.902126, 6.123754, 33, '450010203', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Marge', 'info', 'marge.simpson@gmail.com', 'SIMPSON', 'Marge', '11 rue Sommeiller', '74000', 'Annecy', 64, 45.902126, 6.123754, 33, '450010204', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Matt', 'info', 'matt.groening@gmail.com', 'GROENING', 'Matt', '9 rue de l''Arc en Ciel', '74940', 'Annecy Le Vieux', 64, 45.921153, 6.153794, 33, '450010205', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Bart', 'info', 'moe.szyslak@gmail.com', 'SZYSLAK', 'Moe', '5 Chemin de Bellevue', '74940', 'Annecy Le Vieux', 64, 45.920254, 6.16188, 33, '450010206', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Bob', 'info', 'bart.simpson@gmail.com', 'SIMPSON', 'Bart', 'Chef-Lieu', '74150', 'Vaulx', 64, 45.885129, 5.94805, 33, '450010207', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Joe', 'info', 'bob.leponge@gmail.com', 'LEPONGE', 'Bob', '50 route de Poisy', '74330', 'Lovagny', 64, 45.903805, 6.031961, 33, '450010208', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Jeff', 'info', 'joe.quimby@gmail.com', 'QUIMBY', 'Joe', 'Place Gabriel Fauré', '74940', 'Annecy le Vieux', 64, 45.91972, 6.142131, 33, '450010209', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Barney', 'info', 'jeff.albertson@gmail.com', 'ALBERTSON', 'Jeff', 'Place de la Navigation 2', '1201', 'Genève', 171, 46.211399, 6.14983, 41, '227354438', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Mel', 'info', 'barney.gumble@gmail.com', 'GUMBLE', 'Barney', '21, quai des Bergues', '1201', 'Genève', 171, 46.20615, 6.14461, 41, '227354439', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Mel', 'info', 'mel.sideshow@gmail.com', 'SIDESHOW', 'Mel', 'Route de la Galaise 8', '1228', 'Plan-les-Ouates', 171, 46.164563, 6.105927, 41, '227354440', 'Genève');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Winnie', 'info', 'winnie.lourson@gmail.com', 'LOURSON', 'Winnie', 'Kornhausstrasse 3', '3000', 'Bern', 171, 46.95303, 7.44966, 41, '227354441', 'Zurich');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Candy', 'info', 'candy.crush@gmail.com', 'CRUSH', 'Candy', 'Zeughausgasse 41', '3000', 'Bern', 171, 46.949089, 7.44456, 41, '227354442', 'Zurich');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Capitaine', 'info', 'capitaine.flam@gmail.com', 'FLAM', 'Capitaine', 'Claridenstrasse 30', '8022', 'Zurich', 171, 47.367611, 8.53718, 41, '227354443', 'Zurich');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Ken', 'info', 'ken.lesurvivant@gmail.com', 'LESURVIVANT', 'Ken', 'Weinbergstrasse 92', '8006', 'Zurich', 171, 47.384696, 8.542859, 41, '227354444', 'Zurich');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Mario', 'info', 'mario.bros@gmail.com', 'BROS', 'Mario', 'Via Di Ripetta 231', '00186', 'Roma', 86, 41.908498, 12.476017, 39, '677261658', 'Roma');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Luigi', 'info', 'luigi.bros@gmail.com', 'BROS', 'Luigi', 'Via del Pellegrino 122', '00186', 'Roma', 86, 41.89702, 12.470217, 39, '677261659', 'Roma');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Peach', 'info', 'peach.princesse@gmail.com', 'PRINCESSE', 'Peach', 'Via V. Veneto 155', '00187', 'Roma', 86, 41.908244, 12.489189, 39, '677261660', 'Roma');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Diddy', 'info', 'diddy.kong@gmail.com', 'KONG', 'Diddy', 'Via Mario De Fiori 93', '00187', 'Roma', 86, 41.904565, 12.481899, 39, '677261661', 'Roma');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('William', 'info', 'william.decambridge@gmail.com', 'DE CAMBRIDGE', 'William', '22 Portman Square', 'W1H 7BG ', 'London', 149, 51.516231, -0.157945, 44, '2073887666', 'London');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Kate', 'info', 'kate.middleton@gmail.com', 'MIDDLETON', 'Kate', 'A41 Watford Bypass', 'WD25 8JH', 'Watford', 149, 51.657604, -0.349246, 44, '2073887667', 'London');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Pippa', 'info', 'pippa.middleton@gmail.com', 'MIDDLETON', 'Pippa', '19 Bridle Path', 'WD17 1UE', 'Watford', 149, 51.664622, -0.398241, 44, '2073887668', 'London');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('George', 'info', 'george.decambridge@gmail.com', 'DE CAMBRIDGE', 'George', 'Primrose Hill Rd', 'NW3 3NA', 'London', 149, 51.544239, -0.162251, 44, '2073887669', 'London');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Frank', 'info', 'frank.ribbery@gmail.com', 'RIBBERY', 'Frank', 'Gabriele-Tergit-Promenade 19', '10963', 'Berlin', 5, 52.504639, 13.374837, 49, '304172400', 'Berlin');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Benoit', 'info', 'benoit.treize@gmail.com', 'TREIZE', 'Benoit', 'Landsberger Allee 106', '10369', 'Berlin', 5, 52.528562, 13.457339, 49, '304172401', 'Berlin');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Angela', 'info', 'angela.merkel@gmail.com', 'MERKEL', 'Angela', 'Wittenbergplatz 5', '10789', 'Berlin', 5, 52.502727, 13.343332, 49, '304172402', 'Berlin');Insert into t_e_abonne_abo(abo_pseudo, abo_motpasse, abo_mel, abo_nom, abo_prenom, abo_adrligne1, abo_cp, abo_ville, pay_id, abo_latitude, abo_longitude, abo_indicatif, abo_tel, abo_aeroport) values('Rainer', 'info', 'rainer.wolfcastle@gmail.com', 'WOLFCASTLE', 'Rainer', 'Charlottenstrasse 49', '10117', 'Berlin', 5, 52.515126, 13.390790, 49, '304172403', 'Berlin');
Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(1, 0, 'Chuuut! Gîte urbain', 'Appartement', 1, 2, 'Appartement charmant et très confortable pour 1 ou 2 personnes, au coeur de la ville dans la principale rue commerçante piétonne, sous les combles d''un bâtiment historique. La vieille ville, le lac, des restaurants, des boutiques, un parking sont facilement accessibles à pied. Une grande TV avec vidéo à la demande gratuite. Wifi gratuit. Linge de maison et produits de bain sont fournis. Café, thé et jus d''orange sont offerts.', '13 Rue Jean Mermoz', '74940', 'Annecy-le-Vieux', 64, 45.917074, 6.14548, 2, 1); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(1, 1, 'Chuuut! Urban house', 'Appartement', 1, 2, 'Pour une journée, un week-end ou plus, l''endroit idéal pour apprécier le charme de la ville ! Appartement pour 1 ou 2 personnes, au coeur de la ville dans la principale rue commerçante piétonne, sous les combles d''un bâtiment historique de la vieille ville, le lac, restaurants, boutiques, cinéma, autobus, stationnement sont tous à distance de marche. ', '20 rue capitaine Baud', '74940', 'Annecy-le-Vieux', 64, 45.915593, 6.149578, 4, 1); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(2, 1, 'L''Aurore', 'Appartement', 1, 4, 'A 800 m. du lac d''Annecy, de ses plages et de son casino l''Aurore est un appartement entièrement dédié aux voyageurs qui souhaitent découvrir notre région. Rénové en 2014, il mêle décoration contemporaine et ambiance cocooning auxquelles s''ajoute un équipement de qualité pour vous sentir chez vous. Il comprend 1 chambre avec un lit 140 de grand confort et 2 chauffeuses, une douche italienne, un WC indépendant et une cuisine entièrement équipée avec accès sur un balcon aménagé. Une TV écran plat et une connexion Internet sont également à votre disposition.', '52 Rue des Mouettes', '74940', 'Annecy-le-Vieux', 64, 45.912214, 6.154846, 8, 0); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(3, 2, 'Maisonnette indépendante originale', 'Logement', 1, 4, 'Maisonnette indépendante originale, entièrement meublée et équipée. Vue sur le lac, exposition sud-ouest (pièce à vivre très lumineuse). 60 m2 répartis sur 3 niveaux. Capacité : 4 personnes, plus 2 couchages d''appoint supplémentaires. La cuisine est toute équipée, ouverte sur une salle à manger. La salle de bain et les w-c sont séparés.', '11 rue centrale', '74940', 'Annecy-le-Vieux', 64, 45.907181, 6.150237, 8, 1); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(4, 4, 'Villa hauteurs d''Annecy le Vieux', 'Logement', 2, 6, 'Villa de plein pied, hébergement arboré avec 2 terrasses à l''abri des regards. 4 adultes + 1 BB ou 3 adultes + 1 BB + 1 enf < 10 ans Fleurs et arbustes bénéficient d''un arrosage écologique par goutte à goutte avec des récupérateur d''eau de pluie. Espace détente à l''intérieur avec TV et à l''extérieur avec chaises longues - table et chaises confortables. Une connexion WIFI dans les deux chambres claires et spacieuses vous permettent d''être près de vos amis ou de votre famille, sinon de votre employeur ! Les deux chambres bénéficient d''un WC privé. ', '11 rue de Lachat ', '74940', 'Annecy-le-Vieux', 64, 45.921256, 6.145531, 12, 0); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(5, 3, 'Typical & Charming flat ', 'Appartement', 2, 4, 'Wonderful flat in the heart of historical area of Annecy le Vieux, close of all shops, famous restaurants and bistros. Very authentic in classified building of 18th centuty, just renovated with traditional materials you will feel very confortable in this cosy apartment.', '27 Avenue Petit Port', '74940', 'Annecy-le-Vieux', 64, 45.905246, 6.15071, 8, 0); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(6, 0, 'Beau Studio Les Chanterelles à Plan Montmin', 'Appartement', 1, 2, 'Face au sud grande terrasse ensoleillée (35 m2) avec mobilier de jardin barbecue et chaises longues. Cuisine moderne entièrement équipée avec tout le confort moderne y compris four, plaque de cuisson induction, micro-ondes, cafetière, bouilloire, grille-pain, réfrigérateur/congélateur, machine à raclette, pierrade etc. À votre disposition, TV/lecteur DVD, connexion internet Wifi, lecteur CD/Radio stéréo, téléphone, machine à laver, sèche linge, sèche-cheveux, cuisine entièrement équipée. Fabuleuses vues sur les montagnes. Guide local haute montagne dans le village de canyoning, descente en rappel, monte medio, escalade et ski de randonnée et une école locale de parachute ascensionnel. À proximité de parcours de golf de Giez et Talloires, forêt de l''aventure et beaucoup d''autres activités sportives. Le Col de la Forclaz à 5km, célèbre pour le parachute ascensionnel et avoir une vue spectaculaire sur le lac d''Annecy. Il y a quatre restaurants dans le village de Montmin, la Pricaz et l''Edelweiss avec dominant une vue sur le lac et de la Ferme et de l''Alpage, proposant des plats typiquement savoyard local.', '9 Rue des Ecoles', '74940', 'Annecy-le-Vieux', 64, 45.9119, 6.144095, 4, 1); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(7, 1, 'Vieil Annecy', 'Appartement', 1, 2, 'Dans un immeuble de caractère avec vue panoramique sur lac d''Annecy et montagnes. Vous pourrez profiter des activités nautiques (pédalos, bateau, ski-nautiques, canoë, planche à voile…)à 5 minutes à pied. Mais également des sports aériens à moins de 45 min (saut en parapente, parachute, deltaplane.) L''appartement comprend une pièce de vie, une cuisine équipée (plaque vitrocéramique, micro-onde, frigo, bouilloire, grille-pain, machine à café Nespresso), 1 salle de douche ( sèche-cheveux). Pour votre confort l''appartement est équipé en couverts,vaisselle,casseroles et ustensiles de cuisine.', '59 Avenue Petit Port', '74940', 'Annecy-le-Vieux', 64, 45.905913, 6.154789, 4, 0); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(8, 2, 'Annecy Imperial', 'Appartement', 1, 3, 'Salon et salle à manger avec vue panoramique, 2 canapé, toutes équipées de cuisine, canapé Convertible, TV avec chaînes internationales, lecteur DVD, 1 salle de bain : bain baignoire, 1 lavabo, sèche serviettes de bain, sèche-cheveux et séparé WC, étude, Internet ADSL WIFI, lave-linge et sèche-linge et grille de séchage.', '12 Rue Centrale', '74940', 'Annecy-le-Vieux', 64, 45.90651, 6.146369, 6, 1); Insert into t_e_location_loc(grt_id, loc_nbchambres, loc_titre, loc_type, loc_nbsallesbain, loc_nbcouchages, loc_description, loc_adrligne1, loc_cp, loc_ville, pay_id, loc_latitude, loc_longitude, LOC_NbOccupants, LOC_CodeReservationTrip) values(9, 3, 'Aurore Villa', 'Logement', 2, 4, 'Le balcon des chambres vous donne une vue panoramique sur les montagnes. La terrasse et le jardin sont ensoleillés et équipés de mobilier de jardin. Beaucoup d''activités possible aux alentours: randonnées à pied ou à vélo, parapente, sports aquatiques, plage, accrobranche, golf, luge d''été. La compagnie des Bateaux vous propose de faire le tour du lac.', '13, rue Centrale', '74940', 'Annecy-le-Vieux', 64, 45.907181, 6.150237, 8, 1); Insert into t_j_equipementlocation_eql values(1, 1, 1);Insert into t_j_equipementlocation_eql values(1, 2, 1);Insert into t_j_equipementlocation_eql values(1, 3, 1);Insert into t_j_equipementlocation_eql values(1, 4, 1);Insert into t_j_equipementlocation_eql values(1, 5, 2);Insert into t_j_equipementlocation_eql values(1, 6, 1);Insert into t_j_equipementlocation_eql values(1, 7, 1);Insert into t_j_equipementlocation_eql values(1, 8, 3);Insert into t_j_equipementlocation_eql values(1, 9, 1);Insert into t_j_equipementlocation_eql values(1, 10, 1);Insert into t_j_equipementlocation_eql values(1, 11, 1);Insert into t_j_equipementlocation_eql values(1, 12, 1);Insert into t_j_equipementlocation_eql values(1, 13, 1);Insert into t_j_equipementlocation_eql values(1, 14, 1);Insert into t_j_equipementlocation_eql values(1, 15, 1);Insert into t_j_equipementlocation_eql values(1, 16, 2);Insert into t_j_equipementlocation_eql values(1, 17, 4);Insert into t_j_equipementlocation_eql values(1, 18, 1);Insert into t_j_equipementlocation_eql values(1, 19, 1);Insert into t_j_equipementlocation_eql values(1, 20, 1);Insert into t_j_equipementlocation_eql values(1, 21, 1);Insert into t_j_equipementlocation_eql values(1, 22, 1);Insert into t_j_equipementlocation_eql values(1, 23, 1);Insert into t_j_equipementlocation_eql values(1, 24, 1);Insert into t_j_equipementlocation_eql values(1, 25, 1);Insert into t_j_equipementlocation_eql values(1, 27, 2);Insert into t_j_equipementlocation_eql values(1, 28, 1);Insert into t_j_equipementlocation_eql values(1, 29, 1);Insert into t_j_equipementlocation_eql values(1, 30, 1);Insert into t_j_equipementlocation_eql values(1, 31, 1);Insert into t_j_equipementlocation_eql values(1, 32, 1);Insert into t_j_equipementlocation_eql values(1, 33, 1);Insert into t_j_equipementlocation_eql values(2, 1, 2);Insert into t_j_equipementlocation_eql values(2, 2, 2);Insert into t_j_equipementlocation_eql values(2, 3, 1);Insert into t_j_equipementlocation_eql values(2, 4, 1);Insert into t_j_equipementlocation_eql values(2, 5, 1);Insert into t_j_equipementlocation_eql values(2, 6, 1);Insert into t_j_equipementlocation_eql values(2, 7, 1);Insert into t_j_equipementlocation_eql values(2, 8, 1);Insert into t_j_equipementlocation_eql values(2, 9, 1);Insert into t_j_equipementlocation_eql values(2, 10, 1);Insert into t_j_equipementlocation_eql values(2, 11, 1);Insert into t_j_equipementlocation_eql values(2, 12, 1);Insert into t_j_equipementlocation_eql values(2, 13, 1);Insert into t_j_equipementlocation_eql values(2, 14, 1);Insert into t_j_equipementlocation_eql values(2, 15, 1);Insert into t_j_equipementlocation_eql values(2, 16, 1);Insert into t_j_equipementlocation_eql values(2, 17, 1);Insert into t_j_equipementlocation_eql values(4, 1, 1);Insert into t_j_equipementlocation_eql values(4, 2, 1);Insert into t_j_equipementlocation_eql values(4, 3, 1);Insert into t_j_equipementlocation_eql values(4, 4, 1);Insert into t_j_equipementlocation_eql values(4, 5, 1);Insert into t_j_equipementlocation_eql values(4, 6, 1);Insert into t_j_equipementlocation_eql values(4, 7, 1);Insert into t_j_equipementlocation_eql values(4, 8, 1);Insert into t_j_equipementlocation_eql values(4, 9, 1);Insert into t_j_equipementlocation_eql values(4, 10, 1);Insert into t_j_equipementlocation_eql values(4, 11, 1);Insert into t_j_equipementlocation_eql values(4, 12, 1);Insert into t_j_equipementlocation_eql values(4, 13, 1);Insert into t_j_equipementlocation_eql values(4, 14, 1);Insert into t_j_equipementlocation_eql values(4, 15, 1);Insert into t_j_equipementlocation_eql values(4, 16, 1);Insert into t_j_equipementlocation_eql values(4, 17, 1);Insert into t_j_equipementlocation_eql values(4, 18, 2);Insert into t_j_equipementlocation_eql values(4, 19, 1);Insert into t_j_equipementlocation_eql values(4, 20, 1);Insert into t_j_equipementlocation_eql values(4, 21, 1);Insert into t_j_equipementlocation_eql values(4, 22, 1);Insert into t_j_equipementlocation_eql values(4, 23, 1);Insert into t_j_equipementlocation_eql values(4, 24, 1);Insert into t_j_equipementlocation_eql values(4, 25, 2);insert into t_r_typesejour_sej(sej_libelle) values ('Soir de la semaine');insert into t_r_typesejour_sej(sej_libelle) values ('Nuitée le week-end');insert into t_r_typesejour_sej(sej_libelle) values ('Par semaine');insert into t_r_periodetarif_pet(pet_intitule, pet_datedeb, pet_datefin) values('Par défaut', null, null);
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
insert into t_j_tariflocation_tar values (2, 1, 3, 800);Insert into t_j_planninglocation_plo values(1, current_date, false); Insert into t_j_planninglocation_plo values(1, current_date+1, false); Insert into t_j_planninglocation_plo values(1, current_date+2, false); Insert into t_j_planninglocation_plo values(1, current_date+3, false); Insert into t_j_planninglocation_plo values(1, current_date+4, false); Insert into t_j_planninglocation_plo values(1, current_date+5, false); Insert into t_j_planninglocation_plo values(1, current_date+6, false); Insert into t_j_planninglocation_plo values(1, current_date+7, false); Insert into t_j_planninglocation_plo values(1, current_date+8, false); Insert into t_j_planninglocation_plo values(1, current_date+9, false); Insert into t_j_planninglocation_plo values(1, current_date+10, false); Insert into t_j_planninglocation_plo values(1, current_date+11, false); Insert into t_j_planninglocation_plo values(1, current_date+12, false); Insert into t_j_planninglocation_plo values(1, current_date+13, false); Insert into t_j_planninglocation_plo values(1, current_date+14, true); Insert into t_j_planninglocation_plo values(1, current_date+15, true); Insert into t_j_planninglocation_plo values(1, current_date+16, true); Insert into t_j_planninglocation_plo values(1, current_date+17, true); Insert into t_j_planninglocation_plo values(1, current_date+18, true); Insert into t_j_planninglocation_plo values(1, current_date+19, true); Insert into t_j_planninglocation_plo values(1, current_date+20, true); Insert into t_j_planninglocation_plo values(1, current_date+21, true); Insert into t_j_planninglocation_plo values(1, current_date+22, true); Insert into t_j_planninglocation_plo values(1, current_date+23, true); Insert into t_j_planninglocation_plo values(1, current_date+24, true); Insert into t_j_planninglocation_plo values(1, current_date+25, true); Insert into t_j_planninglocation_plo values(1, current_date+26, true); Insert into t_j_planninglocation_plo values(1, current_date+27, true); Insert into t_j_planninglocation_plo values(1, current_date+28, true); Insert into t_j_planninglocation_plo values(1, current_date+29, true); Insert into t_j_planninglocation_plo values(1, current_date+30, true); Insert into t_j_planninglocation_plo values(1, current_date+31, true); Insert into t_j_planninglocation_plo values(1, current_date+32, true); Insert into t_j_planninglocation_plo values(1, current_date+33, true); Insert into t_j_planninglocation_plo values(1, current_date+34, true); Insert into t_j_planninglocation_plo values(1, current_date+35, true); Insert into t_j_planninglocation_plo values(1, current_date+36, true); Insert into t_j_planninglocation_plo values(1, current_date+37, true); Insert into t_j_planninglocation_plo values(1, current_date+38, true); Insert into t_j_planninglocation_plo values(1, current_date+39, true); Insert into t_j_planninglocation_plo values(1, current_date+40, true); Insert into t_j_planninglocation_plo values(1, current_date+41, true); Insert into t_j_planninglocation_plo values(1, current_date+42, true); Insert into t_j_planninglocation_plo values(1, current_date+43, true); Insert into t_j_planninglocation_plo values(1, current_date+44, true); Insert into t_j_planninglocation_plo values(1, current_date+45, true); Insert into t_j_planninglocation_plo values(1, current_date+46, true); Insert into t_j_planninglocation_plo values(1, current_date+47, true); Insert into t_j_planninglocation_plo values(1, current_date+48, true); Insert into t_j_planninglocation_plo values(1, current_date+49, true); Insert into t_j_planninglocation_plo values(1, current_date+50, false); Insert into t_j_planninglocation_plo values(1, current_date+51, false); Insert into t_j_planninglocation_plo values(1, current_date+52, true); Insert into t_j_planninglocation_plo values(1, current_date+53, true); Insert into t_j_planninglocation_plo values(1, current_date+54, true); Insert into t_j_planninglocation_plo values(1, current_date+55, true); Insert into t_j_planninglocation_plo values(1, current_date+56, true); Insert into t_j_planninglocation_plo values(1, current_date+57, true); Insert into t_j_planninglocation_plo values(1, current_date+58, true); Insert into t_j_planninglocation_plo values(1, current_date+59, true); Insert into t_j_planninglocation_plo values(1, current_date+60, true); Insert into t_j_planninglocation_plo values(1, current_date+61, true); Insert into t_j_planninglocation_plo values(1, current_date+62, true); Insert into t_j_planninglocation_plo values(1, current_date+63, true); Insert into t_j_planninglocation_plo values(1, current_date+64, true); Insert into t_j_planninglocation_plo values(1, current_date+65, true); Insert into t_j_planninglocation_plo values(1, current_date+66, true); Insert into t_j_planninglocation_plo values(1, current_date+67, true); Insert into t_j_planninglocation_plo values(1, current_date+68, true); Insert into t_j_planninglocation_plo values(1, current_date+69, true); Insert into t_j_planninglocation_plo values(1, current_date+70, false); Insert into t_j_planninglocation_plo values(1, current_date+71, false); Insert into t_j_planninglocation_plo values(1, current_date+72, true); Insert into t_j_planninglocation_plo values(1, current_date+73, true); Insert into t_j_planninglocation_plo values(1, current_date+74, true); Insert into t_j_planninglocation_plo values(1, current_date+75, true); Insert into t_j_planninglocation_plo values(1, current_date+76, true); Insert into t_j_planninglocation_plo values(1, current_date+77, true); Insert into t_j_planninglocation_plo values(1, current_date+78, true); Insert into t_j_planninglocation_plo values(1, current_date+79, true); Insert into t_j_planninglocation_plo values(1, current_date+80, true); Insert into t_j_planninglocation_plo values(1, current_date+81, true); Insert into t_j_planninglocation_plo values(1, current_date+82, true); Insert into t_j_planninglocation_plo values(1, current_date+83, true); Insert into t_j_planninglocation_plo values(1, current_date+84, true); Insert into t_j_planninglocation_plo values(1, current_date+85, true); Insert into t_j_planninglocation_plo values(1, current_date+86, true); Insert into t_j_planninglocation_plo values(1, current_date+87, true); Insert into t_j_planninglocation_plo values(1, current_date+88, true); Insert into t_j_planninglocation_plo values(1, current_date+89, false); Insert into t_j_planninglocation_plo values(1, current_date+90, false); Insert into t_j_planninglocation_plo values(1, current_date+91, true); Insert into t_j_planninglocation_plo values(1, current_date+92, true); Insert into t_j_planninglocation_plo values(1, current_date+93, true); Insert into t_j_planninglocation_plo values(1, current_date+94, true); Insert into t_j_planninglocation_plo values(1, current_date+95, true); Insert into t_j_planninglocation_plo values(1, current_date+96, true); Insert into t_j_planninglocation_plo values(1, current_date+97, true); Insert into t_j_planninglocation_plo values(1, current_date+98, true); Insert into t_j_planninglocation_plo values(1, current_date+99, true); Insert into t_j_planninglocation_plo values(1, current_date+100, true); Insert into t_j_planninglocation_plo values(1, current_date+101, true); Insert into t_j_planninglocation_plo values(1, current_date+102, true); Insert into t_j_planninglocation_plo values(1, current_date+103, true); Insert into t_j_planninglocation_plo values(1, current_date+104, true); Insert into t_j_planninglocation_plo values(1, current_date+105, true); Insert into t_j_planninglocation_plo values(1, current_date+106, true); Insert into t_j_planninglocation_plo values(1, current_date+107, true); Insert into t_j_planninglocation_plo values(1, current_date+108, true); Insert into t_j_planninglocation_plo values(1, current_date+109, true); Insert into t_j_planninglocation_plo values(1, current_date+110, true); Insert into t_j_planninglocation_plo values(1, current_date+111, true); Insert into t_j_planninglocation_plo values(1, current_date+112, true); Insert into t_j_planninglocation_plo values(1, current_date+113, true); Insert into t_j_planninglocation_plo values(1, current_date+114, true); Insert into t_j_planninglocation_plo values(1, current_date+115, true); Insert into t_j_planninglocation_plo values(1, current_date+116, true); Insert into t_j_planninglocation_plo values(1, current_date+117, true); Insert into t_j_planninglocation_plo values(1, current_date+118, true); Insert into t_j_planninglocation_plo values(1, current_date+119, true); Insert into t_j_planninglocation_plo values(1, current_date+120, true); Insert into t_j_planninglocation_plo values(2, current_date, true); Insert into t_j_planninglocation_plo values(2, current_date+1, true); Insert into t_j_planninglocation_plo values(2, current_date+2, true); Insert into t_j_planninglocation_plo values(2, current_date+3, true); Insert into t_j_planninglocation_plo values(2, current_date+4, true); Insert into t_j_planninglocation_plo values(2, current_date+5, true); Insert into t_j_planninglocation_plo values(2, current_date+6, true); Insert into t_j_planninglocation_plo values(2, current_date+7, true); Insert into t_j_planninglocation_plo values(2, current_date+8, true); Insert into t_j_planninglocation_plo values(2, current_date+9, true); Insert into t_j_planninglocation_plo values(2, current_date+10, true); Insert into t_j_planninglocation_plo values(2, current_date+11, true); Insert into t_j_planninglocation_plo values(2, current_date+12, true); Insert into t_j_planninglocation_plo values(2, current_date+13, true); Insert into t_j_planninglocation_plo values(2, current_date+14, true); Insert into t_j_planninglocation_plo values(2, current_date+15, true); Insert into t_j_planninglocation_plo values(2, current_date+16, true); Insert into t_j_planninglocation_plo values(2, current_date+17, true); Insert into t_j_planninglocation_plo values(2, current_date+18, true); Insert into t_j_planninglocation_plo values(2, current_date+19, true); Insert into t_j_planninglocation_plo values(2, current_date+20, true); Insert into t_j_planninglocation_plo values(2, current_date+21, true); Insert into t_j_planninglocation_plo values(2, current_date+22, true); Insert into t_j_planninglocation_plo values(2, current_date+23, true); Insert into t_j_planninglocation_plo values(2, current_date+24, true); Insert into t_j_planninglocation_plo values(2, current_date+25, true); Insert into t_j_planninglocation_plo values(2, current_date+26, true); Insert into t_j_planninglocation_plo values(2, current_date+27, true); Insert into t_j_planninglocation_plo values(2, current_date+28, true); Insert into t_j_planninglocation_plo values(2, current_date+29, true); Insert into t_j_planninglocation_plo values(2, current_date+30, true); Insert into t_j_planninglocation_plo values(2, current_date+31, true); Insert into t_j_planninglocation_plo values(2, current_date+32, true); Insert into t_j_planninglocation_plo values(2, current_date+33, true); Insert into t_j_planninglocation_plo values(2, current_date+34, true); Insert into t_j_planninglocation_plo values(2, current_date+35, true); Insert into t_j_planninglocation_plo values(2, current_date+36, true); Insert into t_j_planninglocation_plo values(2, current_date+37, true); Insert into t_j_planninglocation_plo values(2, current_date+38, true); Insert into t_j_planninglocation_plo values(2, current_date+39, true); Insert into t_j_planninglocation_plo values(2, current_date+40, true); Insert into t_j_planninglocation_plo values(2, current_date+41, true); Insert into t_j_planninglocation_plo values(2, current_date+42, true); Insert into t_j_planninglocation_plo values(2, current_date+43, true); Insert into t_j_planninglocation_plo values(2, current_date+44, true); Insert into t_j_planninglocation_plo values(2, current_date+45, true); Insert into t_j_planninglocation_plo values(2, current_date+46, true); Insert into t_j_planninglocation_plo values(2, current_date+47, true); Insert into t_j_planninglocation_plo values(2, current_date+48, true); Insert into t_j_planninglocation_plo values(2, current_date+49, true); Insert into t_j_planninglocation_plo values(2, current_date+50, true); Insert into t_j_planninglocation_plo values(2, current_date+51, true); Insert into t_j_planninglocation_plo values(2, current_date+52, true); Insert into t_j_planninglocation_plo values(2, current_date+53, true); Insert into t_j_planninglocation_plo values(2, current_date+54, true); Insert into t_j_planninglocation_plo values(2, current_date+55, true); Insert into t_j_planninglocation_plo values(2, current_date+56, true); Insert into t_j_planninglocation_plo values(2, current_date+57, true); Insert into t_j_planninglocation_plo values(2, current_date+58, true); Insert into t_j_planninglocation_plo values(2, current_date+59, true); Insert into t_j_planninglocation_plo values(2, current_date+60, true); Insert into t_j_planninglocation_plo values(2, current_date+61, true); Insert into t_j_planninglocation_plo values(2, current_date+62, true); Insert into t_j_planninglocation_plo values(2, current_date+63, true); Insert into t_j_planninglocation_plo values(2, current_date+64, true); Insert into t_j_planninglocation_plo values(2, current_date+65, true); Insert into t_j_planninglocation_plo values(2, current_date+66, true); Insert into t_j_planninglocation_plo values(2, current_date+67, true); Insert into t_j_planninglocation_plo values(2, current_date+68, true); Insert into t_j_planninglocation_plo values(2, current_date+69, true); Insert into t_j_planninglocation_plo values(2, current_date+70, true); Insert into t_j_planninglocation_plo values(2, current_date+71, true); Insert into t_j_planninglocation_plo values(2, current_date+72, true); Insert into t_j_planninglocation_plo values(2, current_date+73, true); Insert into t_j_planninglocation_plo values(2, current_date+74, true); Insert into t_j_planninglocation_plo values(2, current_date+75, true); Insert into t_j_planninglocation_plo values(2, current_date+76, true); Insert into t_j_planninglocation_plo values(2, current_date+77, true); Insert into t_j_planninglocation_plo values(2, current_date+78, true); Insert into t_j_planninglocation_plo values(2, current_date+79, true); Insert into t_j_planninglocation_plo values(2, current_date+80, true); Insert into t_j_planninglocation_plo values(2, current_date+81, true); Insert into t_j_planninglocation_plo values(2, current_date+82, true); Insert into t_j_planninglocation_plo values(2, current_date+83, true); Insert into t_j_planninglocation_plo values(2, current_date+84, true); Insert into t_j_planninglocation_plo values(2, current_date+85, true); Insert into t_j_planninglocation_plo values(2, current_date+86, true); Insert into t_j_planninglocation_plo values(2, current_date+87, true); Insert into t_j_planninglocation_plo values(2, current_date+88, true); Insert into t_j_planninglocation_plo values(2, current_date+89, true); Insert into t_j_planninglocation_plo values(2, current_date+90, true); Insert into t_j_planninglocation_plo values(2, current_date+91, true); Insert into t_j_planninglocation_plo values(2, current_date+92, true); Insert into t_j_planninglocation_plo values(2, current_date+93, true); Insert into t_j_planninglocation_plo values(2, current_date+94, true); Insert into t_j_planninglocation_plo values(2, current_date+95, true); Insert into t_j_planninglocation_plo values(2, current_date+96, true); Insert into t_j_planninglocation_plo values(2, current_date+97, true); Insert into t_j_planninglocation_plo values(2, current_date+98, true); Insert into t_j_planninglocation_plo values(2, current_date+99, true); Insert into t_j_planninglocation_plo values(2, current_date+100, true); Insert into t_j_planninglocation_plo values(2, current_date+101, true); Insert into t_j_planninglocation_plo values(2, current_date+102, true); Insert into t_j_planninglocation_plo values(2, current_date+103, true); Insert into t_j_planninglocation_plo values(2, current_date+104, true); Insert into t_j_planninglocation_plo values(2, current_date+105, true); Insert into t_j_planninglocation_plo values(2, current_date+106, true); Insert into t_j_planninglocation_plo values(2, current_date+107, true); Insert into t_j_planninglocation_plo values(2, current_date+108, true); Insert into t_j_planninglocation_plo values(2, current_date+109, true); Insert into t_j_planninglocation_plo values(2, current_date+110, true); Insert into t_j_planninglocation_plo values(2, current_date+111, true); Insert into t_j_planninglocation_plo values(2, current_date+112, true); Insert into t_j_planninglocation_plo values(2, current_date+113, true); Insert into t_j_planninglocation_plo values(2, current_date+114, true); Insert into t_j_planninglocation_plo values(2, current_date+115, true); Insert into t_j_planninglocation_plo values(2, current_date+116, true); Insert into t_j_planninglocation_plo values(2, current_date+117, true); Insert into t_j_planninglocation_plo values(2, current_date+118, true); Insert into t_j_planninglocation_plo values(2, current_date+119, true); Insert into t_j_planninglocation_plo values(2, current_date+120, true); Insert into t_j_planninglocation_plo values(2, current_date+121, true); Insert into t_j_planninglocation_plo values(2, current_date+122, true); Insert into t_j_planninglocation_plo values(2, current_date+123, true); Insert into t_j_planninglocation_plo values(2, current_date+124, true); Insert into t_j_planninglocation_plo values(2, current_date+125, true); Insert into t_j_planninglocation_plo values(2, current_date+126, true); Insert into t_j_planninglocation_plo values(2, current_date+127, true); Insert into t_j_planninglocation_plo values(2, current_date+128, true); Insert into t_j_planninglocation_plo values(2, current_date+129, true); Insert into t_j_planninglocation_plo values(2, current_date+130, true); Insert into t_j_planninglocation_plo values(2, current_date+131, true); Insert into t_j_planninglocation_plo values(2, current_date+132, true); Insert into t_j_planninglocation_plo values(2, current_date+133, true); Insert into t_j_planninglocation_plo values(2, current_date+134, true); Insert into t_j_planninglocation_plo values(2, current_date+135, true); Insert into t_j_planninglocation_plo values(2, current_date+136, true); Insert into t_j_planninglocation_plo values(2, current_date+137, true); Insert into t_j_planninglocation_plo values(2, current_date+138, true); Insert into t_j_planninglocation_plo values(2, current_date+139, true); Insert into t_j_planninglocation_plo values(2, current_date+140, true); Insert into t_j_planninglocation_plo values(2, current_date+141, true); Insert into t_j_planninglocation_plo values(2, current_date+142, true); Insert into t_j_planninglocation_plo values(2, current_date+143, true); Insert into t_j_planninglocation_plo values(2, current_date+144, true); Insert into t_j_planninglocation_plo values(2, current_date+145, true); Insert into t_j_planninglocation_plo values(2, current_date+146, true); Insert into t_j_planninglocation_plo values(2, current_date+147, true); Insert into t_j_planninglocation_plo values(2, current_date+148, true); Insert into t_j_planninglocation_plo values(2, current_date+149, true); Insert into t_j_planninglocation_plo values(2, current_date+150, true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 13, 5, 1, 'SIMPSON', '1/02/11', 'A wonderful place', 'Terrace overlooking Annecy. Spend an evening in this rental was marvelous.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 14, 6, 2, 'SIMPSON', '1/03/11', 'Tout simplement parfait ', 'Nous revenons pour la seconde fois et le charme continue à opérer. Le cadre, l''accueil de tout le personnel attentif et attentionné, contribuent à la magie des lieux.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 15, 7, 2, 'GROENING', '1/04/11', 'Un endroit magique avec vue sur le lac d''''Annecy', 'Location très chere (mieux vaut se le faire offrir) comprenant 3 chanbres, chacune particulière dans sa taille et sa décoration, certaines avec jaccuzi, la plupart avec terrasse ou balcon. Les  chambres étaient magnifiques, très luxueuses.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 16, 1, 2, 'AULAS', '1/05/11', 'Weekend magnifique', 'Les chambres sont parfaites avec une immense douche, cheminée au gaz, jacuzzi extra, lit douillet, machine nespresso (dommage qu''il ne propose que 2 dosettes). Une nuit de rêve, la perfection!', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 17, 2, 2, 'GOURCUF', '1/06/11', 'Pas terrible', 'Trop bling bling. Cher pour la qualité du logement. On entend le bruit des voitures sur la route et la ventilation. Propreté pas toujours impécable', 1,false); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 18, 3, 2, 'PARKER', '1/07/11', 'Toujours une belle adresse', 'Nous sommes retournés pour la six ou septième fois dans ce logement. Tout a été absolument parfait. La chambre mansardée au dernier étage est grande avec un jacuzzi et une cheminée au gaz... Un vrai rêve pour un weekend en amoureux. ', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 19, 4, 2, 'PERNAMBUCANO', '1/08/11', '2 ans de mariage magnifiques !', 'Une chambre parfaite , douillette , un jacuzzi à tomber , une cheminée qui vous met dans l ambiance , une atmosphère cosy ... Tout est la pour une belle soirée en amoureux ... Nous avons pu profiter d une piscine très agréable , bref un vrai moment de déconnexion .', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 20, 8, 2, 'SZYSLAK', '1/09/11', 'Bien mais…', 'Logement très confortable et propre, avec une belle vue sur le lac. D''excellents hôtes. J''aimerais revenir à coup sûr. Merci', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 21, 9, 2, 'SIMPSON', '1/10/11', 'Génial', 'L''hébergement a dépassé nos attentes. La terrasse est grande et beaucoup d''espace pour se détendre. Il y a 2 auvents qui sont plus que suffisantes pour fournir de l''ombre. Le logement est propre, bien tenu et très relaxant. C''est à 5 ou 10 minutes à pied pour aller dans les magasins les plus proches, peut-être à 15 minutes de marche pour aller dans les restaurants. La salle de bain et cuisines sont entièrement fonctionnement, et c''est vraiment utile ayant la machine à laver. Nous avons seulement une fois utilisé la piscine, donc je ne peux pas vraiment vous parler sur cela, car nous avons préféré rester sur notre terrasse. Nous avons tous adoré ce logement, et si j''étais pour un séjour à Annecy le Vieux nous aurions sans aucune hésitation à y retourner. Helen le propriétaire est très bien à garder le contact et nous laisser vous informer des problèmes, ou de faire en sorte que vous êtes rencontrés quand vous arrivez.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 22, 10, 2, 'LEPONGE', '1/11/11', 'Au top !', 'Un cadre superbe, une chambre magnifique avec un jacuzzi XL et une belle terrasse,une déco sympa, un parking tout proche pour la voiture, bref parfait pour une soirée en amoureux ! Un peu cher mais très bon rapport qualité-prix!', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 23, 11, 2, 'QUIMBY', '1/12/11', 'Bin', 'Nous venons de passer 2 semaines dans la villa et je dois dire que c''était très agréable, spacieuse, avec d''excellentes installations. La piscine était grande et très calme. Les jardins sont magnifiques et très calme. L''emplacement est très bien situé à quelques minutes à pied du centre ville ', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 24, 5, 2, 'SIMPSON', '1/01/12', 'Moment d''exception', 'Cadre sympa à découvrir. Vue sur le lac de la terrasse, belle piscine..... Accueil très chaleureux et pourtant discret.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 25, 6, 2, 'SIMPSON', '1/02/12', 'Magnifique villa', 'Nous sommes allés dans cette villa en famille. Première impression : Un hotel localisé un peu à l''écart d''Annecy, décoré avec goût. Petit plus pour le parasol naturel, un marronnier au milieu des tables dont les branches recouvraient la terrasse en un petit plafond. ', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 26, 7, 2, 'GROENING', '1/03/12', 'Très belle découverte', 'Le cadre est magnifique, notamment bien sûr les deux marronniers et la vue sublime sur le lac d''Annecy.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 27, 12, 2, 'ALBERTSON', '1/04/12', 'Superbe', 'Pour nos 7 ans de mariage, nous avons eu droit à la soirée parfaite. Le cadre magnifique (terrasse avec vue sur Annecy le vieux et arbre centenaire au milieu des tables...) y acontribué, mais pas seulement. ', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 28, 13, 2, 'GUMBLE', '1/05/12', 'Le repos absolu', 'Nous avons passé une nuit exceptionnelle dans une chambre où tout est conçu pour la relaxation : douche XXL, baignoire à remous pour deux personnes…', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 29, 14, 2, 'SIDESHOW', '1/06/12', 'Superbe terrasse', 'L''ambiance, l''architecture et la décoration sont déjà à elles seules dignes d''intérêt (je suis sensible à ces détails...) ! Nous avons apprécié la terrasse sous le plafond de marronniers, qui constitue un point de vue en hauteur sur la ville, cadre agréable pour un déjeuner en cas de beau temps.', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 30, 15, 2, 'LOURSON', '1/07/12', 'exceptionnel !', 'Nous avons été invité à passer un week-end dans ce lieu magique ! Nous ne nous attendions pas à une telle surprise, chaque minute a été un grand moment de plaisir, de détente, de délices... les chambre sont très cosy et très grand luxe.... jacuzzi, cheminée, douches...', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 31, 16, 2, 'CRUSH', '1/08/12', 'Génial !!', 'Alors si vous souhaitez vous évader le temps d''une nuit, c''est l''adresse qu''il vous faut !! rien a redire a part, vous aller y prendre goût ! La déco est juste magnifique, le mobilier moderne, la salle de bain... J''en reve encore... ;-)', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 32, 17, 2, 'FLAM', '1/09/12', 'A essayer sans hésiter', 'Les jardins sont magnifiques et très calme. L''emplacement est très bien situé à quelques minutes à pied du centre ville ', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 33, 18, 2, 'LESURVIVANT', '1/10/12', 'excellent', 'Nous avons adoré notre séjour dans cette villa c''était spacieuse, immaculé et élégamment meublées dans un style contemporain. Les jardins étaient paisible et bien entretenu avec une excellente piscine avec une partie peu profonde approprié pour les jeunes enfants. Nous avons adoré l''emplacement, à une courte distance à pied de la plage et aussi pas mal marcher jusqu''à Annecy dans la soirée. La vue sur les jardins depuis la grande terrasse ensoleillée était superbe. Le propriétaire était extrêmement utile sur le téléphone et nous avons reçu un accueil chaleureux de la part de son représentant quand nous sommes arrivés. Nous recommandons fortement cette villa', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 34, 19, 2, 'BROS', '1/11/12', 'Parfait Parfait Parfait !', 'Chambres magnifiquement aménagées, style cosy et moderne. Jacuzzi, cheminée, rien ne manque, tous les détails sont soignés Salle de bains très originale. Couloir de nage dans le jardin pour l''été, très belle terrasse.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 35, 20, 2, 'BROS', '1/12/12', 'Fantastic', 'We stayed at this villa in June. from the moment i booked it ,i felt i knew Helen personally. She couldn''t have been more helpful. We arrived late at the house to be met by the most pleasant man, Dennis. The apartment exceeded all our expectations.The beds were a dream.The apartment spotless.The wifi reception was brilliant as was the sky tv. It was fab.So close to everything and yet so peaceful.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 36, 21, 2, 'PRINCESSE', '1/01/13', 'The perfect choice', 'Walking through the house it exceeded our expectations, it was actually larger than the pictures suggest, furniture and décor in excellent order, giving you the feeling of making the right decision. The location was superb, within 5 minutes walk to supermarket and restaurants, we managed the week without a hire car and the used the pool on site', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 1, 37, 22, 2, 'KONG', '1/02/13', 'On ne veut plus partir !', 'Le temps s''arrête lorsque l''on met les pieds dans cette magnifique bâtisse. Une seule chose à faire : profiter d''un accueil délicieux accompagné d''une vue imprenable et d''un décor parfait.', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 38, 5, 2, 'SIMPSON', '1/03/13', 'Great', 'The kids were delighted, we all felt safe and assured within the villa at all times. The acid test being: we would come back and do it all over again, don''t hesitate. Thanks Helen', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 3, 39, 6, 2, 'SIMPSON', '1/04/13', 'Exceptionnel', 'Jolie villa proche des restuarants, du centre ville et superbe vue sur le lac', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 4, 40, 7, 2, 'GROENING', '1/05/13', 'Calme et volupté dans un cadre idyllique.', 'Nous avons loué cette ville à Noël pendant 15 jours. Nous sommes allés skier à la Clusaz à 50 km ce fut génial. Le soir, tout était sous la main pour pouvoir faire la fête et en profiter. Bien entretenue. Cadr idyllique avec vue sur le lac d''Annecy.', 4,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 41, 23, 2, 'DE CAMBRIDGE', '1/06/13', 'Très bien', 'Je suis ravie de mon séjour à Annecy le Vieux dans cette magnifique batisse. Les commentaires précédents sont tous vrais et cela vaut vraiment de cout (cout !) de dépenser près de 1500 euros pour la semaine', 5,true); Insert into t_e_avis_avi(loc_id, vis_id, per_id, abo_id, lng_id, avi_nomoccupant, avi_date, avi_titre, avi_detail, avi_noteglobale, avi_recommandationami) values(1, 2, 42, 24, 2, 'MIDDLETON', '1/07/13', 'Mauvais rapport qualité-prix', 'Le lit était particulièrement dur. Etant maniaque, j''ai cherché la poussière et en ai trouvé. Pour le prix, on s''attendrait à bcp mieux. Ce n''est pas du standing du prix, beaucoup trop élevé', 1,false); Insert into t_r_questionlocation_qul(qul_question) values ('La réservation a-t-elle été facile ?'); --1
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
Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(1, null, 'images/img10.jpg'); Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(1, null, 'images/img11.jpg'); Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(1, null, 'images/img12.jpg'); Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(null, 1, 'images/img13.jpg'); Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(null, 2, 'images/img14.jpg');
Insert into t_e_photo_pho(loc_id, avi_id, pho_url) values(null, 2, 'images/img15.jpg');  
insert into t_j_utilite_uti values (1,1);
insert into t_j_utilite_uti values (2,1);
insert into t_j_utilite_uti values (3,1);
insert into t_j_utilite_uti values (3,2);
insert into t_j_utilite_uti values (4,2);
insert into t_j_utilite_uti values (5,2);
insert into t_j_utilite_uti values (1,2);
