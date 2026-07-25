create table audit.etl_reject_log
(
    reject_id          bigserial primary key,
    batch_id           bigint,
    model_name         varchar(100),
    business_key       varchar(200),
    reason             text,
    rejected_at        timestamp
);