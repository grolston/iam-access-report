IPMO AWSPowershell.NetCore
## Return WarningPref
$WarningPreference = $UserEnvWarningPref
$AccessReport = @()
$Granularity = 'SERVICE_LEVEL'
$Roles = Get-IAMAccountAuthorizationDetail -Filter Role
$RolesCount = $Roles.RoleDetailList.Count
$iterator = 1
write-host "Analyzing IAM Roles at $Granularity"
foreach($role in $Roles.RoleDetailList){
    $jobId = Request-IAMServiceLastAccessedDetail -Arn $role.Arn -Granularity $Granularity
    Start-Sleep -Seconds 3
    $accessDetails = Get-IAMServiceLastAccessedDetail -JobId $jobId
    write-host "Analyzing IAM Role $iterator of $RolesCount - $($role.RoleName)"
    foreach ($accessDetail in $accessDetails){
        if($accessDetail.ServicesLastAccessed.Count -GT 0){
            foreach($servicedetail in $accessDetail.ServicesLastAccessed){
              #$accessDetail this is the per report
              $AccessReport += $servicedetail | Select-Object -Property @{label='Type'; expression={"Role"}}, `
                  @{label='Name'; expression={$role.RoleName}}, `
                  @{label='CreateDate'; expression={$role.CreateDate}} , `
                  @{label='IamId'; expression={$role.RoleId}}, `
                  @{label='Arn'; expression={$role.Arn}}, `
                  ServiceName, LastAuthenticated, `
                  LastAuthenticatedEntity, LastAuthenticatedRegion, `
                  TotalAuthenticatedEntities
                }
            }
        }
        $iterator++
    }
$file = "./IamAccessReport-$Granularity-$($($(Get-Date).ToShortDateString()).Replace('/', '-')).csv"
$AccessReport | Export-Csv $file -NoTypeInformation
Write-Host "Download your report at: $file"