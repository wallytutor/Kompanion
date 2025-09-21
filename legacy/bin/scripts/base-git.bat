@REM ****
@REM IMPORTANT: do not change the name of these variables! Using the
@REM same standard as the rest of the project will break PortableGit!
@REM ****

@REM Configure version (name of directory under apps/):
set THE_GIT_DIR=PortableGit

@REM Path to executables root:
set THE_GIT_HOME=%KOMPANION_APPS%\%THE_GIT_DIR%

@REM Add to path:
set PATH=%THE_GIT_HOME%\cmd;%PATH%
