-- Remove disk_gb from instance_type and update the PRIMARY KEY.
-- Deduplicate any rows that became identical after removing disk_gb,
-- keeping the row with the lowest instance_type_id.
DELETE it1
FROM modw_cloud.instance_type it1
INNER JOIN modw_cloud.instance_type it2
    ON  it1.resource_id    = it2.resource_id
    AND it1.instance_type  = it2.instance_type
    AND it1.start_time     = it2.start_time
    AND it1.num_cores      = it2.num_cores
    AND it1.memory_mb      = it2.memory_mb
    AND it1.instance_type_id > it2.instance_type_id;

-- Rebuild the primary key without disk_gb and drop the column.
ALTER TABLE modw_cloud.instance_type
    DROP PRIMARY KEY,
    DROP COLUMN disk_gb,
    ADD PRIMARY KEY (resource_id, instance_type, start_time, num_cores, memory_mb);
