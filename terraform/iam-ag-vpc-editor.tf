
# Name of the Access Group
resource "ibm_iam_access_group" "ag-vpc-editor" {
  name = format("%s-%s", local.basename, "ag-vpc-editor")
  tags = var.tags
}

# Visibility on the Resource Group
resource "ibm_iam_access_group_policy" "policy_rg_viewer_editor" {
  access_group_id = ibm_iam_access_group.ag-vpc-editor.id
  roles           = ["Viewer"]
  resources {
    resource_type = "resource-group"
    resource      = ibm_resource_group.group.id
  }
}

# Operator role is required on VPC/Subnet to be able 
# to select a VPC while creating a VSI.
# Use role Operator to prevent users from creating VPC/Subnet networks
# Use role Editor to enable users to create VPC/Subnet networks
resource "ibm_iam_access_group_policy" "policy_vpc_editor" {
  access_group_id = ibm_iam_access_group.ag-vpc-editor.id
  roles           = ["Editor"]

  for_each = local.is_network_service_types
  resource_attributes {
    name     = each.key
    operator = "stringEquals"
    value    = each.value
  }
  resource_attributes {
    name     = "serviceName"
    operator = "stringEquals"
    value    = "is"
  }
  resource_attributes {
    name     = "resourceGroupId"
    operator = "stringEquals"
    value    = ibm_resource_group.group.id
  }
  resource_attributes {
    name     = "region"
    operator = "stringEquals"
    value    = "eu-de"
  }
}

# Editor role is required to create a VSI or Block Storage.
# Viewer/Operator can only list VSI.
resource "ibm_iam_access_group_policy" "policy_vsi_editor" {
  access_group_id = ibm_iam_access_group.ag-vpc-editor.id
  roles           = ["Editor"]

  for_each = local.is_instance_service_types
  resource_attributes {
    name     = each.key
    operator = "stringEquals"
    value    = each.value
  }
  resource_attributes {
    name     = "serviceName"
    operator = "stringEquals"
    value    = "is"
  }
  resource_attributes {
    name     = "resourceGroupId"
    operator = "stringEquals"
    value    = ibm_resource_group.group.id
  }
  resource_attributes {
    name     = "region"
    operator = "stringEquals"
    value    = "eu-de"
  }

}