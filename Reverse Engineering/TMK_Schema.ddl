-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2023-05-19 21:40:39 IDT
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



CREATE ROLE tmk_hr NOT IDENTIFIED;

CREATE USER tmk_hr 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

GRANT CREATE TRIGGER,
    CREATE SEQUENCE,
    CREATE VIEW,
    CREATE TABLE,
    UNLIMITED TABLESPACE,
    ALTER SESSION, CREATE SESSION TO TMK_HR 
;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE OR REPLACE DIRECTORY dir_csv AS 'c:\oracle_data\';

GRANT READ, WRITE ON DIRECTORY dir_csv TO tmk_hr;

CREATE SEQUENCE tmk_hr.calculation_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE;

CREATE SEQUENCE tmk_hr.monthly_attendance_seq INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 20;

CREATE TABLE tmk_hr.attendance_types (
    attendance_type_id          NUMBER(5) NOT NULL,
    description                 VARCHAR2(40 BYTE),
    total_weekly_working_hours  NUMBER(3),
    total_monthly_working_hours NUMBER(4)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

CREATE UNIQUE INDEX tmk_hr.att_type_id_pk ON
    tmk_hr.attendance_types (
        attendance_type_id
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE tmk_hr.attendance_types
    ADD CONSTRAINT att_type_id_pk PRIMARY KEY ( attendance_type_id )
        USING INDEX tmk_hr.att_type_id_pk;

CREATE TABLE tmk_hr.calculations (
    calculation_id             NUMBER(10) NOT NULL,
    employee_id                NUMBER(10),
    attendance_type_id         NUMBER(5),
    start_time                 INTERVAL DAY(0) TO SECOND(0),
    end_time                   INTERVAL DAY(0) TO SECOND(0),
    official_start_time        INTERVAL DAY(0) TO SECOND(0),
    official_end_time          INTERVAL DAY(0) TO SECOND(0),
    attendance_date            DATE,
    attendance_day             VARCHAR2(20 BYTE),
    time_before_official_start INTERVAL DAY(0) TO SECOND(0),
    time_after_official_start  INTERVAL DAY(0) TO SECOND(0),
    time_before_official_end   INTERVAL DAY(0) TO SECOND(0),
    time_after_official_end    INTERVAL DAY(0) TO SECOND(0),
    isitworkingday             NUMBER(1),
    total_working_hours        INTERVAL DAY(0) TO SECOND(0),
    over_time                  INTERVAL DAY(0) TO SECOND(0)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

CREATE INDEX tmk_hr.employee_id_calculations_index ON
    tmk_hr.calculations (
        employee_id
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE tmk_hr.calculations
    ADD CONSTRAINT calculations_pk PRIMARY KEY ( calculation_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE tmk_hr.daily_attendance (
    daily_attendance_id NUMBER(10) NOT NULL,
    employee_id         NUMBER(10),
    attendance_date     DATE,
    attendance_day      VARCHAR2(20 BYTE),
    start_time          INTERVAL DAY(0) TO SECOND(0),
    end_time            INTERVAL DAY(0) TO SECOND(0)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

CREATE INDEX tmk_hr.employee_id_daily_attendance_index ON
    tmk_hr.daily_attendance (
        employee_id
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE tmk_hr.daily_attendance
    ADD CONSTRAINT daily_attendance_pk PRIMARY KEY ( daily_attendance_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE tmk_hr.days (
    day_id              NUMBER(2) NOT NULL,
    attendance_type_id  NUMBER(5),
    day_name            VARCHAR2(20 BYTE),
    official_start_time INTERVAL DAY(0) TO SECOND(0),
    official_end_time   INTERVAL DAY(0) TO SECOND(0),
    isitworkingday      NUMBER(1)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

CREATE INDEX tmk_hr.dayname_index ON
    tmk_hr.days (
        day_name
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE tmk_hr.days
    ADD CONSTRAINT days_pk PRIMARY KEY ( day_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE tmk_hr.employees (
    employee_id        NUMBER(10) NOT NULL,
    employee_name      VARCHAR2(50 BYTE),
    employee_email     VARCHAR2(50 BYTE),
    employee_salary    NUMBER(6),
    attendance_type_id NUMBER(5),
    position_id        NUMBER(10)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

ALTER TABLE tmk_hr.employees
    ADD CONSTRAINT employees_pk PRIMARY KEY ( employee_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE tmk_hr.external_daily_attendance (
    daily_attendance_id NUMBER(10),
    employee_id         NUMBER(10),
    attendance_date     VARCHAR2(40 BYTE),
    attendance_day      VARCHAR2(20 BYTE),
    start_time          VARCHAR2(5 BYTE),
    end_time            VARCHAR2(5 BYTE)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
    DEFAULT DIRECTORY dir_csv ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL
    ) LOCATION ( "DIR_CSV" : 'DailyAttendance.csv' )
) REJECT LIMIT UNLIMITED
    PARALLEL 5;

CREATE TABLE tmk_hr.external_employees (
    employee_id        NUMBER(10),
    employee_name      VARCHAR2(50 BYTE),
    employee_email     VARCHAR2(50 BYTE),
    employee_salary    NUMBER(6),
    attendance_type_id NUMBER(5),
    position_id        NUMBER(10)
)
ORGANIZATION EXTERNAL ( TYPE oracle_loader
    DEFAULT DIRECTORY dir_csv ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ',' MISSING FIELD VALUES ARE NULL
    ) LOCATION ( "DIR_CSV" : 'Employees.csv' )
) REJECT LIMIT UNLIMITED
    PARALLEL 5;

CREATE TABLE tmk_hr.monthly_attendance (
    monthly_attendance_id      NUMBER(10) NOT NULL,
    employee_id                NUMBER(10),
    monthly_name               VARCHAR2(20 BYTE),
    time_before_official_start VARCHAR2(20 BYTE),
    time_after_official_start  VARCHAR2(20 BYTE),
    time_before_official_end   VARCHAR2(20 BYTE),
    over_time                  VARCHAR2(20 BYTE),
    total_working_hours        VARCHAR2(10 BYTE),
    time_after_official_end    VARCHAR2(20 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

ALTER TABLE tmk_hr.monthly_attendance
    ADD CONSTRAINT monthly_attendance_pk PRIMARY KEY ( monthly_attendance_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE tmk_hr.positions (
    position_id   NUMBER(10) NOT NULL,
    position_name VARCHAR2(30 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
NO INMEMORY;

ALTER TABLE tmk_hr.positions
    ADD CONSTRAINT positions_pk PRIMARY KEY ( position_id )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE tmk_hr.employees
    ADD FOREIGN KEY ( attendance_type_id )
        REFERENCES tmk_hr.attendance_types ( attendance_type_id )
    NOT DEFERRABLE;

ALTER TABLE tmk_hr.employees
    ADD FOREIGN KEY ( position_id )
        REFERENCES tmk_hr.positions ( position_id )
    NOT DEFERRABLE;

ALTER TABLE tmk_hr.daily_attendance
    ADD FOREIGN KEY ( employee_id )
        REFERENCES tmk_hr.employees ( employee_id )
    NOT DEFERRABLE;

ALTER TABLE tmk_hr.monthly_attendance
    ADD FOREIGN KEY ( employee_id )
        REFERENCES tmk_hr.employees ( employee_id )
    NOT DEFERRABLE;

ALTER TABLE tmk_hr.calculations
    ADD FOREIGN KEY ( employee_id )
        REFERENCES tmk_hr.employees ( employee_id )
    NOT DEFERRABLE;

ALTER TABLE tmk_hr.days
    ADD FOREIGN KEY ( attendance_type_id )
        REFERENCES tmk_hr.attendance_types ( attendance_type_id )
    NOT DEFERRABLE;

CREATE OR REPLACE VIEW TMK_HR.EMPLOYEE_MONTHLY_ATTENDANCE_DETAILS_VIEW ( EMPLOYEE_ID, EMPLOYEE_NAME, POSITION_NAME, MONTHLY_NAME, TOTAL_WORKING_HOURS, TIME_BEFORE_OFFICIAL_START, TIME_AFTER_OFFICIAL_START, TIME_BEFORE_OFFICIAL_END, TIME_AFTER_OFFICIAL_END, OVER_TIME ) AS
SELECT m.employee_id,
           e.employee_name,
           p.position_name,
           m.monthly_name,
           m.total_working_hours,
           m.time_before_official_start,
           m.time_after_official_start,
           m.time_before_official_end,
           m.time_after_official_end,
           m.over_time
      FROM monthly_attendance m
           JOIN employees e ON m.employee_id = e.employee_id
           JOIN positions p ON e.position_id = p.position_id
    ORDER BY m.employee_id, m.monthly_name 
;

CREATE OR REPLACE VIEW TMK_HR.EMPLOYEE_MONTHLY_ATTENDANCE_SUMMARY_VIEW ( EMPLOYEE_ID, EMPLOYEE_NAME, MONTHLY_NAME, TOTAL_WORKING_HOURS, OVER_TIME ) AS
SELECT m.employee_id,
           e.employee_name,
           m.monthly_name,
           m.total_working_hours,
           m.over_time
      FROM monthly_attendance m
           JOIN employees e ON m.employee_id = e.employee_id
    ORDER BY m.employee_id, m.monthly_name 
;

CREATE OR REPLACE TRIGGER TMK_HR.CALCULATION_ID_TRIGGER 
    BEFORE INSERT ON TMK_HR.CALCULATIONS 
    FOR EACH ROW 
BEGIN
    :new.calculation_id := calculation_seq.NEXTVAL;
END; 
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             4
-- ALTER TABLE                             13
-- CREATE VIEW                              2
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         1
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              1
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          2
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
