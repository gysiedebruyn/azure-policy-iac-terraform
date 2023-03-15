ENV_FILE_EXISTS = 0
# keep the Makefile clean of env variables and use a .env file instead
ifneq (,$(wildcard ./.env))
    include .env
    export
	ENV_FILE_EXISTS = 1
endif

MODULES := $(wildcard modules/*)

format: ## Format all the code and make it look pretty
	$(info --- "Formatting code")
	terragrunt hclfmt
	terraform fmt -recursive .
.PHONY: format

module-docs: ## Generate the Terraform documentation
	$(info --- Generating Terraform documentation)
	@for module in $(MODULES); \
		do echo "## $$PWD/$$module"; \
		terraform-docs markdown document --hide requirements --escape=false --sort-by required $$PWD/$$module > $$PWD/$$module/README.md; \
	done
.PHONY: module-docs

clean-tf:  ## Remove the .tf cache directories and files
	$(info --- Clean Terragrunt Cache)
	find . -type d -name ".terraform" -prune -exec rm -rf {} \;
	find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;
	find . -type f -name ".terraform.lock.hcl" -prune -exec rm -f {} \;
.PHONY: clean-tf

function-create-package: ## Compiles the provided function app
	$(info --- Creating the provided function deployment package)
	scripts/create-package-functionapp.sh
.PHONY: function-create-package

function-taint-tfstate: ## Taints the Function resources to ensure redeploy
	$(info --- Tainting Function state entries)
	terragrunt taint --terragrunt-working-dir environment/infrastructure/prod/management-sub/function-app null_resource.function_app_publish
.PHONY: function-taint-tfstate

function-deploy-function-source: ## Deploys the function source to Function App resource
	$(info --- Deploying the Function App source code)
	terragrunt run-all apply --terragrunt-non-interactive --terragrunt-working-dir environment/infrastructure/prod/management-sub/function-app
.PHONY: function-deploy-function-source

function-redeploy-function: ## Redeploys the Function source code
function-redeploy-function: function-create-package function-taint-tfstate function-deploy-function-source
.PHONY: function-redeploy-function

validate-all: ## Validates ALL the TF files and config
	$(info --- Validating all Terraform code and config)
	terragrunt run-all validate --terragrunt-non-interactive --terragrunt-working-dir environment
.PHONY: validate-all

validate-infra: ## Validates the Infrastructure TF files and config
	$(info --- Validating Infrastructure Terraform code and config)
	terragrunt run-all validate --terragrunt-non-interactive --terragrunt-working-dir environment/infrastructure
.PHONY: validate-infra

validate-policy: ## Validates the Policy TF files and config
	$(info --- Validating Policy Terraform code and config)
	terragrunt run-all validate --terragrunt-non-interactive --terragrunt-working-dir environment/policy
.PHONY: validate-policy

plan-all: ## Terraform plan
	$(info --- Running Terraform plan)
	terragrunt run-all plan --terragrunt-non-interactive --terragrunt-working-dir environment
.PHONY: plan-all

plan-infra: ## Plan the Infrastructure
	$(info --- Running Terraform plan on Infrastructure)
	terragrunt run-all plan --terragrunt-non-interactive --terragrunt-working-dir environment/infrastructure
.PHONY: plan-infra

plan-policy: ## Plan the Policy changes
	$(info --- Running Terraform plan on Policy)
	terragrunt run-all plan --terragrunt-non-interactive --terragrunt-working-dir environment/policy
.PHONY: plan-policy

apply-all: ## Terraform apply
	$(info --- Running Terraform apply)
	terragrunt run-all apply --terragrunt-non-interactive --terragrunt-working-dir environment
.PHONY: apply-all

apply-infra: ## Apply the Infrastructure
	$(info --- Running Terraform apply on Infrastructure)
	terragrunt run-all apply --terragrunt-non-interactive --terragrunt-working-dir environment/infrastructure
.PHONY: apply-infra

apply-policy: ## Apply the Policy changes
	$(info --- Running Terraform apply on Policy)
	terragrunt run-all apply --terragrunt-non-interactive --terragrunt-working-dir environment/policy
.PHONY: apply-policy

destroy-all: ## Terraform destroy
	$(info --- Running Terraform destroy)
	terragrunt run-all destroy --terragrunt-non-interactive --terragrunt-working-dir environment
.PHONY: destroy-all

destroy-infra: ## Destroy the Infrastructure
	$(info --- Running Terraform destroy on Infrastructure)
	terragrunt run-all destroy --terragrunt-non-interactive --terragrunt-working-dir environment/infrastructure
.PHONY: destroy-infra

destroy-policy: ## Destroy the Policy changes
	$(info --- Running Terraform destroy on Policy)
	terragrunt run-all destroy --terragrunt-non-interactive --terragrunt-working-dir environment/policy
.PHONY: destroy-policy

upgrade-tf: ## Upgrade all the TF Modules
	$(info --- Upgrading all Terraform Module versions)
	terragrunt run-all init -upgrade --terragrunt-non-interactive --terragrunt-working-dir environment
.PHONY: upgrade-tf

sp-login: ## Run az login for the SP
	$(info --- Running az login for the SP)
	@az login --service-principal --username ${ARM_CLIENT_ID} --password ${ARM_CLIENT_SECRET} --tenant ${ARM_TENANT_ID}
.PHONY: sp-login

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}'
.PHONY:help

.DEFAULT_GOAL := help
