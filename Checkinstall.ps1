if (Get-InstalledModule -Name MicrosoftTeams -RequiredVersion 1.0.0) {
      Write-Host "OK"
  } 
  elseif (Get-InstalledModule -Name MicrosoftTeams) {
        Uninstall-Module -Name MicrosoftTeams
        Write-Host "Installing Module"
        Install-Module -Name MicrosoftTeams -RequiredVersion 1.0.0 -AllowClobber -Confirm:$False -Force
  }
  else {
      try {
          Write-Host "Installing Module"
          Install-Module -Name MicrosoftTeams -RequiredVersion 1.0.0 -AllowClobber -Confirm:$False -Force                
      }
      catch [Exception] {
          $_.message
          exit
      }
  }
