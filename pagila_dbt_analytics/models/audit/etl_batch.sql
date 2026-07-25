create table audit.etl_batch
(
    batch_id           bigserial primary key,
    pipeline_name      varchar(100),
    run_started_at     timestamp,
    run_finished_at    timestamp,
    status             varchar(20),
    environment        varchar(20),
    dbt_version        varchar(20),
    invocation_id      varchar(100)
);