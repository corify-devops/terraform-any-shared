locals {
  config = templatefile("${path.module}/config.yaml", { platform = var.platform, endpoint = var.endpoint, token = var.token, autodiscover = var.autodiscover })
}

resource "helm_release" "renovate" {
  name      = var.name
  namespace = var.namespace

  repository = "https://docs.renovatebot.com/helm-charts"
  chart      = "renovate"

  values = [local.config]

  set {
    name  = "cronjob.schedule"
    value = var.schedule
  }
}