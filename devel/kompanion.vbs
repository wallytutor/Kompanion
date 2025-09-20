Set objShell = CreateObject("Wscript.Shell")
Dim pShell, kommand

pShell = "powershell.exe -ExecutionPolicy Bypass -File "
kommand = "kompanion.ps1 -EnableLang"

objShell.Run pShell & kommand, 0, True
