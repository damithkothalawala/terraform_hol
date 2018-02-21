#!/bin/bash
curl -o terraform.zip -L "https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_windows_amd64.zip"
unzip -x -d ./ terraform.zip
rm -f terraform.zip
mkdir -p .terraform/plugins
curl -o windows.zip -L "https://github.com/oracle/terraform-provider-oci/releases/download/v2.0.6/windows.zip"
unzip -x -d ./.terraform/plugins/ windows.zip
rm -f windows.zip
./terraform init
