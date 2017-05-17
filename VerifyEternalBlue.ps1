<#
.SYNOPSIS
  Check if remote computers are patched against EternalBlue.

.DESCRIPTION
  EternalBlue is used as a propagation mechanism.
  Patching the system does not mean that it is protected against the encryption routine.
  However, it means that the system is protected against the "wormness" of recent WannaCry's variant.

.PARAMETER InputFile
  Path of the file containing hostnames to be checked for EternalBlue patch

.INPUTS
  [Optional] InputFile

.OUTPUTS
  Log file created

.NOTES
  Version:        0.1
  Author:         Cassius Puodzius
  Creation Date:  14/05/2017
  Purpose/Change: Initial script development
  
.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>
#>

Param (
  [Parameter(Mandatory=$True)][string]$InputFile,
  [Parameter(Mandatory=$False)][switch]$GetCredential)
  
#---------------------------------------------------------[Initializations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "SilentlyContinue"

# Get credential (if required so)
If($GetCredential) {
  $Credential = Get-Credential
}

# Get current Timestamp
$Timestamp = get-date -Format yMMddhhmmss

#Dot Source required Function Libraries
. .\Logging_Functions.ps1

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#List of KBs that patch EternalBlue
$KBList = (
  "KB4012212",
  "KB4012213",
  "KB4012214",
  "KB4012215",
  "KB4012216",
  "KB4012217",
  "KB4012598",
  "KB4012606",
  "KB4013198",
  "KB4013429"
)

#Script Version
$sScriptVersion = "0.1"
$sScriptName = "VerifyEternalBlue"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "$($sScriptName)_$($Timestamp).log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#-----------------------------------------------------------[Execution]------------------------------------------------------------

Log-Start -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion

If($InputFile) {
  $Hostnames = Get-Content $InputFile
}

#TODO: Implement Get-ADComputers -Computers

ForEach($Hostname in $Hostnames) {
  Write-Host "Checking connection to $Hostname..."

  If(-not (Test-Connection -ComputerName $Hostname)) {
      $LogMessage = "$Hostname is unreachable"
      Write-Host $LogMessage
      Log-Error -LogPath $sLogFile -ErrorDesc $LogMessage -ExitGracefully $False
      Continue
  }

  Write-Host "`tGetting HotFix list..."

  If($GetCredential) {
   $HotFixList = Get-HotFix -ComputerName $Hostname -Credential $Credential
  }
  Else {
    $HotFixList = Get-HotFix -ComputerName $Hostname
  }

  $Patched = $False
  ForEach($Entry in $HotFixList) {
    ForEach($KB in $KBList) {
      If($Entry -Like "*$KB*") {
        $Patched = $True
        Break
      }
      If($Patched) {
        Break
      }
    }
  }

  If($Patched) {
    $LogMessage = "`tComputer $Hostname is patched against EternalBlue ($KB)"
    Write-Host $LogMessage
    Log-Write -LogPath $sLogFile -LineValue $LogMessage
  }
  Else {
    $LogMessage = "`tComputer $Hostname is vulnerable to EternalBlue"
    Write-Host $LogMessage
    Log-Write -LogPath $sLogFile -LineValue $LogMessage
  }

}

Log-Finish -LogPath $sLogFile
Write-Host "Logfile created at $Logfile"