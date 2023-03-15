terraform {
  source = "${get_repo_root()}/modules/policy-def-assignment//."
}

include {
  path = find_in_parent_folders()
}

dependency "require_resource_group_tags" {
  config_path = "${get_parent_terragrunt_dir()}/policy/mg-root/policy-definitions/require-resource-group-tags"
  mock_outputs = {
    definition = {
      description         = ""
      display_name        = "Mock"
      id                  = "/providers/Microsoft.Management/managementGroups/${uuid()}/providers/Microsoft.Authorization/policyDefinitions/mock"
      management_group_id = "/providers/Microsoft.Management/managementGroups/${uuid()}"
      metadata            = ""
      mode                = "All"
      name                = "mock"
      parameters          = ""
      policy_rule         = ""
      policy_type         = "Custom"
      role_definition_ids = tolist([])
      timeouts            = {}
    }
  }
}

inputs = {
  definition = dependency.require_resource_group_tags.outputs.definition
}
