CREATE SEQUENCE ${ohdsiSchema}.SEC_USER_SEQUENCE START WITH 1000 INCREMENT BY 1 MAXVALUE 9223372036854775807 NO CYCLE;
CREATE TABLE ${ohdsiSchema}.SEC_USER(
    ID                  INTEGER NOT NULL DEFAULT NEXTVAL('${ohdsiSchema}.SEC_USER_SEQUENCE'),
    LOGIN               VARCHAR(50),
    PASSWORD            VARCHAR(255),
    SALT                VARCHAR(255),
    NAME                VARCHAR(100)
);

COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER.ID IS 'primary key';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER.LOGIN IS 'Login';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER.PASSWORD IS 'Password';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER.SALT IS 'Salt for password encoding';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER.NAME IS 'Displayed name for user';

CREATE SEQUENCE ${ohdsiSchema}.SEC_ROLE_SEQUENCE START WITH 1000 INCREMENT BY 1 MAXVALUE 9223372036854775807 NO CYCLE;
CREATE TABLE ${ohdsiSchema}.SEC_ROLE (
    ID                  INTEGER NOT NULL DEFAULT NEXTVAL('${ohdsiSchema}.SEC_ROLE_SEQUENCE'),
    NAME                VARCHAR(255)
);

COMMENT ON COLUMN ${ohdsiSchema}.SEC_ROLE.ID IS 'primary key';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_ROLE.NAME IS 'Role name';

CREATE SEQUENCE ${ohdsiSchema}.SEC_USER_ROLE_SEQUENCE START WITH 1000 INCREMENT BY 1 MAXVALUE 9223372036854775807 NO CYCLE;
CREATE TABLE ${ohdsiSchema}.SEC_USER_ROLE(
    ID                  INTEGER NOT NULL DEFAULT NEXTVAL('${ohdsiSchema}.SEC_USER_ROLE_SEQUENCE'),
    USER_ID             INTEGER NOT NULL,
    ROLE_ID             INTEGER NOT NULL,
    STATUS		VARCHAR(255) NULL	
);

COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER_ROLE.ID IS 'Primary key';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER_ROLE.USER_ID IS 'Foreign key to SEC_USER';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER_ROLE.ROLE_ID IS 'Foreign key to SEC_ROLE';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_USER_ROLE.STATUS IS 'Status of relation between user and role';

CREATE SEQUENCE ${ohdsiSchema}.SEC_PERMISSION_SEQUENCE START WITH 1000 INCREMENT BY 1 MAXVALUE 9223372036854775807 NO CYCLE;
CREATE TABLE ${ohdsiSchema}.SEC_PERMISSION(
    ID                  INTEGER NOT NULL DEFAULT NEXTVAL('${ohdsiSchema}.SEC_PERMISSION_SEQUENCE'),
    VALUE               VARCHAR(255) NOT NULL,
    DESCRIPTION		VARCHAR(255) NULL
);

COMMENT ON COLUMN ${ohdsiSchema}.SEC_PERMISSION.ID IS 'Primary key';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_PERMISSION.VALUE IS 'Permission';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_PERMISSION.DESCRIPTION IS 'Desctiption of permission';

CREATE SEQUENCE ${ohdsiSchema}.SEC_ROLE_PERMISSION_SEQUENCE START WITH 1000 INCREMENT BY 1 MAXVALUE 9223372036854775807 NO CYCLE;
CREATE TABLE ${ohdsiSchema}.SEC_ROLE_PERMISSION (
    ID					INTEGER NOT NULL DEFAULT NEXTVAL('${ohdsiSchema}.SEC_ROLE_PERMISSION_SEQUENCE'),
	ROLE_ID             INTEGER NOT NULL,
	PERMISSION_ID		INTEGER NOT NULL,
	STATUS				VARCHAR(255) NULL
);

COMMENT ON COLUMN ${ohdsiSchema}.SEC_ROLE_PERMISSION.ID IS 'Primary key';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_ROLE_PERMISSION.ROLE_ID IS 'Foreign key to SEC_ROLE';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_ROLE_PERMISSION.PERMISSION_ID IS 'Foreign key to SEC_PERMISSION';
COMMENT ON COLUMN ${ohdsiSchema}.SEC_ROLE_PERMISSION.STATUS IS 'Status of relation between role and permission';


-- add SEC_USER table constraints
ALTER TABLE ${ohdsiSchema}.SEC_USER ADD CONSTRAINT PK_SEC_USER PRIMARY KEY (ID);

-- add SEC_ROLE table constraints
ALTER TABLE ${ohdsiSchema}.SEC_ROLE ADD CONSTRAINT PK_SEC_ROLE PRIMARY KEY (ID);

-- add SEC_PERMISSION table constraints
ALTER TABLE ${ohdsiSchema}.SEC_PERMISSION ADD CONSTRAINT PK_SEC_PERMISSION PRIMARY KEY (ID);

-- add SEC_USER_ROLE table constraints
ALTER TABLE ${ohdsiSchema}.SEC_USER_ROLE ADD CONSTRAINT PK_SEC_USER_ROLE PRIMARY KEY (ID);
ALTER TABLE ${ohdsiSchema}.SEC_USER_ROLE ADD CONSTRAINT FK_USER_ROLE_TO_USER FOREIGN KEY (USER_ID) REFERENCES ${ohdsiSchema}.SEC_USER(ID);
ALTER TABLE ${ohdsiSchema}.SEC_USER_ROLE ADD CONSTRAINT FK_USER_ROLE_TO_ROLE FOREIGN KEY (ROLE_ID) REFERENCES ${ohdsiSchema}.SEC_ROLE(ID);

-- add SEC_ROLE_PERMISSION table constraints
ALTER TABLE ${ohdsiSchema}.SEC_ROLE_PERMISSION ADD CONSTRAINT PK_SEC_ROLE_PERMISSION PRIMARY KEY (ID);
ALTER TABLE ${ohdsiSchema}.SEC_ROLE_PERMISSION ADD CONSTRAINT FK_ROLE_PERMISSION_TO_ROLE FOREIGN KEY (ROLE_ID) REFERENCES ${ohdsiSchema}.SEC_ROLE(ID);
ALTER TABLE ${ohdsiSchema}.SEC_ROLE_PERMISSION ADD CONSTRAINT FK_ROLE_PERMISSION_TO_PERMISSION FOREIGN KEY (PERMISSION_ID) REFERENCES ${ohdsiSchema}.SEC_PERMISSION(ID);
