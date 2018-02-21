variable "tenancy_ocid" {
	default = "please_replace_this_value"
}
variable "user_ocid" {
	default = "please_replace_this_value"
}
variable "fingerprint" {
	default = "please_replace_this_value"
}

variable "private_key_path" {
	default = "./credentials/oci_api_key.pem"
}

variable "region" {
	default = "please_replace_this_value"
}

variable "compartment_ocid" {
	default = "please_replace_this_value"
}
variable "ssh_public_key" {
	default = "./credentials/oci_ssh_key.pub"
}
variable "ssh_private_key" {
	default = "./credentials/oci_ssh_key.pem"
}

variable "AD" {
    default = "1"
}

variable "InstanceShape" {
    default = "VM.Standard1.2"
}

variable "InstanceOS" {
    default = "Oracle Linux"
}

variable "InstanceOSVersion" {
    default = "7.4"
}

variable "BootStrapFile" {
    default = "./userdata/bootstrap"
}

variable "VPC-CIDR" {
	default = "192.168.191.0/24" # Do not change this without changing vcn.tf's subnets NO USE - will fix this 
}




	
