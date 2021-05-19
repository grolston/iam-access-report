# IAM Tools For AWS CloudShell

To leverage the project, open the AWS CloudShell and start up PowerShell by typing in `pwsh`. Output should looks as follows:

```bash
[cloudshell-user@ip-10-0-189-133 ~]$ pwsh
PowerShell 7.0.5
Copyright (c) Microsoft Corporation. All rights reserved.

https://aka.ms/powershell
Type 'help' to get help.

   A new PowerShell stable release is available: v7.1.3
   Upgrade now, or check out the release page at:
     https://aka.ms/PowerShell-Release?tag=v7.1.3

PS /home/cloudshell-user>
```

## Service-Level Granularity

The Service-Level granularity creates a report of AWS services accessed by the IAM Role.

```powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/grolston/iam-access-report/master/iamtools-services.ps1')
```

## Action-Level Granularity


The Action-Level granularity creates a report of AWS services and the service actions accessed by the IAM Role.

```powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/grolston/iam-access-report/master/iamtools.ps1')
```


