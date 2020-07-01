 
Param
(
    [string]$Username,
    [string]$Password,
	[string]$Uri,
	[string]$RequestItemSysId,
	[string]$MethodType,
	[string]$Body
	
)



 $creds = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Username+':'+$Password))
 $combinedUrl = $Uri+'/'+$RequestItemSysId
  
 Invoke-WebRequest -Uri $combinedUrl -Method $MethodType -Headers @{ 'Authorization' = 'Basic ' +  $creds  }  -Body $Body
 
 
