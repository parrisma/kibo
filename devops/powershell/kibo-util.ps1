function Get-ValidCertificate {
    param (
        [Parameter(Mandatory)][string] $ns, # The namespace to operate in
        [Parameter(Mandatory)][string] $cert_name # The name of the certificate to check status of
    )

    # Get the status of teh certificate
    $res = kubectl get cert $cert_name -o json -n $ns 2>$null | ConvertFrom-Json

    if ($res.status.conditions.status) {
        return ($res.status.conditions.status).equals("True")
    }
    else {
        # Dump ceritificate request details for debugging        
        Write-Error("Certificate [$cert_name] does not have True status, dumping certificate request details for debugging")
        kubectl describe certificaterequest 2>$null
        return $false
    }
}
function Get-ValidCertificateStatus {
    param (
        [Parameter(Mandatory)][string] $ns, # The namespace to operate in
        [Parameter(Mandatory)][string] $cert_name # The name of the certificate to check status of
    )

    if (!(Get-ValidCertificate -ns $ns -cert_name $cert_name)) {        
        throw ("Certificate [$cert_name] is created in namespace [$ns] but does not have True status, so not valid")
    }
    Write-Output("Certificate [$cert_name] is created in namespace [$ns] and has [True] status, so is valid")
}
function Get-KubeObjectExists {
    param (
        [Parameter(Mandatory)][string] $ns, # The namespace to operate in
        [Parameter(Mandatory)][string] $obj_name, # The name of the object to check exists
        [Parameter(Mandatory)][string] $obj_type # The type of the object to check exists
    )
    # Get details of Object
    $res = kubectl get $obj_type $obj_name -o json -n $ns 2>$null | ConvertFrom-Json
    if ($res.metadata.name) {
        return ($res.metadata.name).equals($obj_name)
    }
    else {
        return $false
    }
}
function Invoke-KubeObjectManagement {

    param (
        [Parameter(Mandatory)][string] $ns, # The namespace to operate in
        [Parameter(Mandatory)][string] $obj_name, # The name of the object to manage
        [Parameter(Mandatory)][string] $obj_type,
        [Parameter(Mandatory)][string] $kube_file, # The manifest file of the object to manage
        [bool] $delete = $false, # If true delete the existing objects in manifest to given namespace
        [bool] $apply = $false# If True apply the manifest file to given namespace
    )

    if (!(Test-Path $kube_file)) {
        throw ("[$kube_file] manifest file does not exist, so cannot manage object [$obj_name] in namespace [$ns]")  
    }

    if ($delete) {
        kubectl delete -f $kube_file -n $ns 2>&1>$null
        if (Get-KubeObjectExists -ns $ns -obj_name $obj_name -obj_type $obj_type) {
            throw ("Failed to delete [$obj_type] Object  [$obj_name] from namespace [$ns]")
        }
        Write-Output("Deleted [$obj_type] Object [$obj_name] from namespace [$ns] OK")
    }

    if ($apply) {
        kubectl apply -f $kube_file -n $ns 2>&1>$null
        if (-Not (Get-KubeObjectExists -ns $ns -obj_name $obj_name -obj_type $obj_type)) {
            throw ("Failed to create [$obj_type] Object  [$obj_name] in namespace [$ns]")
        }
        Write-Output("Applied [$obj_type] Object [$obj_name] in namespace [$ns] OK")
    }
}
