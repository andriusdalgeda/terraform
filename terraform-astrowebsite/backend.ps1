$rgName = ""
$storageAccountPrefix = ""
$containerName = ""
$location = ""

# adds random extension to prefix
$randomExtension = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 30 | ForEach-Object {[char]$_})
$storageAccountName = ($storageAccountPrefix + $randomExtension).ToLower()
$storageAccountName = $storageAccountName[0..23] -join ''

try {
    az group create --name $rgName --location $location

    # enables storage provider for new subscriptions
    az provider register --namespace Microsoft.Storage --wait
    
    az storage account create --name $storageAccountName --location $location --resource-group $rgName

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
