create table if not exists modw_cloud.deleted_instance_types as select
	it.instance_type_id,
	it.instance_type
from
	modw_cloud.instance_type as it
left join
	modw_cloud.instance_type_staging as its on it.instance_type_id = its.instance_type_id
where
	its.instance_type is null
and
	it.instance_type != 'Unknown';