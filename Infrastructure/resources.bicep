targetScope = 'resourceGroup'

@description('The lower case name of the project as it appears in Azure DevOps.')
param projectName string

@description('The name of the stage with the first letter in upper-case (e.g. \'Test\' or \'Production\').')
param stage string

var options = {
  location: resourceGroup().location
  suffix: 'dbpz-${toLower(projectName)}-${toLower(stage)}'
  stageName: toLower(stage)
  logAnalyticsId: resourceId('42261c8d-1cdb-41e1-9934-5011fd19bc97', 'rg-monitoring', 'Microsoft.OperationalInsights/workspaces', 'log-dd-monitoring')
  defaultDiagnosticName: 'diag-default'
  defaultActionGroup: {
    name: 'agrp-default'
    subscriptionId: '42261c8d-1cdb-41e1-9934-5011fd19bc97'
    resourceGroup: 'rg-monitoring'
  }
}

module storage 'modules/Microsoft.Storage/storageAccounts.bicep' = {
  name: 'storage'
  params: {
    options: options
  }
}
