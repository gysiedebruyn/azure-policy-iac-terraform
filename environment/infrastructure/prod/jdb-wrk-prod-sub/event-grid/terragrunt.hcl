include {
  path = find_in_parent_folders()
}

dependency "function-app-PolicyMonitor" {
  config_path = "${get_parent_terragrunt_dir()}/infrastructure/prod/management-sub/function-app"
  mock_outputs = {
    function_id = "/subscriptions/${uuid()}/resourceGroups/rg-func/providers/Microsoft.Web/sites/fapp-func-name/functions/function_name"
  }
}

inputs = {
  function_id = dependency.function-app-PolicyMonitor.outputs.event_grid_function_id
}
