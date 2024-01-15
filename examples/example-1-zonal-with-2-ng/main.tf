
module "kube" {
  source = "github.com/nebius/terraform-il-kubernetes.git"

  network_id = var.network_id
  //network_policy_provider = "cilium" // calico disabled in nebius mk8s
  enable_cilium_policy = true

  master_locations = [
    {
      zone      = "il1-c"
      subnet_id = var.subnet_id
    },
  ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "20:00"
      duration   = "3h"
    }
  ]
  node_groups = {
    "k8s-ng-system" = {
      description = "Kubernetes nodes group 01 with fixed 1 size scaling"
      fixed_scale = {
        size = 2
      }
      nat = true
      node_labels = {
        "group" = "system"
      }
      # node_taints = ["CriticalAddonsOnly=true:NoSchedule"]
    }
    "k8s-ng-a100-gpu" = {
      description = "Kubernetes nodes a100-gpu node with autoscaling"
      auto_scale = {
        min     = 0
        max     = 3
        initial = 0
      }
      platform_id     = "gpu-standard-v3" // https://nebius.com/il/docs/compute/concepts/vm-platforms
      gpu_environment = "runc"
      node_cores      = 28  // change according to VM size 28/20 a100/h100
      node_memory     = 119 // change according to VM size 119/160 a100/h100
      node_gpus       = 1
      disk_type       = "network-ssd"
      disk_size       = 186
      nat             = true
      node_labels = {
        "group" = "a100-gpu"
        "cloud.google.com/gke-accelerator" = "ovpfix" // K8S-25 NEMAXSUP-121
      }
    }
  }
}