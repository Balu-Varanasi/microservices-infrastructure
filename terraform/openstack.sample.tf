module "dc2-keypair" {
	source = "./terraform/openstack/keypair"
	auth_url = ""
	tenant_id = ""
	tenant_name = ""
	region = ""
	public_key = ""
	keypair_name = ""
}

module "dc2-hosts" {
	source = "./terraform/openstack/hosts"
	auth_url = ""
	tenant_id = ""
	tenant_name = ""
	region = "${ module.dc2-keypair.region }"
	control_flavor_name = ""
	resource_flavor_name  = ""
	net_id = ""
	image_name = ""
	keypair_name = "${ module.dc2-keypair.keypair_name }"
	control_count = "2"
	resource_count = "3"
	security_groups = "default"
}

module "dc2-resource-volume" {
        source = "./terraform/openstack/volume"
        region = "${ module.dc2-keypair.region }"
        volume_size = ""
        short_name = ""
        volume_count = "${ module.dc2-hosts.resource_count }"
}

module "dc2-control-volume" {
        source = "./terraform/openstack/volume"
        region = "${ module.dc2-keypair.region }"
        volume_size = ""
        short_name = ""
        volume_count = "${ module.dc2-hosts.control_count }"
}