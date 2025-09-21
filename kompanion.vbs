Set objShell = CreateObject("Wscript.Shell")
Dim pShell, kommand

pShell = "powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
kommand = ". ./kompanion.ps1 -EnableFull; Kompanion-Launch"

objShell.Run pShell & kommand, 0, True
