function Something {
    param( $inp )

    Write-Output "Param input - $($inp)"

    switch ($inp) {
        1 {
            Write-Output "Switch case - 1"
        }
        2 {
            Write-Output "Switch case - 2"
        }
        Default {
            Write-Output "Default case "
        }
    }
}

function Set-DNS-Name {
    return "Google"
}

$Google = @{
    p = "8.8.8.8"
    p6 = "8.8.4.4"
}

[string]$User_DNS_Provider_Name = Set-DNS-Name 

$User_DNS_Provider = Get-Variable -Name $User_DNS_Provider_Name -ValueOnly

Write-Output "DNS Provider: $($User_DNS_Provider_Name)"
Write-Output "DNS Server: $($User_DNS_Provider.p), $($User_DNS_Provider.p6)"