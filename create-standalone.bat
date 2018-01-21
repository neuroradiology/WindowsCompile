SET DIR=luxcorerender

:: Remove folder if it already exists
rd /s /q %DIR%

:: Create new folder for the binaries
md %DIR%

:: Create pyluxcoretools.zip (cmake tar doesn't work on Windows)
"C:\Program Files\7-Zip\7z.exe" a ..\LuxCore\lib\pyluxcoretools.zip ..\LuxCore\src\pyluxcoretools\pyluxcoretools

:: Pack pyluxcoretools
cd ..\LuxCore
pyinstaller samples\pyluxcoreconsole\pyluxcoreconsole.win.spec
pyinstaller samples\pyluxcoremerge\pyluxcoremerge.win.spec
pyinstaller samples\pyluxcorenetconsole\pyluxcorenetconsole.win.spec
pyinstaller samples\pyluxcorenetnode\pyluxcorenetnode.win.spec
cd ..\WindowsCompile

:: Copy pyluxcoretools binaries
xcopy ..\LuxCore\dist\pyluxcoreconsole.exe %DIR%
xcopy ..\LuxCore\dist\pyluxcoremerge.exe %DIR%
xcopy ..\LuxCore\dist\pyluxcorenetconsole.exe %DIR%
xcopy ..\LuxCore\dist\pyluxcorenetnode.exe %DIR%

:: Copy binaries
xcopy .\Build_CMake\LuxCore\bin\Release\luxcoreui.exe %DIR%
xcopy .\Build_CMake\LuxCore\lib\Release\pyluxcore.pyd %DIR%
xcopy ..\LuxCore\lib\pyluxcoretools.zip %DIR%

:: Copy DLLs from WindowsCompileDeps (assuming it is in same folder as WindowsCompile)
xcopy ..\WindowsCompileDeps\x64\Release\lib\embree.dll %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\tbb.dll %DIR%
xcopy ..\WindowsCompileDeps\x64\Release\lib\OpenImageIO.dll %DIR%

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
