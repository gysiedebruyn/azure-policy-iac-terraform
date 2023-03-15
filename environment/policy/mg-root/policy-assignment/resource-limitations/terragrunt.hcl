terraform {
  source = "${get_repo_root()}/modules/policy-set-assignment//."
}

include {
  path = find_in_parent_folders()
}

dependency "assignment_resource_limitations" {
  config_path = "${get_parent_terragrunt_dir()}/policy/mg-root/policy-initiatives/resource-limitations"
  mock_outputs = {
    initiative = {
      description             = "Mock descriptiom."
      display_name            = "[Mock]: Mock"
      id                      = "/subscriptions/${uuid()}/providers/Microsoft.Authorization/policySetDefinitions/mock"
      management_group_id     = ""
      metadata                = "{}"
      name                    = "mock_${uuid()}"
      parameters              = "{}"
      policy_definition_group = toset([])
      policy_definition_reference = tolist([
        {
          parameter_values     = "{}"
          policy_definition_id = "/subscriptions/${uuid()}/providers/Microsoft.Authorization/policyDefinitions/mock"
          policy_group_names   = toset(null)
          reference_id         = "aa00a000a0000a00a000"
        },
      ])
      policy_type = "Custom"
      timeouts    = {}
    }
    role_definition_ids = [
      "/providers/microsoft.authorization/roleDefinitions/${uuid()}",
      "/providers/microsoft.authorization/roleDefinitions/${uuid()}",
    ]
  }
}

inputs = {
  initiative          = dependency.assignment_resource_limitations.outputs.initiative
  role_definition_ids = dependency.assignment_resource_limitations.outputs.role_definition_ids
}
