<#

.NOTES
Title: EzDNS - Change DNS Easy Pesy
Author: Shrigiri / @Shrigiri81
version: 1.0

.SYNOPSIS
This script is a automatic DNS setter from choice of different DNS providers.
!!! Admin privileges are required

.DESCRIPTION
This script provides a easy and automatic way for setting DNS on Windows.
It uses General DNS options and the one recommended by Privacy Guides Project.

.LINK
Privacy Guides DNS Resolvers - https://www.privacyguides.org/en/dns/

.EXAMPLE
run as admin in powershell - ".\EzDNS.ps1"

#>

# ===========================================
# DNS Variables 

# Google DNS
$Google = @{
    # Legacy Resolvers
    primary = "8.8.8.8";
    alternate = "8.8.4.4";
    primary6 = "2001:4860:4860::8888";
    alternate6 = "2001:4860:4860::8844";

    # Secure Resovlers (To be implemented)
}

# Adguard DNS
$Adguard = @{
    Description = "Default Server - block ads and trackers."
    # Legacy Resolvers
    primary = "94.140.14.14";
    alternate = "94.140.15.15";
    primary6 = "2a10:50c0::ad1:ff";
    alternate6 = "2a10:50c0::ad2:ff";

    # Secure Resovlers (To be implemented)
}

# Cloudflare DNS
$Cloudflare = @{
    Description = "1.1.1.1 - Offers a fast and private way to browse."
    # Legacy Resolvers
    primary = "1.1.1.1";
    alternate = "1.0.0.1";
    primary6 = "2606:4700:4700::1111";
    alternate6 = "2606:4700:4700::1001";

    # Secure Resovlers (To be implemented)
}

# Mullvad DNS
$Mullvad = @{
    Description = @"
Mullvad - block ads, trackers and Malware*.
*Malware blocking is only on primary server, not on alternate server as Mullvad doesn't provide any alternate server.
"@
    # Legacy Resolvers
    primary = "194.242.2.4";
    alternate = "194.242.2.3";
    primary6 = "2a07:e340::4";
    alternate6 = "2a07:e340::3";

    # Secure Resovlers (To be implemented)
}

# Quad9 DNS
$Quad9 = @{
    Description = "Quad9 Recommended: Malware Blocking, DNSSEC Validation."
    # Legacy Resolvers
    primary = "9.9.9.9";
    alternate = "149.112.112.112";
    primary6 = "2620:fe::fe";
    alternate6 = "2620:fe::9";

    # Secure Resovlers (To be implemented)
}

# DNS0.EU - The European Public DNS
$DNSEU = @{
    Description = "Standard DNS without curation. Enhances internet security and privacy"
    # Legacy Resolvers
    primary = "193.110.81.0";
    alternate = "185.253.5.0";
    primary6 = "2a0f:fc80::";
    alternate6 = "2a0f:fc81::";

    # Secure Resovlers (To be implemented)
}

# Control D DNS
$ControlD = @{
    Description = "Blocks Ads and tracking + Malware"
    # Legacy Resolvers
    primary = "76.76.2.2";
    alternate = "76.76.10.2";
    primary6 = "2606:1a40::2";
    alternate6 = "2606:1a40:1::2";

    # Secure Resovlers (To be implemented)
}

# END / DNS Variables

# Assignment method for DNS Providers
function Set-DNS-Name {

    param( $assignNumber = 8 )

    switch($assignNumber) {
        1 { return "Google" }
        2 { return "Mullvad" }
        3 { return "Quad9" }
        4 { return "Cloudflare" }
        5 { return "Adguard" }
        6 { return "ControlD" }
        7 { return "DNS0.eu" }
        8 { return "Default/Automatic" }
        default { return "" }
    }
}

# ===========================================

