include {
  path = find_in_parent_folders()
}

inputs = {
  function_app_zip_path = "${get_repo_root()}/functions/PolicyMonitorComplianceState/PolicyMonitorComplianceState.zip"
}
