$AccessReport = @()
$Roles = Get-IAMAccountAuthorizationDetail -Filter Role
foreach($role in $Roles.RoleDetailList){
    $jobId = Request-IAMServiceLastAccessedDetail -Arn $role.Arn -Granularity ACTION_LEVEL # SERVICE_LEVEL
    Start-Sleep -Seconds 3
    $accessDetails = Get-IAMServiceLastAccessedDetail -JobId $jobId
    [string]$GroupList = $($role.InstanceProfileList -Join ";")
    foreach ($accessDetail in $accessDetails){
        if($accessDetail.ServicesLastAccessed.Count -GT 0){
        #$accessDetail.ServicesLastAccessed
            foreach($servicedetail in $accessDetail.ServicesLastAccessed){
                if($servicedetail.TrackedActionsLastAccessed.Count -GT 0){
                    #$servicedetail.TrackedActionsLastAccessed
                    $AccessReport += $servicedetail.TrackedActionsLastAccessed | Select-Object -Property @{label='Type'; expression={"Role"}}, `
                        @{label='Name'; expression={$role.RoleName}}, `
                        @{label='CreateDate'; expression={$role.CreateDate}} , `
                        @{label='IamId'; expression={$role.RoleId}}, `
                        @{label='Arn'; expression={$role.Arn}}, `
                        @{label='ServiceName'; expression={$servicedetail.ServiceName}}, `
                        ActionName, LastAccessedEntity, LastAccessedTime
                }
            }
        }
    }
}
$file = "./IamAccessReport-$($($(Get-Date).ToShortDateString()).Replace('/', '-')).csv"
$AccessReport | Export-Csv $file -NoTypeInformation
Write-Host "Download your report at: $file"