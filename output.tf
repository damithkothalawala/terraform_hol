output "BastionInstance" {
  value = ["${oci_core_instance.BastionInstance.public_ip}"]
}
