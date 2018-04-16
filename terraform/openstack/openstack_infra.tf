provider "openstack" {
	user_name   = ""
	tenant_name = ""
	password    = ""
	auth_url    = "http://192.168.10.5:5000/v3"
	region      = "RegionOne"
	domain_name = "Default"
}

resource "openstack_cumpute_instance_v2" "basic" {
	name            = "basic"
	image_id        = "id_od_the_image"
	flavor_id       = "3"
	security_groups = ["default"]

	network = {
			name = "int-net"
	}

}
