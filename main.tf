provider "kubernetes" {
  config_path = "/var/lib/jenkins/.kube/config"
}

resource "kubernetes_namespace" "demo_ns" {
  metadata {
    name = "devops-demo"
  }
}
