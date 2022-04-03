targetScope = 'subscription'

@description('The lower case name of the project as it appears in Azure DevOps.')
param projectName string

@description('The name of the stage with the first letter in upper-case (e.g. \'Test\' or \'Production\').')
param stage string

resource group 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-jtb'
  location: 'westeurope'
  tags: {
    purpose: 'production'
  }
}

module resources 'resources.bicep' = {
  name: 'resources'
  scope: group
  dependsOn: [
    group
  ]
  params: {
    projectName: projectName
    stage: stage
  }
}
