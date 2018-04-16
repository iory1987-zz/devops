# to run user:
# terraform plan -var-file='vars.tfvars'
# terraform apply -var-file="vars.tfvars"

# Set the variable value in *.tfvars file
variable "do_token" {}
variable "hostname" { default = "docker"}
variable "ssh_01" {}
variable "ssh_02" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_volume" "docker" {
  region      = "nyc1"
  name        =  "dockerdata"
  size        = 10
  description = "volume to stored docker data"
}

# Create a new Web Droplet in the nyc1 region
resource "digitalocean_droplet" "web" {
  name       = "${var.hostname}"
  size       = "1gb"
  image      = "centos-7-x64"
  region     = "nyc1"
  ssh_keys   = ["${var.ssh_01}", "${var.ssh_02}"]
  volume_ids = ["${digitalocean_volume.docker.id}"]
}
