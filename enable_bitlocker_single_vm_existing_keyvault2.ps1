# enable_bitlocker_single_vm_existing_keyvault2
# 6/14/2019
# Josh Stallings
# from cloud shell, get the keyvault and encrypt the vm

# sign in vars
$azInstance = ''
$subscriptionId = ''


# cloud shell
Connect-AzAccount
Set-AzContext -SubscriptionId $subscriptionId

# rg vars
$rgName = ''
$location = ''

$vaultName = ''
Get-AzKeyVault -VaultName $vaultName

$VMRGName = $rgName; # in this case, VM rg was the same as the other

$vmName = ''

# encrypt vm
      
$KeyVault = Get-AzKeyVault -VaultName $vaultName -ResourceGroupName $rgName;
$diskEncryptionKeyVaultUrl = $KeyVault.VaultUri;
$KeyVaultResourceId = $KeyVault.ResourceId;
   
Set-AzVMDiskEncryptionExtension -ResourceGroupName $VMRGname -VMName $vmName -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl -DiskEncryptionKeyVaultId $KeyVaultResourceId;

