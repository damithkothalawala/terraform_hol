data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.tenancy_ocid}"
}

resource "oci_core_virtual_network" "CompleteVCN" {
  cidr_block = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "CompleteVCN"
}

resource "oci_core_internet_gateway" "CompleteIG" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "CompleteIG"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
}

resource "oci_core_route_table" "RouteForComplete" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    display_name = "RouteTableForComplete"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.CompleteIG.id}"
    }
}

resource "oci_core_security_list" "WebSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Public"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
        destination = "0.0.0.0/0"
        protocol = "6"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 80
            "min" = 80
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
	{
	protocol = "6"
	source = "${var.VPC-CIDR}"
    }]
}

resource "oci_core_security_list" "PrivateSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Private"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
	protocol = "6"
	destination = "${var.VPC-CIDR}"
    }]
    ingress_security_rules = [{
        protocol = "6"
        source = "${var.VPC-CIDR}"
    }]
}

resource "oci_core_security_list" "BastionSubnet" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "Bastion"
    vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
    egress_security_rules = [{
	protocol = "6"
        destination = "0.0.0.0/0"
    }]
    ingress_security_rules = [{
        tcp_options {
            "max" = 22
            "min" = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    },
	{
	protocol = "6"
        source = "${var.VPC-CIDR}"
    }]	
}


resource "oci_core_subnet" "BastionSubnetAD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block = "192.168.191.0/25"
  display_name = "BastionSubnetAD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.CompleteVCN.id}"
  route_table_id = "${oci_core_route_table.RouteForComplete.id}"
  security_list_ids = ["${oci_core_security_list.BastionSubnet.id}"]
  dhcp_options_id = "${oci_core_virtual_network.CompleteVCN.default_dhcp_options_id}"
}





