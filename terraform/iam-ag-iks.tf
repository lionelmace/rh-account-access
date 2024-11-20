# Create Access Group
resource "ibm_iam_access_group" "accgrp" {
  name = format("%s-%s", local.basename, "ag-iks")
  tags = var.tags
}

# Visibility on the Resource Group
resource "ibm_iam_access_group_policy" "iam-rg-viewer" {
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Viewer"]
  resources {
    resource_type = "resource-group"
    resource      = ibm_resource_group.group.id
  }
}

# Service: Kubernetes Service
# Create a policy to all Kubernetes/OpenShift clusters within the Resource Group
resource "ibm_iam_access_group_policy" "policy-k8s" {
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Manager", "Writer", "Editor", "Operator", "Viewer", "Administrator"]

  resources {
    service           = "containers-kubernetes"
    resource_group_id = ibm_resource_group.group.id
  }
}

# Service: Kubernetes Service
# Role Viewer is required to be able to select Cloud Pak license during cluster creation
# Platform Roles: Viewer with No Resource Group.
resource "ibm_iam_access_group_policy" "ag-policy-ks-license" {
  for_each        = var.users
  access_group_id = ibm_iam_access_group.accgrp.id
  resource_attributes {
    name     = "serviceName"
    operator = "stringEquals"
    value    = "containers-kubernetes"
  }
  roles = ["Viewer"]
}


# Assign Administrator platform access role to enable the creation of API Key
# Pre-Req to provision IKS/ROKS clusters within a Resource Group
resource "ibm_iam_access_group_policy" "policy-k8s-identity-administrator" {
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Administrator", "User API key creator", "Service ID creator"]

  resources {
    service = "iam-identity"
  }
}

# Assign Administrator platform access role to enable the creation of COS bucket
resource "ibm_iam_access_group_policy" "policy-cos-administrator" {
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Reader", "Writer", "Manager", "Content Reader", "Object Reader", "Object Writer", "Backup Manager", "Backup Reader", "Key Manager", "Service Configuration Reader", "Administrator", "Editor", "Operator", "Viewer"]

  resources {
    service           = "cloud-object-storage"
    resource_group_id = ibm_resource_group.group.id
  }
}