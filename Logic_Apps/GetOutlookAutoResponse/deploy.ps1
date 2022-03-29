#Declare Variables
$templateFile = "$PSScriptRoot\LogicApp.json";
$templateParamFile ="$PSScriptRoot\LogicApp.parameters.json";
$jsonData = Get-Content -Path $templateParamFile | Out-String | ConvertFrom-Json;

#Get logic app name from JSON file.
$msiAppDisplayName = $jsonData.parameters.logicAppName.value;
$resourceGroupName = $jsonData.RGName.value;
$SubscriptionId = $jsonData.SubscriptionId.value;



# below SP needs contributor permission on the ResourceGroup.
$ClientID ="e7704560-2248-402c-9c36-d06ca148962d"
$Clientsecrets="5-qPKLU_.i33F1V~t99A23V~xg23~9r_DM"
$SubscriptionID="5d289cb6-1606-4976-a203-3d3f947c9af6"
$TenantID ="ba47b1c4-37b1-4301-b0d6-eca8ccf0818f"

#Login-ServicePrincipal

	$pass = ConvertTo-SecureString $Clientsecrets -AsPlainText -Force
	$cred = New-Object -TypeName pscredential -ArgumentList $ClientID, $pass

	Connect-AzAccount -Subscription $SubscriptionID -ServicePrincipal -Credential $cred -Tenant $TenantID -ErrorAction Stop

	New-AzResourceGroupDeployment -Name 'DeployGetOutlookAutoResponseLogicApp' -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -TemplateParameterFile $templateParamFile

