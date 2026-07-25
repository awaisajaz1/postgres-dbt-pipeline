create table audit.etl_error_log
(
    error_id          bigserial primary key,
    batch_id          bigint,
    model_name        varchar(100),
    error_timestamp   timestamp,
    error_message     text,
    sql_state         varchar(20),
    stack_trace       text
);