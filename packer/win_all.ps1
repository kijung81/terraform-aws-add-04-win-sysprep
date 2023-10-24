# ec2 config 서비스 다운로드 설치
$Url = "https://s3.amazonaws.com/ec2-downloads-windows/EC2Config/EC2Install.zip"
$DownloadZipFile = "$env:USERPROFILE\Desktop\" + $(Split-Path -Path $Url -Leaf)
$ExtractPath = "$env:USERPROFILE\Desktop\"
Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
$ExtractShell = New-Object -ComObject Shell.Application 
$ExtractFiles = $ExtractShell.Namespace($DownloadZipFile).Items() 
$ExtractShell.NameSpace($ExtractPath).CopyHere($ExtractFiles)
Start-Process -FilePath "C:\Users\Administrator\Desktop\EC2Install.exe" -ArgumentList "/S" -Wait

# EC2config 서비스 정지
Stop-Service -Name "ec2config"

# ec2 service properties user data enable
$path = 'C:\Program Files\Amazon\Ec2ConfigService\Settings\config.xml'
$xml = [xml](Get-Content $path)
$state = $xml.Ec2ConfigurationSettings.Plugins.Plugin | where {$_.Name -eq 'Ec2HandleUserData'}
$state.State = 'Enabled'
$xml.Save($path)

# sysprep을 사용하여 셧다운수행
Start-Process -FilePath "C:\Program Files\Amazon\Ec2ConfigService\Ec2Config.exe" -ArgumentList "-sysprep -Wait"
