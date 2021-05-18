if(!(Get-InstalledModule AWS.Tools.IdentityManagement)){Install-Module AWS.Tools.IdentityManagement -confirm:$false -force}
IPMO AWS.Tools.IdentityManagement
$AccessReport = @()
$Granularity = 'SERVICE_LEVEL'
$Roles = Get-IAMAccountAuthorizationDetail -Filter Role
foreach($role in $Roles.RoleDetailList){
    $jobId = Request-IAMServiceLastAccessedDetail -Arn $role.Arn -Granularity $Granularity
    Start-Sleep -Seconds 3
    $accessDetails = Get-IAMServiceLastAccessedDetail -JobId $jobId
    foreach ($accessDetail in $accessDetails){
        if($accessDetail.ServicesLastAccessed.Count -GT 0){

            foreach($servicedetail in $accessDetail.ServicesLastAccessed){
              #$accessDetail this is the per report
              $servicedetail
                # if($servicedetail.TrackedActionsLastAccessed.Count -GT 0){
                #     #$servicedetail.TrackedActionsLastAccessed
                #     # $AccessReport += $servicedetail.TrackedActionsLastAccessed | Select-Object -Property @{label='Type'; expression={"Role"}}, `
                #     #     @{label='Name'; expression={$role.RoleName}}, `
                #     #     @{label='CreateDate'; expression={$role.CreateDate}} , `
                #     #     @{label='IamId'; expression={$role.RoleId}}, `
                #     #     @{label='Arn'; expression={$role.Arn}}, `
                #     #     @{label='ServiceName'; expression={$servicedetail.ServiceName}}, `
                #     #     ActionName, LastAccessedEntity, LastAccessedTime
                # }
            }
        }
    }
}
$file = "./IamAccessReport-$Granularity-$($($(Get-Date).ToShortDateString()).Replace('/', '-')).csv"
$AccessReport | Export-Csv $file -NoTypeInformation
Write-Host "Download your report at: $file"