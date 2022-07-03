param location string

@description('The SKU of App Service Plan')
param sku string = 'F1' // Free tier

var name = 'wordpress'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'app-service-plan-${name}'
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
}

resource webApp 'Microsoft.Web/sites@2021-03-01' = {
  name: '${name}-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'PHP|7.4'
    }
  }
}

resource webAppSourceControl 'Microsoft.Web/sites/sourcecontrols@2021-02-01' = {
  name: 'web'
  parent: webApp
  properties: {
    repoUrl: 'https://github.com/WordPress/WordPress'
    branch: '5.8-branch'
    isManualIntegration: true
  }
}
