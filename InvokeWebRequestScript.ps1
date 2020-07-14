 
Param
(
    [string]$RequestItemSysId,
    [string]$jobName,
	[bool] $jobStatus,
    [string]$exceptionMessage
)

try
{

"Recevied REquest id is $RequestItemSysId"
 $creds = "c3lzdGVtLmF1dG9tYXRpb24uaGV4YUBoZXhhLm1haWwuY29tOkhleGFBdXRvQDIwMjAu"
 $Uri = "https://hexawaretechnologieshongkongltddemo5.service-now.com/api/now/table/sc_req_item"
 $MethodType="PUT"
 $combinedUrl = $Uri+'/'+$RequestItemSysId


if($jobStatus)
{ 
  $Body=  '{ "comments": "Request completed successfully",  "state": "3", "work_notes": "RunBook Executed Successfully"}'
 }
else
{
    $customObject = @{"work_notes" = $exceptionMessage; "state"= 2; "assignment_group" = "7f49d6581bbdd85029a0c95e0d4bcb26"}
    $Body = ConvertTo-Json -InputObject $customObject
 
}

$Body
Invoke-WebRequest -Uri $combinedUrl -UseBasicParsing -Method $MethodType -Headers @{ 'Authorization' = 'Basic ' +  $creds  }  -Body $Body


}
catch
{
     $ErrorMessage = $_.Exception.Message
     $ErrorMessage
     throw $ErrorMessage
}

 
