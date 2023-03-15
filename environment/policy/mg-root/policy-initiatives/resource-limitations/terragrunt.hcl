terraform {
  source = "${get_repo_root()}/modules/policy-initiative//."
}

include {
  path = find_in_parent_folders()
}

dependency "whitelist_regions" {
  config_path = "${get_parent_terragrunt_dir()}/policy/mg-root/policy-definitions/whitelist-regions"
  mock_outputs = {
    definition = {
      "description"         = ""
      "display_name"        = "Mock"
      "id"                  = "/subscriptions/${uuid()}/providers/Microsoft.Authorization/policyDefinitions/mock"
      "management_group_id" = ""
      "metadata"            = "{}"
      "mode"                = "All"
      "name"                = "mock"
      "parameters"          = "{}"
      "policy_rule"         = "{}"
      "policy_type"         = "Custom"
      "role_definition_ids" = tolist([])
      "timeouts"            = {}
    }
  }
}

dependency "denied_resources" {
  config_path = "${get_parent_terragrunt_dir()}/policy/mg-root/policy-definitions/denied-resources"
  mock_outputs = {
    definition = {
      "description"         = ""
      "display_name"        = "Mock"
      "id"                  = "/subscriptions/${uuid()}/providers/Microsoft.Authorization/policyDefinitions/mock"
      "management_group_id" = ""
      "metadata"            = "{}"
      "mode"                = "All"
      "name"                = "mock_${uuid()}"
      "parameters"          = "{}"
      "policy_rule"         = "{}"
      "policy_type"         = "Custom"
      "role_definition_ids" = tolist([])
      "timeouts"            = {}
    }
  }
}

inputs = {
  member_definitions = [
    dependency.whitelist_regions.outputs.definition,
    dependency.denied_resources.outputs.definition
  ]
}
