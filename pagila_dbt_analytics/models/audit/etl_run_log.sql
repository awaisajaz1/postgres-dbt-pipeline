create table audit.etl_run_log
(
    run_log_id          bigserial primary key,
    batch_id            bigint,
    model_name          varchar(100),
    layer_name          varchar(20),
    started_at          timestamp,
    completed_at        timestamp,
    execution_seconds   numeric(10,2),
    rows_read           bigint,
    rows_inserted       bigint,
    rows_updated        bigint,
    rows_deleted        bigint,
    status              varchar(20)
);