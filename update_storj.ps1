$count_nodes = 35   # Count nodes
$serv = 'storj'     # Name of services
$url = "https://github.com/storj/storj/releases/latest/download/storagenode_windows_amd64.zip"      # Address of the latest version
$download = "C:\storagenode_windows_amd64.zip"      # What address to download
$UnArchive = "C:\"                                  # To which address to unzip
$UnArchive_file = $UnArchive + "storagenode.exe"    # Full address of the unzipped file
$Address = "C:\Storj\nodes\Storj"                   # Address node
$i = 1                                              # Counter

Invoke-WebRequest $url -OutFile $download           # Download file 
echo "Download Latest"
Expand-Archive -Force $download $UnArchive          # Unzip file
echo "Complete UnArchive"

while ($i -ne $count_nodes) {                       # Stopping all nodes
    $serv_storj = $serv + $i.ToString()
    Set-Service $serv_storj -Status Stopped
    echo ("Storj " + $i + " Stopped")
    $i += 1
    sleep 1
}

$i = 1                                              # Resetting counter

while ($i -ne $count_nodes) {                       # Updating executive files
    $Address_full = $Address + $i.ToString() + "\Storage Node\"
    Copy-Item -Path $UnArchive_file -Destination $Address_full
    echo ("Storj " + $i + " update")
    $i += 1
}

$i = 1                                              # Resetting counter

while ($i -ne $count_nodes) {                       # Launching all nodes
    $serv_storj = $serv + $i.ToString()
    Set-Service $serv_storj -Status Running
    echo ("Storj " + $i + " Running")
    $i += 1
    sleep 1
}