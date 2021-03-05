// Openshift cluster parameters
// ----------------------------

// Use cluster_id if there is a cluster to install the Cloud Pak, example:
// cluster_id = "********************"

// RECOMMENDED: to set the cluster_id using an external input, like this:
// export TF_VAR_cluster_id="*********************"

// Otherwise, create a cluster based on values below
project_name = "cloud-pack"
owner        = "anonymous"
environment  = "sandbox"
region       = "us-south"
resource_group = "cloud-pak-sandbox"
// resource_group = "cloud-pak-sandbox-ibm"
datacenter     = "dal10"

// VLAN's numbers on datacenter 'dal10' on Humio account. They are here until the
// permissions issues is fixed on Humio account
//private_vlan_number = "2979232"
//public_vlan_number  = "2979230"

// RECOMMENDED: to set the owner variable from $USER, like this:
// export TF_VAR_owner=$USER
// RECOMMENDED: to set the project_name variable to avoid conflicts, like this:
// export TF_VAR_project_name="something-different"

// Entitlement Key parameters
// --------------------------

// 1. Get the entitlement key from: https://myibm.ibm.com/products-services/containerlibrary, save the key to the
// file "./entitlement.key"
// 2. Set the entitled_registry_user_email with the docker email address to login to the registry, example:
// entitled_registry_user_email = "John.Doe@ibm.com"

// RECOMMENDED: to set the entitled_registry_user_email using an external input, like this:
// export TF_VAR_entitled_registry_user_email="johandry.amador@ibm.com"

// CP4DATA Parametrers:
// --------------------

storage_class_name = "ibmc-file-custom-gold-gid"

// CP4DATA Modules installation parameters
// ---------------------------------------

install_watson_knowledge_catalog = false
install_watson_studio            = false
install_watson_machine_learning  = false
install_watson_open_scale        = false
install_data_virtualization      = false
install_streams                  = false
install_analytics_dashboard      = false
install_spark                    = false
install_db2_warehouse            = false
install_db2_data_gate            = false
install_rstudio                  = false
install_db2_data_management      = false
