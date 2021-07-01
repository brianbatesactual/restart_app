
#$ServiceName = $args[0]

#$user = "<domain>\<user>"
#$pw = ConvertTo-SecureString -String "<password>" -AsPlainText -Force
#$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ($user, $pw)

#Enter-PSSession -ComputerName tablet -Credential $Cred

Push-Location -LiteralPath $PSScriptRoot

$ServiceName = 'uberAgentSvc'
$get = Get-Service -Name $ServiceName


function WriteLog($str1,$str2) {

        $tmp = Get-Service -Name $str1 | Select-Object -Property *      
        $tmp = (Get-Date).tostring("dd-MM-yyyy-hh-mm-ss ") + $tmp + $str2
        $tmp | Out-File -Append -FilePath .\SvcLog.txt
        
    } 

$msg = $get.status
WriteLog $ServiceName $msg

try {

    if($get.status -ne 'Running') {     

        Restart-Service -Name $ServiceName

        $msg = 'Service restarting'
        WriteLog $ServiceName $msg

        Start-Sleep -seconds 10
    
        $get = Get-Service -Name $ServiceName
        $msg = $get.Status
        WriteLog $ServiceName $msg
   
        }

    }

catch [System.OutOfMemoryException] {

    $msg = "PowerShell is out of memory"
    WriteLog 'Error' $msg

    }
   

finally {

    Pop-Location
    
    }

    #Exit-PSSession