@call "%~dp0userenv"

@if "%~1" NEQ "" set MS_VSVC_ARCH=%~1
@set MS_VSVC_HOME=%ProgramFiles32%\Microsoft Visual Studio 12.0\VC
@if not exist "%MS_VSVC_HOME%\vcvarsall.bat" set MS_VSVC_HOME=
@if not defined MS_VSVC_HOME set MS_VSVC_HOME=%ProgramFiles32%\Microsoft Visual Studio 11.0\VC
@if not exist "%MS_VSVC_HOME%\vcvarsall.bat" set MS_VSVC_HOME=

@if not defined MS_VSVC_HOME goto :EOF
@set LIB=
@set LIBPATH=
@set INCLUDE=
@call "%MS_VSVC_HOME%\vcvarsall" %MS_VSVC_ARCH%
@if not exist "%AWE_DIR%" goto :EOF

@if defined LIB set LIB=%LIB%%AWE_DIR%build\lib
@if defined INCLUDE set INCLUDE=%INCLUDE%%AWE_DIR%include
