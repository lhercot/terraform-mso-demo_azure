terraform {
  required_providers {
    mso = {
      source = "CiscoDevNet/mso"
    }
  }
}

provider "mso" {
  # Configuration options
  // Requires ENV variable TF_VAR_mso_username 
  username  = var.mso_username
  // Requires ENV variable TF_VAR_mso_password
  password  = var.mso_password
  // Requires ENV variable TF_VAR_mso_url
  url       = var.mso_url

  insecure  = true
}

data "mso_tenant" "wos" {
  name = var.tenant
  display_name = var.tenant
}

data "mso_site" "azure" {
  name  = var.site_name
}

data "mso_schema" "hybrid_cloud" {
  name          = "terraform_hybrid_cloud"
}

resource "mso_rest" "azure_site" {
  path = "api/v1/schemas/${mso_schema.hybrid_cloud.id}"
  method = "PATCH"
  payload = <<EOF
[
  {
    "op": "add",
    "path": "/sites/-",
    "value": {
      "siteId": "${data.mso_site.aws.id}",
      "templateName": "Template1",
      "contracts": [
        {
          "contractRef": {
            "schemaId": "${data.mso_schema.hybrid_cloud.id}",
            "templateName": "Template1",
            "contractName": "${var.name_prefix}Internet-to-Web"
          }
        },{
          "contractRef": {
            "schemaId": "${data.mso_schema.hybrid_cloud.id}",
            "templateName": "Template1",
            "contractName": "${var.name_prefix}Web-to-DB"
          }
        },{
          "contractRef": {
            "schemaId": "${data.mso_schema.hybrid_cloud.id}",
            "templateName": "Template1",
            "contractName": "${var.name_prefix}VMs-to-Internet"
          }
        }
      ],
      "vrfs": [{
        "vrfRef": {
          "schemaId": "${data.mso_schema.hybrid_cloud.id}",
          "templateName": "Template1",
          "vrfName": "${var.name_prefix}Hybrid_Cloud_VRF"
        },
        "regions": [{
            "name": "westus",
            "cidrs": [{
              "ip": "10.101.210.0/24",
              "primary": true,
              "subnets": [{
                "ip": "10.101.210.0/25",
                "zone": "",
                "name": ""
              }, {
                "ip": "10.101.210.128/25",
                "zone": "",
                "name": ""
              }],
              "associatedRegion": "westus"
          }],
          "isVpnGatewayRouter": false,
          "isTGWAttachment": true,
          "cloudRsCtxProfileToGatewayRouterP": {
            "name": "default",
            "tenantName": "infra"
          },
          "hubnetworkPeering": false
        }]
      }],
      "intersiteL3outs": null
    }
  }
]
EOF

}