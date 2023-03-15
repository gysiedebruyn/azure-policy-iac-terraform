/*
 * # Naming convention Module
 *
 * This modules aims to provide a consistent method of naming any resources created by in this solution
*/

locals {
  storage_account_length = length(var.sub) < 6 ? 14 : 20
}

output "standard" {
  description = "Return list of calculated standard names for deployment of Azure resources"
  value = {
    app-service-plan                           = lower("asp-${var.env}-${var.location-map[var.location]}-${var.sub}")
    application-insights                       = lower("ai-${var.env}-${var.location-map[var.location]}-${var.sub}")
    event-grid-system-topic                    = lower("egst-${var.env}-${var.location-map[var.location]}-${var.sub}")
    event-grid-system-topic-event-subscription = lower("egstes-${var.env}-${var.location-map[var.location]}-${var.sub}")
    event-hub                                  = lower("evh-${var.env}-${var.location-map[var.location]}-${var.sub}")
    event-hub-namespace                        = lower("evn-${var.env}-${var.location-map[var.location]}-${var.sub}")
    eventhub_namespace_authorization_rule      = lower("ehnar-${var.env}-${var.location-map[var.location]}-${var.sub}")
    function-app                               = lower("fapp-${var.env}-${var.location-map[var.location]}-${var.sub}")
    log-analytics-workspace                    = lower("law-${var.env}-${var.location-map[var.location]}-${var.sub}")
    monitor-alert                              = lower("monalert-${var.env}-${var.location-map[var.location]}-${var.sub}")
    resource-group                             = lower("rg-${var.env}-${var.location-map[var.location]}-${var.sub}")
    storage-account                            = lower("sa${var.env}${var.location-map[var.location]}${substr(md5("sa${var.env}${var.location-map[var.location]}${var.sub}"), 0, local.storage_account_length - length("sa${var.env}${var.location-map[var.location]}${var.sub}"))}${var.sub}") # only alpha numerics allowed in storage accounts
  }
}
