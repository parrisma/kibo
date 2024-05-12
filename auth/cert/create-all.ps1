param (
    [string]$ns = "kibo",
    [bool]$delete = $false,
    [bool]$apply = $false
)

. ..\..\devops\powershell\kibo-util.ps1

Write-Output ("Create & test Self Signed Certificates for Kibo on Local Machine")

$kube_secret_yaml = "kibo-selfsigned-cert-secret.yaml"
$secret_name = "kibo-selfsigned-cert-secret"
$kube_issuer_yaml = "kibo-selfsigned-cert-issuer.yaml"
$issuer_name = "kibo-selfsigned-cert-issuer"
$kube_cert_yaml = "kibo-selfsigned-cert.yaml"
$cert_name = "kibo-cert"

try {
    # Delete in reverse order
    Invoke-KubeObjectManagement -ns $ns -obj_name $cert_name -obj_type "cert" -kube_file $kube_cert_yaml -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $issuer_name -obj_type "issuer" -kube_file $kube_issuer_yaml -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $secret_name -obj_type "secret" -kube_file $kube_secret_yaml -delete $delete -apply $false

    # Create in order
    Invoke-KubeObjectManagement -ns $ns -obj_name $secret_name -obj_type "secret" -kube_file $kube_secret_yaml -delete $false -apply $apply
    Invoke-KubeObjectManagement -ns $ns -obj_name $issuer_name -obj_type "issuer" -kube_file $kube_issuer_yaml -delete $false -apply $apply
    Invoke-KubeObjectManagement -ns $ns -obj_name $cert_name -obj_type "cert" -kube_file $kube_cert_yaml -delete $false -apply $apply

    # Check all is OK
    Get-ValidCertificateStatus -ns $ns -cert_name $cert_name
}
catch {
    Write-Error($_.Exception.Message)
}

