terraform {
  source = "${get_repo_root()}/modules/policy-definition//."
}

include {
  path = find_in_parent_folders()
}

inputs = {
  repo_root = get_repo_root()
}
