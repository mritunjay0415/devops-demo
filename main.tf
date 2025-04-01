provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "demo_ns" {
  metadata {
    name = "devops-demo"
  }
}
