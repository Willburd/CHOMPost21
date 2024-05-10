@echo off
del .\tgui\public\tgui.bundle.js
call "%~dp0\tools\build\build.bat" --wait-on-error build %*
