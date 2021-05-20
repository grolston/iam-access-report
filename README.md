# IAM Tools For AWS CloudShell

To leverage the project, open the AWS CloudShell and start up PowerShell by typing in `pwsh` then hitting enter. Output should looks as follows:

```sh
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
## dev branch
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/grolston/iam-access-report/dev/iamtools-services.ps1')
```

## Action-Level Granularity


The Action-Level granularity creates a report of AWS services and the service actions accessed by the IAM Role.

```powershell
## dev branch
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/grolston/iam-access-report/dev/iamtools.ps1')
```


## How To Download Report

Running the one-liners above will generate a csv report within your current working directory. The name of the report is written to the console immediately before the analysis is complete. Using the Actions button located in the top right of the CloudShell you can select `File > Download file` which you will need to either type or paste in the file name listed at the end of running the script.