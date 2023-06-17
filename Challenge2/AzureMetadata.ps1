<#####################################################################

#Author :- Kapil M
Date - 9 -May -2021

Challenge:-  Write a program to retrieve Azure metadata in json format and additionally retrieve data element
value.


Description:- Following powersheell programi is written to retrive Azure metadata from API using bearer token 
and GET method. Following steps are followed.

1. Invoke powershell script by passiing parameters like TenantID , ClientID , ClientSecrete, apiurl (to retieve metadata)

2. function getBearer is called to  generate bearer token for API url to retrieve Azure metadata

3. function Call-API is called  by passing API url (having details of subscription, RG,DB server and database) 
to retrieve metadata of database using Azure API management url 

4. Retieved output of function Call-API is converted into json format and then retrieve database Name


######################################################################>


param
(
    [Parameter (Mandatory = $true)]
    [string] $TenantID,
	[Parameter (Mandatory = $true)]
    [string] $ClientID,
	[Parameter (Mandatory = $true)]
    [string] $ClientSecret,
	[Parameter (Mandatory = $true)]
    [string] $apiurl
	
	
)

$apiurl = "https://management.azure.com/subscriptions/11111-3333-ytru-iiii-vjjjs/resourceGroups/automation_rg1/providers/Microsoft.Sql/servers/automationdbsrvr1/databases/automationdb1?api-version=2020-08-01-preview" 
$TenantID = #######
$ClientID = ######
$ClientSecret=##########




function getBearer([string]$TenantID, [string]$ClientID, [string]$ClientSecret)
{
  $TokenEndpoint = "https://login.microsoftonline.com/$tenantId/oauth2/token" 
  $Resource = "https://management.azure.com";

  $Body = @{
          'resource'= $Resource
          'client_id' = $ClientID
          'grant_type' = 'client_credentials'
          'client_secret' = $ClientSecret
  }

  $params = @{
      ContentType = 'application/x-www-form-urlencoded'
      Headers = @{'accept'='application/json'}
      Body = $Body
      Method = 'Post'
      URI = $TokenEndpoint
  }

  $token = Invoke-RestMethod @params

  Return "Bearer " + ($token.access_token).ToString()
}



function Call-GetAPI([string]$apiUri,[string]$token)
{

    #headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers = @{}
    $headers.Add("Authorization", $token1)
    $headers.Add("Content-Type", "application/json")

    

    $response = Invoke-RestMethod -Method Get -Headers $headers -Uri $apiUri
    return $response

}





$token1 = getBearer -TenantID $TenantID, -ClientID $ClientID, -ClientSecret $ClientSecret
 
$response = Call-GetAPI -apiuri $apiurl -token $token1

$outputjson = $response | ConvertTo-Json -Depth 4

$mtdata = $outputjson | ConvertFrom-Json

$db_name = $mtdata.name

Write-Output ("Database name is -", $db_name)




