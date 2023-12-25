terraform {
  required_version = ">= 1.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.13"
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
}

data "nebius_client_config" "client" {}

data "nebius_kubernetes_cluster" "kubernetes" {
  name = nebius_kubernetes_cluster.kube_cluster.name
}
