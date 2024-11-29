# Hostname'lerin bulunduğu dosya yolu
$hostnameListPath = "C:\Users\Hostname_ip_list.txt"

# Çözümlemesi başarılı olan ve başarısız olanların dosya yolları
$successfulOutputPath = "C:\Users\successful.txt"
$failedOutputPath = "C:\Users\failed.txt"

# Dosyaları temizle
Clear-Content $successfulOutputPath -ErrorAction SilentlyContinue
Clear-Content $failedOutputPath -ErrorAction SilentlyContinue

# Hostname'leri oku
$hostnames = Get-Content $hostnameListPath

# Hostname'leri döngüye al ve DNS çözümlemesini yap
foreach ($hostname in $hostnames) {
    Write-Host "Resolving $hostname..."
    $timestamp = Get-Date -Format "HH:mm dd.MM.yyyy"

    try {
        # DNS çözümlemesini yap ve IP adresini al
        $dnsResult = Resolve-DnsName -Name $hostname -ErrorAction Stop
        $ip = $dnsResult[0].IPAddress

        # IP adresine ping at
        $pingResult = Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue

        if ($pingResult) {
            $output = "$timestamp $hostname [$ip]"
            Write-Host "$output : Success" -ForegroundColor Green
            $output | Out-File -Append -FilePath $successfulOutputPath
        } else {
            $output = "$timestamp $hostname [Unknown]"
            Write-Host "$output : Failed" -ForegroundColor Red
            $output | Out-File -Append -FilePath $failedOutputPath
        }
    } catch {
        # Çözümleme başarısızsa Unknown olarak kaydet
        $output = "$timestamp $hostname [Unknown]"
        Write-Host "$output : Failed" -ForegroundColor Red
        $output | Out-File -Append -FilePath $failedOutputPath
    }
}

Write-Host "DNS çözümleme ve ping işlemi tamamlandı. Sonuçlar kaydedildi."
