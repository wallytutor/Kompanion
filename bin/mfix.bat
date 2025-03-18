@echo off

setlocal

set HERE=%~dp0apps\miniforge3

start /B %HERE%\python.exe   ^
    %HERE%\cwp.py            ^
    %HERE%\envs\mfix-24.4.1  ^
    %HERE%\envs\mfix-24.4.1\Scripts\mfix.exe

endlocal