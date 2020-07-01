
Param(
    [string]$ResourceGroupName,
    [string]$VMName
    )

$ErrorActionPreference = "Stop"
$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName 
   "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 

    Start-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName
  
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
    } else{
        $ErrorMessage = $_.Exception.Message
    }
    throw $ErrorMessage
    #Write-Error -Message $ErrorMessage
   
} 
