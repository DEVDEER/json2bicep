[CmdletBinding()]
param (
	[Parameter(Mandatory = $true)]
	[string]
	[ValidateSet("prod")]
	$Stage,
	[switch]
	$WhatIf
)
# set parameter-dependend props
$tenantId = $env:TENANT_ID
$subscriptionId = $env:SUBSCRIPTION_ID
$templateFile = "$PSScriptRoot\main.bicep"
$templateParameterFile = "$PSScriptRoot\parameters\parameters.$($Stage.ToLowerInvariant()).json"

# deployment
if ($WhatIf.IsPresent) {
	Set-AzdSubscriptionContext -TenantId $tenantId -SubscriptionId $subscriptionId
	New-AzResourceGroupDeployment `
		-ResourceGroupName 'rg-jtb' `
		-TemplateFile $templateFile `
		-TemplateParameterFile $templateParameterFile `
		-Verbose `
		-WhatIf
}
else {
	New-AzdArmGroupDeployment -Stage $Stage `
		-TenantId $tenantId `
		-SubscriptionId $subscriptionId `
		-TemplateParameterFile $templateParameterFile `
		-DeploymentDebugLogLevel "All" `
		-TemplateFile $templateFile
}