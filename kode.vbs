Set oShell = CreateObject ("Wscript.Shell") 
Dim strArgs
strArgs = "cmd /c bin\kode.bat"
oShell.Run strArgs, 0, false