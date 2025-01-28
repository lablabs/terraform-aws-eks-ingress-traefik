/**
 * # AWS EKS Traefik Ingress controller Terraform module
 *
 * A Terraform module to deploy the [Traefik Ingress controller](https://traefik.io/traefik/) on Amazon EKS cluster.
 *
 * [![Terraform validate](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/validate.yaml)
 * [![pre-commit](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-eks-ingress-traefik/actions/workflows/pre-commit.yaml)
 */
locals {
  addon = {
    name = "ingress-traefik"

    helm_chart_name    = "traefik"
    helm_chart_version = "34.1.0"
    helm_repo_url      = "https://traefik.github.io/charts"
  }

  addon_values = yamlencode({
    # FIXME config: add default values here
  })
}
