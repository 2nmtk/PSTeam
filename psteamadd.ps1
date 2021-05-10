Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false 
	Filter = 'Cvs (*.csv)|*.csv'  
}

Function ConnectTeams {
  Connect-MicrosoftTeams -AccountId $UserID 
   $l=1
   $ConnectStatus = Get-Team -User $UserID | forEach-Object {New-Object psObject -Property @{‘Number ID’=$l;’Group-ID’= $_.GroupID; ‘Group-Name’ = $_.DisplayName};$l ++} | ft
   $NhomID = Get-Team -User $UserID | select -ExpandProperty GroupID
   $ConnectStatus
}
Function AddUser {
    [void]$FileBrowser.ShowDialog()
    $File = $FileBrowser.FileName;
        If($FileBrowser.FileNames -like "*\*") 
            {
            $FileBrowser.FileName 
            }
            else{
                Write-Host "Choose again"
                ChooseGroup
                 }
   $Addmember = Import-Csv -Path $FileBrowser.FileName | Foreach {Add-TeamUser -GroupId $NhomID[$n-1] -user $_.mail}
   $GroupStatus = Get-TeamUser -GroupId $NhomID[$n-1]
   $Addmember
   $GroupStatus
}
Function ChooseGroup {
$n = Read-Host -Prompt 'Choose Number ID'
if( $n -match "^[\d\.]+$" -And $n -le $NhomID.Count)
    {
    AddUser
    }
    Else 
    {
    Write-Host "Choose again"
    ChooseGroup
    }
}

$UserID = Read-Host -Prompt 'Enter your account name'
ConnectTeams
ChooseGroup
