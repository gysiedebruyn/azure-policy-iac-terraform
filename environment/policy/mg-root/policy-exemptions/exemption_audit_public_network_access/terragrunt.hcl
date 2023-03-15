terraform {
  source = "${get_repo_root()}/modules/policy-exemption//."
}

include {
  path = find_in_parent_folders()
}

inputs = {}
