SET DIR=luxcorerender

:: Remove folder if it already exists
rd /s /q %DIR%

:: Create new folder for the binaries
md %DIR%

:: If we need Nvidia DLLs, set variable used in PyInstaller script
if "%1" EQU "/cuda" (
	set CUDA_DLLS=1
)

:: Pack pyluxcoretools
cd Build_CMake\LuxCore
PyInstaller ..\..\..\LuxCore\samples\pyluxcoretool\pyluxcoretool.win.spec
cd ..\..

:: Copy pyluxcoretools binaries
xcopy .\Build_CMake\LuxCore\dist\pyluxcoretool.exe %DIR%

:: Copy binaries
xcopy .\Build_CMake\LuxCore\bin\Release\luxcoreui.exe %DIR%
xcopy .\Build_CMake\LuxCore\lib\Release\pyluxcore.pyd %DIR%
xcopy .\Build_CMake\LuxCore\lib\pyluxcoretools.zip %DIR%

:: Copy DLLs from WindowsCompileDeps (assuming it is in same folder as WindowsCompile)
xcopy ..\WindowsCompileDeps\x64\Release\lib\OpenImageDenoise.dll %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\denoise.exe %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\embree3.dll %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\tbb.dll %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\tbbmalloc.dll %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\OpenImageIO.dll %DIR%

:: Copy CUDA redistributable files if needed
if "%CUDA_DLLS%" EQU "1" (
    xcopy "%CUDA_PATH%\bin\nvrtc64*.dll" %DIR%
    xcopy "%CUDA_PATH%\bin\nvrtc-builtins*.dll" %DIR%
)

:: Copy addition files from LuxCore (assuming it is in same folder as WindowsCompile)
xcopy ..\LuxCore\README.md %DIR%
xcopy ..\LuxCore\COPYING.txt %DIR%
xcopy ..\LuxCore\AUTHORS.txt %DIR%
md %DIR%\scenes
md %DIR%\scenes\cornell
xcopy ..\LuxCore\scenes\cornell\cornell.cfg %DIR%\scenes\cornell
xcopy ..\LuxCore\scenes\cornell\cornell.scn %DIR%\scenes\cornell
xcopy ..\LuxCore\scenes\cornell\Khaki.ply %DIR%\scenes\cornell
xcopy ..\LuxCore\scenes\cornell\HalveRed.ply %DIR%\scenes\cornell
xcopy ..\LuxCore\scenes\cornell\DarkGreen.ply %DIR%\scenes\cornell
xcopy ..\LuxCore\scenes\cornell\Grey.ply %DIR%\scenes\cornell
