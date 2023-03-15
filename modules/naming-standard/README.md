## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Required Inputs

The following input variables are required:

### <a name="input_env"></a> [env](#input_env)

Description: (Required) Environment for the deployment

Type: `string`

### <a name="input_location"></a> [location](#input_location)

Description: (Required) Location for the deployment

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location-map"></a> [location-map](#input_location-map)

Description: Azure location map used for naming abbreviations

Type: `map(any)`

Default:

```json
{
  "Australia Central": "cau",
  "Australia Central 2": "cau2",
  "Australia East": "eau",
  "Australia Southeast": "seau",
  "Brazil South": "sbr",
  "Canada Central": "cac",
  "Canada East": "eca",
  "Central India": "cin",
  "Central US": "cus",
  "East Asia": "eaa",
  "East US": "eus",
  "East US 2": "eus2",
  "France Central": "cfr",
  "France South": "sfr",
  "Germany North": "nge",
  "Germany West Central": "wcge",
  "Japan East": "eja",
  "Japan West": "wja",
  "Korea Central": "cko",
  "Korea South": "sko",
  "North Central US": "ncus",
  "North Europe": "eun",
  "South Africa North": "nsa",
  "South Africa West": "wsa",
  "South Central US": "scus",
  "South India": "sin",
  "Southeast Asia": "sea",
  "UAE Central": "cua",
  "UAE North": "nua",
  "UK South": "uks",
  "UK West": "ukw",
  "West Central US": "wcus",
  "West Europe": "euw",
  "West India": "win",
  "West US": "wus",
  "West US 2": "wus2",
  "australiacentral": "cau",
  "australiacentral2": "cau2",
  "australiaeast": "eau",
  "australiasoutheast": "seau",
  "brazilsouth": "sbr",
  "canadacentral": "cac",
  "canadaeast": "eca",
  "centralindia": "cin",
  "centralus": "cus",
  "eastasia": "eaa",
  "eastus": "eus",
  "eastus2": "eus2",
  "francecentral": "cfr",
  "francesouth": "sfr",
  "germanynorth": "nge",
  "germanywestcentral": "wcge",
  "global": "glbl",
  "japaneast": "eja",
  "japanwest": "wja",
  "koreacentral": "cko",
  "koreasouth": "sko",
  "northcentralus": "ncus",
  "northeurope": "eun",
  "southafricanorth": "nsa",
  "southafricawest": "wsa",
  "southcentralus": "scus",
  "southeastasia": "sea",
  "southindia": "sin",
  "uaecentral": "cua",
  "uaenorth": "nua",
  "uksouth": "uks",
  "ukwest": "ukw",
  "westcentralus": "wcus",
  "westeurope": "euw",
  "westindia": "win",
  "westus": "wus",
  "westus2": "wus2"
}
```

### <a name="input_sub"></a> [sub](#input_sub)

Description: (Optional) Subscription identifier where the resources are being deployed

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### <a name="output_standard"></a> [standard](#output_standard)

Description: Return list of calculated standard names for deployment of Azure resources
