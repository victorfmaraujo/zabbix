Param(
  [string]$a,
  [string]$b,
  [string]$c
  # $a seleciona se é job ou storage
  # $b ID do JOB
  # $c ID do Storage
)
if ($b -eq $null) {
    $b = "nothing"
    }

function get-CBBackupStatusDataJob {
set-location "C:\Program Files\CloudBerryLab\CloudBerry Backup"
    $jobdiscovery="C:\Zabbix\discovery.job.txt"
    $data=Get-Content -Path $jobdiscovery
    $count = ($data -match ('^Name:') -replace ('^Name: ','')).count
    $JobList=$data -match ('^Name:') -replace ('^Name: ','')  
    $JobIds=$data -match ('^ID:') -replace ('^ID: ','')  
    $JobResult=$data -match ('^Last Result:') -replace ('^Last Result: ','')
    #Transforma a string do resultado em Decimal
    $JobResult=$JobResult -replace ('Never started','0') -replace ('Falha','1') -replace ('Alerta','2') -replace ('Sucesso','3')
    $List = New-Object -TypeName System.Collections.ArrayList
    for($i=0; $i -lt $count; $i++){
        $Obj = [PSCustomObject]@{
            "{#JOBID}" = $JobIds[$i]
            "{#JOBNAME}" = $JobList[$i]
            "{#JOBRESULT}" = $JobResult[$i]
        }
        [void]$List.Add($Obj)
    }
    $List
}

function get-CBBackupStatusDataStorage {
    $storagediscovery="C:\Zabbix\discovery.storage.txt"
    $data=Get-Content -Path $storagediscovery
    $count = ($data -match ('^Name:') -replace ('^Name: ','')).count
    $StorageList=$data -match ('^Name:') -replace ('^Name: ','')  
    $StorageIds=$data -match ('^ID:') -replace ('^ID: ','')  
    $StorageSpace=$data -match ('^Space') -replace ('^Space Used: ','')

     $List = New-Object -TypeName System.Collections.ArrayList
     for($i=0; $i -lt $count; $i++){
        $Obj = [PSCustomObject]@{
            "{#STORAGEID}" = $StorageIds[$i]
            "{#STORAGENAME}" = $StorageList[$i]
            "{#STORAGESPACE}" = $StorageSpace[$i]
        }
        [void]$List.Add($Obj)
     }
    $List
} 

if ($a -eq "job") {
    $result=get-CBBackupStatusDataJob | Where-Object {$_."{#JOBID}" -eq $b} |select-object ("{#JOBRESULT}")
    $result.'{#JOBRESULT}'
        }
        if ($a -eq "storage") {
            $result=get-CBBackupStatusDataStorage | Where-Object {$_."{#STORAGEID}" -eq $c} | Select-Object '{#STORAGESPACE}'
            $result.'{#STORAGESPACE}'
        }