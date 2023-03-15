terraform {
  source = "${get_repo_root()}/modules/policy-initiative-builtin//."
}

include {
  path = find_in_parent_folders()
}

inputs = {}
