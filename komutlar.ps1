Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" # autorun da neler var

Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 #şuan çalışan neler var

Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Cryptography\Providers\Trust\FinalPolicy" -Recurse # registry değerleri çekme

Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName  # makinede bulunan username

Get-FileHash -Algorithm SHA256 # hash hesaplama
