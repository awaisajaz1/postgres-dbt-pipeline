create table audit.etl_data_quality
(
    quality_id         bigserial primary key,
    batch_id           bigint,
    model_name         varchar(100),
    test_name          varchar(100),
    passed             boolean,
    failed_rows        bigint,
    executed_at        timestamp
);