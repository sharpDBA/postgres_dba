select
    pl.pid
     -- Blocked PID
    ,(select pid
    from pg_stat_activity blocking
    where cardinality(pg_blocking_pids(pid)) > 0) as blocking_id
    ,psa.usename
    ,psa.application_name
    ,pl.mode
    ,(current_timestamp - psa.query_start) as q_runtime
    ,(current_timestamp - psa.backend_start) as backend_runtime
    ,pd.datname
    ,pc.relname
    ,psa.state as process_state
     -- Blocked User
    ,(select usename
    from pg_stat_activity blocking
    where cardinality(pg_blocking_pids(pid)) > 0) as blocked_user
     -- Blocked Query
    ,(select query as blocked_query
        from pg_stat_activity
        where cardinality(pg_blocking_pids(pid)) > 0)
from pg_locks pl
    inner join pg_database pd
        on pl.database = pd.oid
    inner join pg_class pc
        on pl.relation=pc.oid
    inner join pg_stat_activity psa
        on pl.pid = psa.pid
where mode not in ('AccessShareLock')
order by pl.pid, pl.mode, psa.usename, pl.database, backend_runtime
;
