# Object Storage to backup the OpenShift Internal Registry
##############################################################################
resource "ibm_resource_instance" "cos_openshift_registry" {
  name              = join("-", [local.basename, "cos-registry"])
  resource_group_id = ibm_resource_group.group.id
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
  tags              = var.tags
}
