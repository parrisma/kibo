param (
    [string]$ns = "kibo",
    [bool]$delete = $true,
    [bool]$apply = $true,
    [bool]$ephemeral = $false
)

. ..\..\devops\powershell\kibo-util.ps1

Write-Output ("Create Keycloak supported by Postgress for Kibo on Local Machine")

$kibo_keycloak_postgress_secret = "kibo-keycloak-postgress-secret.yaml"
$kibo_keycloak_secret = "kibo-keycloak-secret.yaml"
$kibo_keycloak_persistent_volume = "kibo-keycloak-persistent-volume.yaml"
$kibo_keycloak_persistent_volume_claim = "kibo-keycloak-persistent-volume-claim.yaml"
$kibo_keycloak_postgres_ephemeral = "kibo-keycloak-postgres-ephemeral.yaml"
$kibo_keycloak_postgres_persisted = "kibo-keycloak-postgres-persisted.yaml"
$kibo_keycloak_postgress_service = "kibo_keycloak_postgress_service.yaml"
$kibo_keycloak_service = "kibo-keycloak-service.yaml"
$kibo_keycloak = "kibo-keycloak.yaml"
$kibo_keycloak_ingress = "kibo-keycloak-ingress.yaml"

$kibo_keycloak_postgress_secret_name = "postgres-credentials"
$kibo_keycloak_secret_name = "keycloak-secrets"
$kibo_keycloak_persistent_volume_name = "postgres-pv"
$kibo_keycloak_persistent_volume_claim_name = "postgres-pvc"
$kibo_keycloak_postgres_name = "postgres"
$kibo_keycloak_postgress_service_name = ""
$kibo_keycloak_service_name = ""
$kibo_keycloak_name = ""
$kibo_keycloak_ingress_name = ""

try {
    # Delete in reverse order
    Invoke-KubeObjectManagement -ns $ns -obj_name $XX -obj_type "Ingress" -kube_file $kibo_keycloak_ingress -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $XX -obj_type "Deployment" -kube_file $kibo_keycloak -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $XX -obj_type "Service" -kube_file $kibo_keycloak_service -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $XX -obj_type "Service" -kube_file $kibo_keycloak_postgress_service -delete $delete -apply $false
    if ($ephemeral) {
        Invoke-KubeObjectManagement -ns $ns -obj_name $kibo_keycloak_postgres_name -obj_type "Deployment" -kube_file $kibo_keycloak_postgres_ephemeral -delete $delete -apply $false
    } else {
        Invoke-KubeObjectManagement -ns $ns -obj_name $kibo_keycloak_postgres_name -obj_type "Deployment" -kube_file $kibo_keycloak_postgres_persisted -delete $delete -apply $false
    }
    Invoke-KubeObjectManagement -ns $ns -obj_name $kibo_keycloak_persistent_volume_claim_name -obj_type "PersistentVolumeClaim" -kube_file $kibo_keycloak_persistent_volume_claim -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $kibo_keycloak_persistent_volume_name -obj_type "PersistentVolume" -kube_file $kibo_keycloak_persistent_volume -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $kibo_keycloak_secret_name -obj_type "Secret" -kube_file $kibo_keycloak_secret -delete $delete -apply $false
    Invoke-KubeObjectManagement -ns $ns -obj_name $kibo_keycloak_postgress_secret_name -obj_type "Secret" -kube_file $kibo_keycloak_postgress_secret -delete $delete -apply $false
    
    # Create in order
    #Invoke-KubeObjectManagement -ns $ns -obj_name $secret_name -obj_type "secret" -kube_file $kube_secret_yaml -delete $false -apply $apply

    # Check all is OK
    #Get-ValidCertificateStatus -ns $ns -cert_name $cert_name
}
catch {
    Write-Error($_.Exception.Message)
}