# Set DNS Service method
function Set-DNS-Service {
    param (
        $DNSProvider,
        $DNSProviderName
    )

    # Clear terminal but display script banner-info
    Clear-Host
    Get-Script-Info

    # Output details of DNS to be set
    if($null -ne $DNSProvider) {
        # Output messages
        Write-Host "Setting DNS for provider: $($User_DNS_Provider_Name)" -ForegroundColor Blue
        Write-Host "DNS description: $($User_DNS_Provider.Description)" -ForegroundColor Yellow
        Write-Host "DNS Servers: "
        # IPv4
        Write-Host "IPv4: $($DNSProvider.primary), $($DNSProvider.alternate)"
        # IPv6
        Write-Host "IPv6: $($DNSProvider.primary6), $($DNSProvider.alternate6)"
    }

    # Setting DNS to current adaptor in use
    try {
        $Adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
        Write-Host "Setting DNS to $DNSProviderName on the following interfaces" -ForegroundColor Blue
        Write-Host $($Adapters | Out-String)

        Foreach ($Adapter in $Adapters) {
            if($null -eq $DNSProvider) {
                Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ResetServerAddresses
            } else {
                Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ServerAddresses ("$($DNSProvider.primary)", "$($DNSProvider.alternate)")
                Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ServerAddresses ("$($DNSProvider.primary6)", "$($DNSProvider.alternate6)")
            }
        }
    }
    catch {
        Write-Warning "Unable to set DNS Provider due to an unhandled exception" -ForegroundColor Red
        Write-Warning $psitem.Exception.StackTrace
    }
    Write-Host "DNS configured" -ForegroundColor Green
    # Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $DNS_Service

    Write-Host "To see the updated DNS configuration, press (Y/N)" -ForegroundColor Yellow
    if((Read-Host) -eq "Y") {
        # Confirm settings
        Get-Current-DNS-Info
    }
}

# Set DNS Provider Method
function Set-DNS-Provider {
    param(
        $DNS_Provider_ID
    )

    [string]$User_DNS_Provider_Name = Set-DNS-Name -assignNumber $DNS_Provider_ID
    
    if($DNS_Provider_ID -in 1..7) {
        $User_DNS_Provider = Get-Variable -Name $User_DNS_Provider_Name -ValueOnly
    }

    # Write-Host ""

    switch($DNS_Provider_ID) {
        1 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name # $Google
        }

        2 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name # Mullvad
        }

        3 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name # Quad9
        }

        4 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name # Cloudflare
        }

        5 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name #Adguard
        }

        6 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name # Control D
        }

        7 {
            # Set DNS servers
            Set-DNS-Service -DNSProvider $User_DNS_Provider -DNSProviderName $User_DNS_Provider_Name # DNS.EU
        }

        8 {
            Write-Host "Setting DNS for provider: $($User_DNS_Provider_Name)" -ForegroundColor Blue
            Write-Host "DNS description: Windows default/automatic DNS servers (DCHP)" -ForegroundColor Yellow
            
            # Set DNS servers
            Set-DNS-Service -DNSProvider $null
        }

        9 {
            # Write-Host "Showing current DNS configuration"
            Get-Current-DNS-Info # get details of current dns
        }

        default {
            Write-Host "Invalid Arguement. Enter the provider number (1-7)." -ForegroundColor Red
            break
        }
    }

    Write-Host "`nGoing back to main menu" -ForegroundColor Blue

}

# Get current DNS details method
function Get-Current-DNS-Info {
    # Clear terminal but display script banner-info
    Clear-Host
    Get-Script-Info

    $InterfaceAlias = (Get-NetAdapter | Where-Object {$_.Status -eq "Up"}).InterfaceAlias
    Write-Host "Current DNS configuration for $($InterfaceAlias): " -ForegroundColor Blue
    Get-DnsClientServerAddress -InterfaceAlias $InterfaceAlias
}

# Output DNS Menu method
function Get-DNS-Menu {
    # Method call to output welcome banner and some other info
    Get-Script-Info

    Write-Host "Choose from the following DNS Providers"
    Write-Host "1. Google"
    Write-Host "(Recommended*)" -ForegroundColor Yellow
    Write-Host "2. Mullvad"
    Write-Host "3. Quad9"
    Write-Host "4. Cloudflare"
    Write-Host "5. Adguard Public DNS"
    Write-Host "6. Control D Free DNS"
    Write-Host "7. DNS0.eu - The European public DNS"
    Write-Host "8. Windows Default/Automatic (DCHP)"
    Write-Host "9. View current DNS configuration"
    Write-Host "0 - Exit"
}

# Output EzDNS ASCII logo
function Get-EzDNS-Logo {
    $asciiArt = @"
EEEEEEEEEEEEE ZZZZZZZZZZZZ DDDDDDDDDD   NNNNNN    NNNNNN  SSSSSSSSSS
E:::::::::::E Z::::::::::Z D::::::::DD  N:::::N   N::::N S:::::::::S
EE::::EEE:::E ZZZZZZ:::::Z D:::::D:::D  N::::::N  N::::N S::::SSSSSS
  E:::E            Z::::Z   D::::D  D:D N:::::::N N::::N S::::S     
  E:::EEEEEE      Z::::Z    D::::D   D:D N:::N::::NN:::N S:::::SSSS 
  E:::EEEEEE     Z::::Z     D::::D   D:D N:::NN::::::::N  SS:::::::S
  E:::E         Z::::Z      D::::D   D:D N::::N::::::::N     SSS:::S
  E:::E        Z::::Z       D::::D  D:D  N::::NN:::::::N SS     S::S
EE::::EEE:::E Z::::::ZZZZZ D:::::DD::D   N::::N N::::::N S::SSSS::S 
E:::::::::::E Z::::::::::Z D::::::::D    N::::N  N:::::N S:::::::::S
EEEEEEEEEEEEE ZZZZZZZZZZZZ DDDDDDDDDD    NNNNNN   NNNNNN SSSSSSSSSS
"@

    Write-Host "$($asciiArt)" -ForegroundColor Cyan
}

