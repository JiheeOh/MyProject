CREATE TABLE user_table
(
    user_id                 VARCHAR2(100)    NOT NULL, 
    user_pwd                VARCHAR2(100)    NULL, 
    user_email              VARCHAR2(100)    NULL, 
    user_phone_number       VARCHAR2(100)    NULL, 
    user_address_number1    VARCHAR2(100)    NULL, 
    user_address_number2    VARCHAR2(100)    NULL, 
    user_address_number3    VARCHAR2(100)    NULL, 
    user_profile            VARCHAR2(100)    NULL, 
    user_gender             VARCHAR2(100)    NULL, 
    identity                VARCHAR2(100)    NULL, 
     PRIMARY KEY (user_id)
)

alter table user_table add session_id varchar2(100) default 'nan' not null;
alter table user_table add limit_time DATE;
