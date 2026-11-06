/**
 * # AWS EKS Traefik Ingress controller Terraform module
 *
 * A Terraform module to deploy the [Traefik Ingress controller](https://traefik.io/traefik/) on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/pre-commit.yaml)
 */
locals {
  crds = {
    name = "ingress-traefik-crds"

    # The deprecated traefik-crds chart has no new releases and its latest version is incompatible
    # with the current Traefik chart, so install the CRDs with Kustomize from the Traefik chart
    # repository at the tag matching the installed Traefik chart version. Kustomize requires an
    # ArgoCD Application, so the CRDs always deploy through ArgoCD.
    argo_source_type            = "kustomize"
    argo_enabled                = true
    argo_source_repo_url        = "https://github.com/traefik/traefik-helm-chart.git"
    argo_source_path            = "traefik/crds"
    argo_source_target_revision = "v${local.addon.helm_chart_version}"

    # The Kustomize options go through argo_spec, because settings is a map(any) and cannot hold both a map and a list
    argo_spec = {
      source = {
        kustomize = {
          # ArgoCD keeps the CRDs, and so every Traefik resource, when the Application is deleted
          commonAnnotations = {
            "helm.sh/resource-policy" = "keep"
          }
          # Install only the traefik.io CRDs. Drop the Traefik Hub CRDs and the Gateway API CRDs that the chart bundles
          patches = [{
            target = {
              kind = "CustomResourceDefinition"
              name = ".*\\.(hub\\.traefik\\.io|gateway\\.networking\\.k8s\\.io)"
            }
            patch = yamlencode({
              "$patch"   = "delete"
              apiVersion = "apiextensions.k8s.io/v1"
              kind       = "CustomResourceDefinition"
              metadata = {
                name = "ignored"
              }
            })
          }]
        }
      }
    }

    argo_kubernetes_manifest_wait_fields = {
      "status.sync.status"   = "Synced"
      "status.health.status" = "Healthy"
    }
  }

  crds_values = yamlencode({})

  addon = {
    name = "ingress-traefik"

    helm_chart_name    = "traefik"
    helm_chart_version = "42.1.3" # 3.7.17
    helm_repo_url      = "https://traefik.github.io/charts"
    helm_skip_crds     = var.crds_enabled # CRDs are installed by the CRDs module, if enabled
  }

  addon_values = yamlencode({})

  addon_depends_on = [
    module.crds
  ]
}
