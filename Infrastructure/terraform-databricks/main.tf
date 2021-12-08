terraform {
  backend "remote" {
    organization = "zambrana"

    workspaces {
      name = "AfG-Databricks"
    }
  }
  required_version = "= 1.0.11"
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.11"
    }
    azurerm = "=2.88.1"
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_databricks_workspace" "databricksWokspace" {
  name                = "${var.suffix}${var.workspaceName}"
  resource_group_name = "${var.suffix}${var.rgName}"
}

provider "databricks" {
  azure_workspace_resource_id = data.azurerm_databricks_workspace.databricksWokspace.id
}
