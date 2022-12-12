terraform {
    required_providers  {
        azurerm =   {
            source  =   "hashicorp/azurerm"
            version = "~>2.0"
        }
    }
}

terraform {
    backend "azurerm" {
        resource_group_name     =   "DEV-STOR-RG"
        storage_account_name    =   "diagandtestsav2dev"
        container_name          =   "tfm"
        key                     =   var.ARM_ACCESS_KEY
    }
}
# Provider Block

provider "azurerm" {

    client_id       =   var.client_id
    client_secret   =   var.client_secret
    subscription_id =   var.subscription_id
    tenant_id       =   var.tenant_id
    
    features {}
}
