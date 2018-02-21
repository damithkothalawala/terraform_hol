# Gets the OCID of the OS image to use
data "oci_core_images" "OLImageOCID" {
    compartment_id = "${var.compartment_ocid}"
    operating_system = "${var.InstanceOS}"
    operating_system_version = "${var.InstanceOSVersion}"
}


#Bastion Servers

resource "oci_core_instance" "BastionInstance" {
  count = 1
  availability_domain = "${element(list(oci_core_subnet.BastionSubnetAD1.availability_domain), count.index)}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "BastionInstance-${count.index}"
  #hostname_label = "BastionInstance-${count.index}"
  image = "${lookup(data.oci_core_images.OLImageOCID.images[1], "id")}"
  shape = "${var.InstanceShape}"
  subnet_id = "${element(list(oci_core_subnet.BastionSubnetAD1.id), count.index)}"
  metadata {
    ssh_authorized_keys = "${file(var.ssh_public_key)}"
    user_data = "${base64encode(file(var.BootStrapFile))}"
  }

  timeouts {
    create = "60m"
  }
}






