
// Cluster Variables
variable "cluster_id" {
  default     = ""
  description = "**Optional**: if you have an existing cluster to install the Cloud Pak, use the cluster ID or name. If left blank, a new Openshift cluster will be provisioned"
}

// if set to false, cluster is on Classic Infrastructure
variable "on_vpc" {
  type        = bool
  default     = false
  description = "Ignored if `cluster_id` is specified. Cluster type to be installed on, 'true' = VPC, 'false' = Classic"
}

variable "region" {
  default     = "us-south"
  description = "Ignored if `cluster_id` is specified. Region to provision the Openshift cluster. List all available regions with: ibmcloud regions"
}

variable "resource_group" {
  default     = "Default"
  description = "Ignored if `cluster_id` is specified. Resource Group in your account to host the cluster. List all available resource groups with: ibmcloud resource groups"
}

// Only required if cluster id is not specified
variable "project_name" {
  description = "Ignored if `cluster_id` is specified. The project_name is combined with environment to name the cluster. The cluster name will be '{project_name}-{environment}-cluster' and all the resources will be tagged with 'project:{project_name}'"
}

// Only required if cluster id is not specified
variable "environment" {
  default     = "dev"
  description = "Ignored if `cluster_id` is specified. The environment is combined with project_name to name the cluster. The cluster name will be '{project_name}-{environment}-cluster' and all the resources will be tagged with 'env:{environment}'"
}

// Only required if cluster id is not specified
variable "owner" {
  description = "Ignored if `cluster_id` is specified. Use your user name or team name. The owner is used to label the cluster and other resources with the tag 'owner:{owner}'"
}

// Only required if cluster id is not specified. Flavor will depend on whether classic or vpc
variable "flavors" {
  type        = list(string)
  default     = ["b3c.16x64"]
  description = "Ignored if `cluster_id` is specified. Array with the flavors or machine types of each the workers group. Classic only takes the first flavor of the list. List all flavors for each zone with: 'ibmcloud ks flavors --zone us-south-1 --provider <classic | vpc-gen2>'. Example: [\"bx2.16x64\", \"mx2.8x64\", \"cx2.4x8\"]"
}

variable "force_delete_storage" {
  default     = true
  description = "Ignored if `cluster_id` is specified. If set to true, storage will be deleted with cluster is destroyed"
}

// Only required if cluster id is not specified and 'on_vpc=false'
variable "datacenter" {
  default     = ""
  description = "**Classic Only**: Ignored if `cluster_id` is specified. Datacenter or Zone in the region to provision the cluster. List all available zones with: `ibmcloud ks zone ls --provider classic`. Only required if cluster id not specified and on_vpc=false."
}

// VLAN numbers variables on the datacenter
variable "private_vlan_number" {
  default     = ""
  description = "**Classic Only**: Ignored if `cluster_id` is specified. Private VLAN assigned to your zone. List available VLANs in the zone: `ibmcloud ks vlan ls --zone <datacenter>`, make sure the the VLAN type is private and the router begins with bc. Use the ID or Number."
}

variable "public_vlan_number" {
  default     = ""
  description = "**Classic Only**: Ignored if `cluster_id` is specified. Public VLAN assigned to your zone. List available VLANs in the zone: `ibmcloud ks vlan ls --zone <datacenter>`, make sure the the VLAN type is public and the router begins with fc. Use the ID or Number."
}

variable "vpc_zone_names" {
  type        = list(string)
  default     = ["us-south-1"]
  description = "**VPC Only**: Ignored if `cluster_id` is specified. Zones in the IBM Cloud VPC region to provision the cluster. List all available zones with: `ibmcloud ks zone ls --provider vpc-gen2`."
}

// Needed for both Portworx and IAF
variable "ibmcloud_api_key" {
  description = "Required for both Portworx and IAF. IBM Cloud API Key for the account the resources will be provisioned on. Go here to create an ibmcloud_api_key: https://cloud.ibm.com/iam/apikeys"
}

// Portworx Variables
variable "install_portworx" {
  type        = bool
  default     = false
  description = "Install Portworx on the ROKS cluster"
}

variable "storage_capacity"{
    type = number
    default = 200
    description = "Ignored if Portworx is not enabled: Storage capacityin GBs"
}

variable "storage_profile" {
    type = string
    default = "10iops-tier"
    description = "Ignored if Portworx is not enabled. Optional, Storage profile used for creating storage"
}

variable "storage_iops" {
    type = number
    default = 10
    description = "Ignored if Portworx is not enabled. Optional, Used only if a user provides a custom storage_profile"
}

variable "create_external_etcd" {
    type = bool
    default = false
    description = "Ignored if Portworx is not enabled: Create an external etcd database?"
}

# These credentials have been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.
# You may override these for additional security.
variable "etcd_username" {
  default = ""
  description = "Ignored if Portworx is not enabled: This has been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.  Override these for additional security."
}

variable "etcd_password" {
  default = ""
  description = "Ignored if Portworx is not enabled: This has been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.  Override these for additional security."
}

// IAF Module Variables
variable "entitled_registry_key" {
  default     = ""
  description = "Required for IAF: Cloud Pak Entitlement Key. Get the entitlement key from: https://myibm.ibm.com/products-services/containerlibrary, copy and paste the key to this variable"
}

variable "entitled_registry_user_email" {
  description = "Required for IAF: Email address of the user owner of the Entitled Registry Key"
}

// ROKS Module : Local Variables and constants
locals {
  workers_count              = [4]
  roks_version               = "4.6"
  kubeconfig_dir             = "./.kube/config"
  entitled_registry_key_file = "./entitlement.key"
}
