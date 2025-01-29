@echo off
%PYTHON_HOME%\Scripts\pip         ^
    --trusted-host pypi.org       ^
    --trusted-host files.pythonhosted.org %*
