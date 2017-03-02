/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     02/03/2017 13:40:32                          */
/*==============================================================*/


drop index CATEGORIE_PK;

drop table CATEGORIE;

drop index EVENEMENT_POT2_FK;

drop index CATEGORIE_EVENEMENT_FK;

drop index ORGANISATEUR_FK;

drop index EVENEMENT_PK;

drop table EVENEMENT;

drop index MEMBRE_PK;

drop table MEMBRE;

drop index MOUVEMENT2_FK;

drop index MOUVEMENT_FK;

drop index MOUVEMENT_PK;

drop table MOUVEMENT;

drop index EVENEMENT_PARTICIPANT_FK;

drop index MEMBRE_PARTICIPANT_FK;

drop index PARTICIPANT_PK;

drop table PARTICIPANT;

drop index EVENEMENT_POT_FK;

drop index POT_PK;

drop table POT;

/*==============================================================*/
/* Table: CATEGORIE                                             */
/*==============================================================*/
create table CATEGORIE (
   IDCATEGORIE          SERIAL               not null,
   DESIGNATION          VARCHAR(100)         null,
   constraint PK_CATEGORIE primary key (IDCATEGORIE)
);

/*==============================================================*/
/* Index: CATEGORIE_PK                                          */
/*==============================================================*/
create unique index CATEGORIE_PK on CATEGORIE (
IDCATEGORIE
);

/*==============================================================*/
/* Table: EVENEMENT                                             */
/*==============================================================*/
create table EVENEMENT (
   IDEVEMENT            SERIAL               not null,
   IDCATEGORIE          INT4                 not null,
   IDMEMBRE             INT4                 not null,
   IDPOT                INT4                 null,
   DESIGNATION          VARCHAR(100)         null,
   DATEDEBUT            DATE                 null,
   DATEFIN              DATE                 null,
   DESCRIPTION          TEXT                 null,
   constraint PK_EVENEMENT primary key (IDEVEMENT)
);

/*==============================================================*/
/* Index: EVENEMENT_PK                                          */
/*==============================================================*/
create unique index EVENEMENT_PK on EVENEMENT (
IDEVEMENT
);

/*==============================================================*/
/* Index: ORGANISATEUR_FK                                       */
/*==============================================================*/
create  index ORGANISATEUR_FK on EVENEMENT (
IDMEMBRE
);

/*==============================================================*/
/* Index: CATEGORIE_EVENEMENT_FK                                */
/*==============================================================*/
create  index CATEGORIE_EVENEMENT_FK on EVENEMENT (
IDCATEGORIE
);

/*==============================================================*/
/* Index: EVENEMENT_POT2_FK                                     */
/*==============================================================*/
create  index EVENEMENT_POT2_FK on EVENEMENT (
IDPOT
);

/*==============================================================*/
/* Table: MEMBRE                                                */
/*==============================================================*/
create table MEMBRE (
   IDMEMBRE             SERIAL               not null,
   NOM                  VARCHAR(50)          null,
   PRENOM               VARCHAR(50)          null,
   DATENAISSANCE        DATE                 null,
   EMAIL                VARCHAR(50)          null,
   MOTDEPASSE           VARCHAR(50)          null,
   constraint PK_MEMBRE primary key (IDMEMBRE)
);

/*==============================================================*/
/* Index: MEMBRE_PK                                             */
/*==============================================================*/
create unique index MEMBRE_PK on MEMBRE (
IDMEMBRE
);

/*==============================================================*/
/* Table: MOUVEMENT                                             */
/*==============================================================*/
create table MOUVEMENT (
   IDPARTICIPANT        INT4                 not null,
   IDPOT                INT4                 not null,
   DATEMVT              DATE                 null,
   MONTANTMVT           NUMERIC              null,
   TYPE                 VARCHAR(20)          null,
   constraint PK_MOUVEMENT primary key (IDPARTICIPANT, IDPOT)
);