# Output Script Details
function Get-Script-Info {
    # Print Banner
    # Write-Host "###############################"
    # Write-Host "#                             #"
    # Write-Host "#      EzDNS / Shrigiri81     #"
    # Write-Host "#                             #"
    # Write-Host "###############################"

    Get-EzDNS-Logo

    Write-Host "`n======================================"
    Write-Host "==== EzDNS - Change DNS Easy Pesy ===="
    Write-Host "======= by Shrigiri81 / v1.0 ========="
    Write-Host "======================================`n"

    Write-Host "*This script uses most DNS recommened by Privacy Guides Project." -ForegroundColor Yellow
    Write-Host "for more info visit https://www.privacyguides.org/en/dns/ `n" -ForegroundColor Yellow
}

# Wait 'n' Clear method
# waits for user confirmation and clears the console; Script Info & Banner Stays
function Wait-Clear-Console {
    # waits for user confirmation
    Write-Host "Press enter to continue..."
    Read-Host
    
    # clears the console
    Clear-Host 
}

function Get-Input {
    [bool]$noError = $false
    $parsedInp = 0;
    while(1) {
        Write-Host "Enter your prefered DNS: " -NoNewline -ForegroundColor Blue
        $inp = Read-Host
        if ([string]::IsNullOrWhiteSpace($inp)) {
            Write-Host "No option selected. Please choose one." -ForegroundColor Yellow
        } else {
            # Try to parse as integer
            if ([int]::TryParse($inp, [ref]$parsedInp)) {
                if($parsedInp -in 0..9) {
                    break
                }
                Write-Host "Invalid Argument. Please choose an option from the menu" -ForegroundColor Red
            }
            else {
                Write-Host "Invalid input. Please enter numbers only." -ForegroundColor Red
            }
            $noError = $true
        }
    }
    return [int]$parsedInp
}

#====================================#

# Main Entry

# Set PowerShell window title
$Host.UI.RawUI.WindowTitle = "EzDNS (Admin)"

# Variables
[bool]$isRunning = $true # Script running status

# Administrator check / Restart as admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "EzDNS needs to be run as Administrator. Relaunching script..." -ForegroundColor Blue

    $argList = @()

    $PSBoundParameters.GetEnumerator() | ForEach-Object {
        $argList += if ($_.Value -is [switch] -and $_.Value) {
            "-$($_.Key)"
        } elseif ($_.Value -is [array]) {
            "-$($_.Key) $($_.Value -join ',')"
        } elseif ($_.Value) {
            "-$($_.Key) '$($_.Value)'"
        }
    }

    $script = if ($PSCommandPath) {
        "& { & `'$($PSCommandPath)`' $($argList -join ' ') }"
    } else {
        "&([ScriptBlock]::Create((irm https://github.com/shrigiri81/EzDNS/releases/latest/download/EzDNS.ps1))) $($argList -join ' ')"
    }

    $powershellCmd = if (Get-Command pwsh -ErrorAction SilentlyContinue) { "pwsh" } else { "powershell" }
    $processCmd = if (Get-Command wt.exe -ErrorAction SilentlyContinue) { "wt.exe" } else { "$powershellCmd" }

    if ($processCmd -eq "wt.exe") {
        Start-Process $processCmd -ArgumentList "$powershellCmd -ExecutionPolicy Bypass -NoProfile -Command `"$script`"" -Verb RunAs
    } else {
        Start-Process $processCmd -ArgumentList "-ExecutionPolicy Bypass -NoProfile -Command `"$script`"" -Verb RunAs
    }

    break
}


while($isRunning) {
    Clear-Host

    # Method call to output DNS Menu
    Get-DNS-Menu
    $UserInput = Get-Input # call method to Reads user input

    # check for options led to related method calls
    if($userInput -eq 0) {
        Write-Host "Exiting script... Bye Bye" 
        exit # terminate the script
    }
    else {
        # method call for setting DNS service
        Set-DNS-Provider -DNS_Provider_ID $UserInput
        
        # method call to wait for user confirmation
        Wait-Clear-Console
    }
}