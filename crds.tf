locals {
  crds_enabled           = var.enabled && var.crds_enabled
  crds_helm_release_name = var.crds_helm_release_name != null ? var.crds_helm_release_name : try(local.crds.helm_release_name, local.crds.name)
  crds_helm_chart_name   = var.crds_helm_chart_name != null ? var.crds_helm_chart_name : try(local.crds.helm_chart_name, local.crds.name)
}

module "crds" {
  source = "git::https://github.com/lablabs/terraform-aws-eks-universal-addon.git//modules/addon?ref=v0.0.12"

  enabled = local.crds_enabled

  # variable priority var.crds_* (provided by the module user) > local.crds.* (universal addon default override) > default (universal addon default)
  namespace = local.addon_namespace # Controlled by the addon module

  helm_enabled                    = var.crds_helm_enabled != null ? var.crds_helm_enabled : try(local.crds.helm_enabled, true)
  helm_release_name               = local.crds_helm_release_name
  helm_chart_name                 = local.crds_helm_chart_name
  helm_chart_version              = var.crds_helm_chart_version != null ? var.crds_helm_chart_version : local.crds.helm_chart_version
  helm_atomic                     = var.crds_helm_atomic != null ? var.crds_helm_atomic : try(local.crds.helm_atomic, false)
  helm_cleanup_on_fail            = var.crds_helm_cleanup_on_fail != null ? var.crds_helm_cleanup_on_fail : try(local.crds.helm_cleanup_on_fail, false)
  helm_create_namespace           = var.helm_create_namespace != null ? var.helm_create_namespace : try(local.addon.helm_create_namespace, true) # Controlled by the addon module
  helm_dependency_update          = var.crds_helm_dependency_update != null ? var.crds_helm_dependency_update : try(local.crds.helm_dependency_update, false)
  helm_description                = var.crds_helm_description != null ? var.crds_helm_description : try(local.crds.helm_description, "")
  helm_devel                      = var.crds_helm_devel != null ? var.crds_helm_devel : try(local.crds.helm_devel, false)
  helm_disable_openapi_validation = var.crds_helm_disable_openapi_validation != null ? var.crds_helm_disable_openapi_validation : try(local.crds.helm_disable_openapi_validation, false)
  helm_disable_webhooks           = var.crds_helm_disable_webhooks != null ? var.crds_helm_disable_webhooks : try(local.crds.helm_disable_webhooks, false)
  helm_force_update               = var.crds_helm_force_update != null ? var.crds_helm_force_update : try(local.crds.helm_force_update, false)
  helm_keyring                    = var.crds_helm_keyring != null ? var.crds_helm_keyring : try(local.crds.helm_keyring, "~/.gnupg/pubring.gpg")
  helm_lint                       = var.crds_helm_lint != null ? var.crds_helm_lint : try(local.crds.helm_lint, false)
  helm_package_verify             = var.crds_helm_package_verify != null ? var.crds_helm_package_verify : try(local.crds.helm_package_verify, false)
  helm_postrender                 = var.crds_helm_postrender != null ? var.crds_helm_postrender : try(local.crds.helm_postrender, {})
  helm_recreate_pods              = var.crds_helm_recreate_pods != null ? var.crds_helm_recreate_pods : try(local.crds.helm_recreate_pods, false)
  helm_release_max_history        = var.crds_helm_release_max_history != null ? var.crds_helm_release_max_history : try(local.crds.helm_release_max_history, 0)
  helm_render_subchart_notes      = var.crds_helm_render_subchart_notes != null ? var.crds_helm_render_subchart_notes : try(local.crds.helm_render_subchart_notes, true)
  helm_replace                    = var.crds_helm_replace != null ? var.crds_helm_replace : try(local.crds.helm_replace, false)
  helm_repo_ca_file               = var.crds_helm_repo_ca_file != null ? var.crds_helm_repo_ca_file : try(local.crds.helm_repo_ca_file, "")
  helm_repo_cert_file             = var.crds_helm_repo_cert_file != null ? var.crds_helm_repo_cert_file : try(local.crds.helm_repo_cert_file, "")
  helm_repo_key_file              = var.crds_helm_repo_key_file != null ? var.crds_helm_repo_key_file : try(local.crds.helm_repo_key_file, "")
  helm_repo_password              = var.crds_helm_repo_password != null ? var.crds_helm_repo_password : try(local.crds.helm_repo_password, "")
  helm_repo_url                   = var.crds_helm_repo_url != null ? var.crds_helm_repo_url : local.crds.helm_repo_url
  helm_repo_username              = var.crds_helm_repo_username != null ? var.crds_helm_repo_username : try(local.crds.helm_repo_username, "")
  helm_reset_values               = var.crds_helm_reset_values != null ? var.crds_helm_reset_values : try(local.crds.helm_reset_values, false)
  helm_reuse_values               = var.crds_helm_reuse_values != null ? var.crds_helm_reuse_values : try(local.crds.helm_reuse_values, false)
  helm_set_sensitive              = var.crds_helm_set_sensitive != null ? var.crds_helm_set_sensitive : try(local.crds.helm_set_sensitive, {})
  helm_skip_crds                  = var.crds_helm_skip_crds != null ? var.crds_helm_skip_crds : try(local.crds.helm_skip_crds, false)
  helm_timeout                    = var.crds_helm_timeout != null ? var.crds_helm_timeout : try(local.crds.helm_timeout, 300)
  helm_wait                       = var.crds_helm_wait != null ? var.crds_helm_wait : try(local.crds.helm_wait, false)
  helm_wait_for_jobs              = var.crds_helm_wait_for_jobs != null ? var.crds_helm_wait_for_jobs : try(local.crds.helm_wait_for_jobs, false)