/*==============================================================*/
/* Index: MOUVEMENT_PK                                          */
/*==============================================================*/
create unique index MOUVEMENT_PK on MOUVEMENT (
IDPARTICIPANT,
IDPOT
);

/*==============================================================*/
/* Index: MOUVEMENT_FK                                          */
/*==============================================================*/
create  index MOUVEMENT_FK on MOUVEMENT (
IDPARTICIPANT
);

/*==============================================================*/
/* Index: MOUVEMENT2_FK                                         */
/*==============================================================*/
create  index MOUVEMENT2_FK on MOUVEMENT (
IDPOT
);

/*==============================================================*/
/* Table: PARTICIPANT                                           */
/*==============================================================*/
create table PARTICIPANT (
   IDPARTICIPANT        SERIAL               not null,
   IDEVEMENT            INT4                 not null,
   IDMEMBRE             INT4                 not null,
   constraint PK_PARTICIPANT primary key (IDPARTICIPANT)
);

/*==============================================================*/
/* Index: PARTICIPANT_PK                                        */
/*==============================================================*/
create unique index PARTICIPANT_PK on PARTICIPANT (
IDPARTICIPANT
);

/*==============================================================*/
/* Index: MEMBRE_PARTICIPANT_FK                                 */
/*==============================================================*/
create  index MEMBRE_PARTICIPANT_FK on PARTICIPANT (
IDMEMBRE
);

/*==============================================================*/
/* Index: EVENEMENT_PARTICIPANT_FK                              */
/*==============================================================*/
create  index EVENEMENT_PARTICIPANT_FK on PARTICIPANT (
IDEVEMENT
);

/*==============================================================*/
/* Table: POT                                                   */
/*==============================================================*/
create table POT (
   IDPOT                SERIAL               not null,
   IDEVEMENT            INT4                 not null,
   MONTANTMAX           NUMERIC              null,
   constraint PK_POT primary key (IDPOT)
);

/*==============================================================*/
/* Index: POT_PK                                                */
/*==============================================================*/
create unique index POT_PK on POT (
IDPOT
);

/*==============================================================*/
/* Index: EVENEMENT_POT_FK                                      */
/*==============================================================*/
create  index EVENEMENT_POT_FK on POT (
IDEVEMENT
);

alter table EVENEMENT
   add constraint FK_EVENEMEN_CATEGORIE_CATEGORI foreign key (IDCATEGORIE)
      references CATEGORIE (IDCATEGORIE)
      on delete restrict on update restrict;

alter table EVENEMENT
   add constraint FK_EVENEMEN_EVENEMENT_POT foreign key (IDPOT)
      references POT (IDPOT)
      on delete restrict on update restrict;

alter table EVENEMENT
   add constraint FK_EVENEMEN_ORGANISAT_MEMBRE foreign key (IDMEMBRE)
      references MEMBRE (IDMEMBRE)
      on delete restrict on update restrict;

alter table MOUVEMENT
   add constraint FK_MOUVEMEN_MOUVEMENT_PARTICIP foreign key (IDPARTICIPANT)
      references PARTICIPANT (IDPARTICIPANT)
      on delete restrict on update restrict;

alter table MOUVEMENT
   add constraint FK_MOUVEMEN_MOUVEMENT_POT foreign key (IDPOT)
      references POT (IDPOT)
      on delete restrict on update restrict;

alter table PARTICIPANT
   add constraint FK_PARTICIP_EVENEMENT_EVENEMEN foreign key (IDEVEMENT)
      references EVENEMENT (IDEVEMENT)
      on delete restrict on update restrict;

alter table PARTICIPANT
   add constraint FK_PARTICIP_MEMBRE_PA_MEMBRE foreign key (IDMEMBRE)
      references MEMBRE (IDMEMBRE)
      on delete restrict on update restrict;

alter table POT
   add constraint FK_POT_EVENEMENT_EVENEMEN foreign key (IDEVEMENT)
      references EVENEMENT (IDEVEMENT)
      on delete restrict on update restrict;

