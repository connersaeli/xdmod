update
	modw_cloud.instance_data as itd
join 
	modw_cloud.deleted_instance_types as d on itd.instance_type_id = d.instance_type_id
join
	modw_cloud.event as ev on ev.event_id = itd.event_id
join 
	modw_cloud.instance_type as it on it.instance_type = d.instance_type and ev.event_time_ts between it.start_time and it.end_time and ev.resource_id = it.resource_id
set
	itd.instance_type_id = it.instance_type_id