# C:\Storj\nodes\Storj1\Storage Node
# Copy-Item -Path "C:\SourceFolder\1.txt" -Destination "F:\DestFolder\1.txt"

$count_nodes = 35   # Количество нод
$serv = 'storj'     # Название служб
$url = "https://github.com/storj/storj/releases/latest/download/storagenode_windows_amd64.zip"      # Адрес последней версии
$download = "C:\storagenode_windows_amd64.zip"      # По какому адресу скачать
$UnArchive = "C:\"                                  # По какому адресу разархивировать
$UnArchive_file = $UnArchive + "storagenode.exe"    # Полный адрес разархивированного файла
$Address = "C:\Storj\nodes\Storj"                   # Адрес нод
$i = 1                                              # Счётчик

Invoke-WebRequest $url -OutFile $download           # Скачать файл
echo "Download Latest"
Expand-Archive -Force $download $UnArchive          # Разархивировать файл
echo "Complete UnArchive"

while ($i -ne $count_nodes) {                       # Останавливаем все ноды
    $serv_storj = $serv + $i.ToString()
    Set-Service $serv_storj -Status Stopped
    echo ("Storj " + $i + " Stopped")
    $i += 1
    sleep 1
}

$i = 1                                              # Сбрасываем счётчик

while ($i -ne $count_nodes) {                       # Обновляем исполнительные файлы
    $Address_full = $Address + $i.ToString() + "\Storage Node\"
    Copy-Item -Path $UnArchive_file -Destination $Address_full
    echo ("Storj " + $i + " update")
    $i += 1
}

$i = 1                                              # Сбрасываем счётчик

while ($i -ne $count_nodes) {                       # Запускаем все ноды
    $serv_storj = $serv + $i.ToString()
    Set-Service $serv_storj -Status Running
    echo ("Storj " + $i + " Running")
    $i += 1
    sleep 1
}