@echo off
REM speedskating3d playtest. English-only, CRLF.
cd /d "%~dp0"
echo Starting Speed Skating 3D ...
if not exist "node_modules" call npm install
call npm run dev -- --open --port 5219
pause
