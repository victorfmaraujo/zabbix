Param(
  [string]$select
)

function get-CBBackupDataJob {
set-location "C:\Program Files\CloudBerryLab\CloudBerry Backup"
$jobdiscovery='C:\Zabbix\discovery.job.txt'
    #Coleta dados do Cloudberry puros
    (./cbb.exe plan -list)[2..9999] -replace('^[1-999]\.','') -replace('^ ','') -replace('^  ','') -replace("'",'') | Out-File $jobdiscovery -Force utf8
    $data=Get-Content -Path $jobdiscovery
    $count = ($data -match ('^Name:') -replace ('^Name: ','')).count
    $JobList=$data -match ('^Name:') -replace ('^Name: ','')  
    $JobIds=$data -match ('^ID:') -replace ('^ID: ','')  
    $JobResult=$data -match ('^Last Result:') -replace ('^Last Result: ','')
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

function get-CBBackupDataStorage {
set-location "C:\Program Files\CloudBerryLab\CloudBerry Backup"
$storagediscovery='C:\Zabbix\discovery.storage.txt'
    #Coleta dados do Cloudberry puros
    (./cbb.exe account -list)[2..999] -replace('[1-999]\. ','')  -replace('\. ',"`n") -replace("'",'') -replace(" Space","`nSpace") | out-file -FilePath $storagediscovery -Encoding utf8 -Force
    $data=Get-Content -Path $storagediscovery
    $count=(($data) -match('^Name:')).Length
    $StorageList=$data -match ('^Name:') -replace ('^Name: ','')        
    $StorageIDs=$data -match ('^ID:') -replace ('^ID: ','')  
    $StorageSpace=$data -match ('^Space') -replace ('^Space used: ','')    
    $List = New-Object -TypeName System.Collections.ArrayList
    for($i=0; $i -lt $count; $i++){
        $Obj = [PSCustomObject]@{
            "{#STORAGEID}" = $StorageIDs[$i]
            "{#STORAGENAME}" = $StorageList[$i]
            "{#STORAGESPACE}" = $StorageSpace[$i]
        }
        [void]$List.Add($Obj)
    }
    $List
}

if ($select -eq 'discovery.job') {
    get-CBBackupDataJob | convertto-json
    }if ($select -eq 'discovery.storage') {
    Write-Output "["
    get-CBBackupDataStorage | convertto-json
    Write-Output "]"
    }