  argo_apiversion                                        = var.crds_argo_apiversion != null ? var.crds_argo_apiversion : try(local.crds.argo_apiversion, "argoproj.io/v1alpha1")
  argo_destination_server                                = var.crds_argo_destination_server != null ? var.crds_argo_destination_server : try(local.crds.argo_destination_server, "https://kubernetes.default.svc")
  argo_enabled                                           = var.crds_argo_enabled != null ? var.crds_argo_enabled : try(local.crds.argo_enabled, false)
  argo_helm_enabled                                      = var.crds_argo_helm_enabled != null ? var.crds_argo_helm_enabled : try(local.crds.argo_helm_enabled, false)
  argo_helm_values                                       = var.crds_argo_helm_values != null ? var.crds_argo_helm_values : try(local.crds.argo_helm_values, "")
  argo_helm_wait_backoff_limit                           = var.crds_argo_helm_wait_backoff_limit != null ? var.crds_argo_helm_wait_backoff_limit : try(local.crds.argo_helm_wait_backoff_limit, 6)
  argo_helm_wait_node_selector                           = var.crds_argo_helm_wait_node_selector != null ? var.crds_argo_helm_wait_node_selector : try(local.crds.argo_helm_wait_node_selector, var.crds_argo_helm_wait_node_selector)
  argo_helm_wait_timeout                                 = var.crds_argo_helm_wait_timeout != null ? var.crds_argo_helm_wait_timeout : try(local.crds.argo_helm_wait_timeout, "10m")
  argo_helm_wait_tolerations                             = var.crds_argo_helm_wait_tolerations != null ? var.crds_argo_helm_wait_tolerations : try(local.crds.argo_helm_wait_tolerations, tolist([]))
  argo_info                                              = var.crds_argo_info != null ? var.crds_argo_info : try(local.crds.argo_info, [{ name = "terraform", value = "true" }])
  argo_kubernetes_manifest_computed_fields               = var.crds_argo_kubernetes_manifest_computed_fields != null ? var.crds_argo_kubernetes_manifest_computed_fields : try(local.crds.argo_kubernetes_manifest_computed_fields, ["metadata.labels", "metadata.annotations", "metadata.finalizers"])
  argo_kubernetes_manifest_field_manager_force_conflicts = var.crds_argo_kubernetes_manifest_field_manager_force_conflicts != null ? var.crds_argo_kubernetes_manifest_field_manager_force_conflicts : try(local.crds.argo_kubernetes_manifest_field_manager_force_conflicts, false)
  argo_kubernetes_manifest_field_manager_name            = var.crds_argo_kubernetes_manifest_field_manager_name != null ? var.crds_argo_kubernetes_manifest_field_manager_name : try(local.crds.argo_kubernetes_manifest_field_manager_name, "Terraform")
  argo_kubernetes_manifest_wait_fields                   = var.crds_argo_kubernetes_manifest_wait_fields != null ? var.crds_argo_kubernetes_manifest_wait_fields : try(local.crds.argo_kubernetes_manifest_wait_fields, tomap({}))
  argo_metadata                                          = var.crds_argo_metadata != null ? var.crds_argo_metadata : try(local.crds.argo_metadata, { finalizers = ["resources-finalizer.argocd.argoproj.io"] })
  argo_namespace                                         = var.crds_argo_namespace != null ? var.crds_argo_namespace : try(local.crds.argo_namespace, "argo")
  argo_project                                           = var.crds_argo_project != null ? var.crds_argo_project : try(local.crds.argo_project, "default")
  argo_spec                                              = var.crds_argo_spec != null ? var.crds_argo_spec : try(local.crds.argo_spec, tomap({}))
  argo_sync_policy                                       = var.crds_argo_sync_policy != null ? var.crds_argo_sync_policy : try(local.crds.argo_sync_policy, tomap({}))

  settings = var.crds_settings != null ? var.crds_settings : try(local.crds.settings, tomap({}))
  values   = one(data.utils_deep_merge_yaml.crds_values[*].output)
}

data "utils_deep_merge_yaml" "crds_values" {
  count = local.crds_enabled ? 1 : 0

  input = compact([
    local.crds_values,
    var.crds_values
  ])
}

output "crds" {
  description = "The CRDs module outputs"
  value       = module.crds
}
