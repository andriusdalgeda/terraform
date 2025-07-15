$rgName = "tf-state-rg"
$storageAccountName = "tfstateandrius1222"
$containerName = "tfstate"
$location = "uksouth"

try {
    az group create --name $rgName --location $location
    az storage account create --name tfstateandriusdal --location $location --resource-group $rgName

    $accountKey = (az storage account keys list --resource-group $rgName --account-name $storageAccountName --query '[0].value' -o tsv)

    az storage container create --name $containerName  --account-name $storageAccountName --account-key $accountKey --public-access off
}
catch {
    Write-Host $_.Exception
}

if (!($null -eq $accountKey)){
    write-host "Storage account name: $storageAccountName" -ForegroundColor Green
    write-host "Container name: $containerName" -ForegroundColor Green
    write-host "Access key: $accountKey" -ForegroundColor Green
}
else {
    Write-Host "Account key not found - an error occured" -ForegroundColor Red
}
