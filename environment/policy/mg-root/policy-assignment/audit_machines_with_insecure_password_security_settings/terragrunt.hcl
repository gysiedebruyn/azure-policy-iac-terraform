terraform {
  source = "${get_repo_root()}/modules/policy-set-assignment//."
}

include {
  path = find_in_parent_folders()
}

dependency "audit_machines_with_insecure_password_security_settings" {
  config_path = "${get_parent_terragrunt_dir()}/policy/mg-root/policy-initiatives/audit_machines_with_insecure_password_security_settings"
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
        }
      ])
      policy_type = "Custom"
      timeouts    = {}
    }
  }
}

inputs = {
  # This built-in initiative does not expect an overall effect, set to null
  assignment_effect = ""
  initiative        = dependency.audit_machines_with_insecure_password_security_settings.outputs.initiative
}
