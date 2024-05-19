param (
    [string]$ns = "kibo"
)

. ..\..\devops\powershell\kibo-util.ps1

Write-Output ("Test Self Signed Certificates")

$cert_name = "kibo-cert"

try {
    # Check cerificate is in ready state
    Get-ValidCertificateStatus -ns $ns -cert_name $cert_name
}
catch {
    Write-Error($_.Exception.Message)
}

