$Roles = Get-IAMAccountAuthorizationDetail -Filter Role
foreach($role in $Roles.RoleDetailList){
    $jobId = Request-IAMServiceLastAccessedDetail -Arn $role.Arn -Granularity ACTION_LEVEL # SERVICE_LEVEL
    Start-Sleep -Seconds 5
    $accessDetails = Get-IAMServiceLastAccessedDetail -JobId $jobId
    [string]$GroupList = $($role.InstanceProfileList -Join ";")
    foreach ($accessDetail in $accessDetails){
        if($accessDetail.ServicesLastAccessed.Count -GT 0){
        $accessDetail.ServicesLastAccessed
        foreach($servicedetail in $accessDetail.ServicesLastAccessed){
            if($servicedetail.TrackedActionsLastAccessed.Count -GT 0){
                $servicedetail.TrackedActionsLastAccessed
            }
        #     # $accessDetails[1].ServicesLastAccessed | where -Property TotalAuthenticatedEntities -EQ 0
        #     #write-host $servicedetail
        #     # $AccessReport += $servicedetail | Select-Object -Property @{label='Type'; expression={"Role"}}, @{label='Name'; expression={$role.RoleName}}, `
        #     #     @{label='CreateDate'; expression={$role.CreateDate}} , @{label='IamId'; expression={$role.Id}}, `
        #     #     @{label='Groups'; expression={$GroupList}}, ServiceName, LastAuthenticated
        }
        }
    }
}