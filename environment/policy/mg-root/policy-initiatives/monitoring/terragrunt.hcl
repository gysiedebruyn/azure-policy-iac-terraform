terraform {
  source = "${get_repo_root()}/modules/policy-initiative//."
}

include {
  path = find_in_parent_folders()
}

dependency "deploy_storage_account_diagnostic_setting" {
  config_path = "${get_parent_terragrunt_dir()}/policy/mg-root/policy-definitions/deploy-storage-account-diagnostic-setting"
  mock_outputs = {
    definition = {
      id          = "/subscriptions/${uuid()}/providers/Microsoft.Authorization/policyDefinitions/mock"
      name        = "mock_${uuid()}"
      parameters  = "{}"
      policy_type = "Custom"
      role_definition_ids = [
        "/providers/microsoft.authorization/roleDefinitions/${uuid()}",
        "/providers/microsoft.authorization/roleDefinitions/${uuid()}",
      ]
    }
  }
}

inputs = {
  member_definitions = [
    dependency.deploy_storage_account_diagnostic_setting.outputs.definition
  ]
}
