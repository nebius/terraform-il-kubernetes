terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "> 3.3"
    }
  }
}

provider "yandex" {
  endpoint = "api.il.nebius.cloud:443"
  storage_endpoint = "storage.cloudil.com:443"
  folder_id = "b488doomdmdh67vc9it1"
}

provider "local" {}

provider "random" {}
