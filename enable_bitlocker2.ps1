# enable_bitlocker2
# 6/14/2019
# Josh Stallings
# create rg, key vault, enable encryption for each vm in that rg

# sign in vars
$azInstance = ''
$subscriptionId = ''

# sign in 
Connect-AzAccount
Get-AzSubscription
Set-AzContext -SubscriptionId $subscriptionId

# rg vars
$rgName = ''
$location = ''

New-AzResourceGroup –Name $rgName –Location $location

$vaultName = ''
New-AzKeyVault -VaultName $vaultName -ResourceGroupName $rgName -Location $location
Set-AzKeyVaultAccessPolicy -VaultName $vaultName -ResourceGroupName $rgName -EnabledForDiskEncryption
Set-AzKeyVaultAccessPolicy -VaultName $vaultName -ResourceGroupName $rgName -EnabledForTemplateDeployment

Install-Module -Name AzureRM -AllowClobber -Force # EDIT- don't switch

$VMRGName = $rgName; # in this case, VM rg was the same as the other
$vmName = Get-AzureRmVM -ResourceGroupName $rgName

foreach($vmName in $vmCollection) {

    $KeyVault = Get-AzKeyVault -VaultName $vaultName -ResourceGroupName $rgName;
    $diskEncryptionKeyVaultUrl = $KeyVault.VaultUri;
    $KeyVaultResourceId = $KeyVault.ResourceId;
    Set-AzVMDiskEncryptionExtension -ResourceGroupName $VMRGname -VMName $vmName.Name -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId;

}
