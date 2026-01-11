terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
  }

}
provider "azurerm" {
  features {}
  subscription_id = "02e2bf71-710c-4170-b8d6-c0cf2ca7551b"
}





