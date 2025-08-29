@echo off
setlocal EnableDelayedExpansion

:: Phiên bản
set Version=1.1

:: Tạo file log
echo ToiUuHeThong Log >ToiUu_Log.txt

:: Kiểm tra quyền Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [LOI] Vui long chay file batch nay voi quyen Administrator!
    echo Nhap chuot phai vao file va chon "Run as administrator".
    pause
    exit /b
)

:: Thiết lập giao diện console
title Toi Uu He Thong - Windows Performance Tweaker
color 0f
mode con: cols=80 lines=25

:: Hỏi tạo điểm khôi phục hệ thống
cls
echo ===============================================================================
echo                TOI UU HE THONG - v%Version%
echo ===============================================================================
echo Ban co muon tao diem khoi phuc he thong truoc khi tiep tuc khong?
echo.
echo 1. Co
echo 2. Khong
echo.
set /p choice="Nhap lua chon (1-2): "
if "%choice%"=="1" goto create_restore
if "%choice%"=="2" goto menu
echo Lua chon khong hop le! Mac dinh khong tao diem khoi phuc.
pause
goto menu

:create_restore
cls
echo ===============================================================================
echo                TAO DIEM KHOI PHUC HE THONG
echo ===============================================================================
echo Dang tao diem khoi phuc he thong...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "0" /f >> ToiUu_Log.txt
powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'ToiUuHeThong Restore Point' -RestorePointType 'MODIFY_SETTINGS'" >> ToiUu_Log.txt
if %errorlevel%==0 (
    echo [THANH CONG] Da tao diem khoi phuc he thong thanh cong!
) else (
    echo [LOI] Khong the tao diem khoi phuc he thong. Tiep tuc...
)
pause
goto menu

:menu
cls
echo ===============================================================================
echo                TOI UU HE THONG - v%Version%
echo ===============================================================================
echo Chao mung ban den voi cong cu toi uu hoa Windows!
echo Tac gia: supervisor
echo.
echo 1. Don dep file tam va bo nho dem
echo 2. Toi uu Registry
echo 3. Quan ly chuong trinh khoi dong
echo 4. Toi uu hieu suat
echo 5. Toi uu mang
echo 6. Toi uu choi game
echo 7. Loai bo ung dung khong can thiet
echo 8. Kiem tra va sua loi dia
echo 9. Khoi phuc cac thay doi
echo 10. Thoat
echo.
set /p choice="Nhap lua chon (1-10): "

if "%choice%"=="1" goto cleanup
if "%choice%"=="2" goto registry
if "%choice%"=="3" goto startup
if "%choice%"=="4" goto performance
if "%choice%"=="5" goto network
if "%choice%"=="6" goto gaming
if "%choice%"=="7" goto debloat
if "%choice%"=="8" goto diskcheck
if "%choice%"=="9" goto revert
if "%choice%"=="10" goto exit
echo Lua chon khong hop le! Vui long thu lai.
pause
goto menu

:cleanup
cls
echo ===============================================================================
echo                DON DEP FILE TAM VA BO NHO DEM
echo ===============================================================================
echo Dang don dep file tam, prefetch, thung rac va bo nho dem...
del /s /f /q "%temp%\*.*" >> ToiUu_Log.txt 2>&1
del /s /f /q "%windir%\Temp\*.*" >> ToiUu_Log.txt 2>&1
del /s /f /q "%windir%\Prefetch\*.*" >> ToiUu_Log.txt 2>&1
del /s /f /q "%systemdrive%\*.tmp" >> ToiUu_Log.txt 2>&1
del /s /f /q "%systemdrive%\*._mp" >> ToiUu_Log.txt 2>&1
del /s /f /q "%systemdrive%\*.log" >> ToiUu_Log.txt 2>&1
del /s /f /q "%systemdrive%\*.gid" >> ToiUu_Log.txt 2>&1
del /s /f /q "%systemdrive%\*.chk" >> ToiUu_Log.txt 2>&1
del /s /f /q "%systemdrive%\*.old" >> ToiUu_Log.txt 2>&1
rd /s /q "%systemdrive%\$Recycle.Bin" >> ToiUu_Log.txt 2>&1
del /s /f /q "%windir%\*.bak" >> ToiUu_Log.txt 2>&1
del /s /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >> ToiUu_Log.txt 2>&1
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255 >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da don dep file tam va bo nho dem thanh cong!
pause
goto menu

:registry
cls
echo ===============================================================================
echo                TOI UU REGISTRY
echo ===============================================================================
echo Dang sao luu Registry...
reg export HKLM "%userprofile%\Desktop\RegistryBackup_HKLM_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg" >> ToiUu_Log.txt 2>&1
reg export HKCU "%userprofile%\Desktop\RegistryBackup_HKCU_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg" >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Registry da duoc sao luu len Desktop!
echo Dang toi uu Registry...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >> ToiUu_Log.txt 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Registry da duoc toi uu thanh cong!
pause
goto menu

:startup
cls
echo ===============================================================================
echo                QUAN LY CHUONG TRINH KHOI DONG
echo ===============================================================================
echo Dang mo System Configuration de quan ly chuong trinh khoi dong...
msconfig
echo Sau khi dieu chinh, nhan OK de luu va tro ve menu.
pause
goto menu

:performance
cls
echo ===============================================================================
echo                TOI UU HIEU SUAT
echo ===============================================================================
echo Ban dang su dung Windows 10 hay Windows 11?
echo 1. Windows 10
echo 2. Windows 11
echo 3. Tro ve Menu
echo.
set /p perf_choice="Nhap lua chon (1-3): "
if "%perf_choice%"=="1" goto perf_win10
if "%perf_choice%"=="2" goto perf_win11
if "%perf_choice%"=="3" goto menu
echo Lua chon khong hop le!
pause
goto performance

:perf_win10
cls
echo ===============================================================================
echo                TOI UU HIEU SUAT - WINDOWS 10
echo ===============================================================================
echo Dang ap dung toi uu hieu suat cho Windows 10...
:: Tweak BCD
bcdedit /set useplatformclock No >> ToiUu_Log.txt 2>&1
bcdedit /set disabledynamictick Yes >> ToiUu_Log.txt 2>&1
bcdedit /set tscsyncpolicy Enhanced >> ToiUu_Log.txt 2>&1
bcdedit /set nx optout >> ToiUu_Log.txt 2>&1
:: Tat hieu ung hinh anh
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
:: Giam do tre menu
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Tat khoi dong nhanh
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Tat che do ngu dong
powercfg /h off >> ToiUu_Log.txt 2>&1
:: Tat nen bo nho
powershell -Command "Disable-MMAgent -MemoryCompression" >> ToiUu_Log.txt 2>&1
:: Bat bo dem lon
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
:: Tat Paging Executive
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
:: Thiet lap do uu tien Win32
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >> ToiUu_Log.txt 2>&1
:: Tweak NTFS
fsutil behavior set memoryusage 2 >> ToiUu_Log.txt 2>&1
fsutil behavior set mftzone 4 >> ToiUu_Log.txt 2>&1
fsutil behavior set disablelastaccess 1 >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da ap dung toi uu hieu suat cho Windows 10!
pause
goto menu

:perf_win11
cls
echo ===============================================================================
echo                TOI UU HIEU SUAT - WINDOWS 11
echo ===============================================================================
echo Dang ap dung toi uu hieu suat cho Windows 11...
:: Tweak BCD
bcdedit /set useplatformclock No >> ToiUu_Log.txt 2>&1
bcdedit /set disabledynamictick Yes >> ToiUu_Log.txt 2>&1
:: Tat cac che do bao mat
powershell "ForEach($v in (Get-Command -Name \"Set-ProcessMitigation\").Parameters[\"Disable\"].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString() -ErrorAction SilentlyContinue}" >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >> ToiUu_Log.txt 2>&1
:: Tat hieu ung hinh anh
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
:: Giam do tre menu
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Tat khoi dong nhanh
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Tat che do ngu dong
powercfg /h off >> ToiUu_Log.txt 2>&1
:: Tat nen bo nho
powershell -Command "Disable-MMAgent -MemoryCompression" >> ToiUu_Log.txt 2>&1
:: Bat bo dem lon
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
:: Tat Paging Executive
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
:: Thiet lap do uu tien Win32
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >> ToiUu_Log.txt 2>&1
:: Tweak NTFS
fsutil behavior set memoryusage 2 >> ToiUu_Log.txt 2>&1
fsutil behavior set mftzone 4 >> ToiUu_Log.txt 2>&1
fsutil behavior set disablelastaccess 1 >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da ap dung toi uu hieu suat cho Windows 11!
pause
goto menu

:network
cls
echo ===============================================================================
echo                TOI UU MANG
echo ===============================================================================
echo Dang ap dung toi uu mang...
:: Toi uu TCP
netsh int tcp set global autotuninglevel=normal >> ToiUu_Log.txt 2>&1
netsh int tcp set global congestionprovider=ctcp >> ToiUu_Log.txt 2>&1
:: Tat gioi han bang thong QoS
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Dat lai DNS ve DHCP
netsh interface ip set dns "Wi-Fi" dhcp >> ToiUu_Log.txt 2>&1
netsh interface ip set dns "Ethernet" dhcp >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da ap dung toi uu mang!
pause
goto menu

:gaming
cls
echo ===============================================================================
echo                TOI UU CHOI GAME
echo ===============================================================================
echo Dang ap dung toi uu choi game...
:: Bat che do Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
:: Tat Xbox Game DVR
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Toi uu do uu tien game
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /t REG_SZ /d True /f >> ToiUu_Log.txt 2>&1
:: Bat Hardware-Accelerated GPU Scheduling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da ap dung toi uu choi game!
pause
goto menu

:debloat
cls
echo ===============================================================================
echo                LOAI BO UNG DUNG KHONG CAN THIET
echo ===============================================================================
echo Lua chon loai bo ung dung:
echo 1. Xoa ung dung cai san
echo 2. Tat Cortana
echo 3. Tat dich vu khong can thiet
echo 4. Tat OneDrive
echo 5. Tro ve Menu
echo.
set /p debloat_choice="Nhap lua chon (1-5): "
if "%debloat_choice%"=="1" goto remove_apps
if "%debloat_choice%"=="2" goto disable_cortana
if "%debloat_choice%"=="3" goto disable_services
if "%debloat_choice%"=="4" goto disable_onedrive
if "%debloat_choice%"=="5" goto menu
echo Lua chon khong hop le!
pause
goto debloat

:remove_apps
cls
echo ===============================================================================
echo                XOA UNG DUNG CAI SAN
echo ===============================================================================
echo Dang xoa cac ung dung cai san khong can thiet...
powershell -Command "Get-AppxPackage -allusers *3DBuilder* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers *BingWeather* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers *Getstarted* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers *WindowsAlarms* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers *WindowsMaps* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers *WindowsFeedbackHub* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da xoa ung dung cai san!
pause
goto debloat

:disable_cortana
cls
echo ===============================================================================
echo                TAT CORTANA
echo ===============================================================================
echo Dang tat Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers *Microsoft.549981C3F5F10* | Remove-AppxPackage" >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da tat Cortana!
pause
goto debloat

:disable_services
cls
echo ===============================================================================
echo                TAT DICH VU KHONG CAN THIET
echo ===============================================================================
echo Dang tat cac dich vu khong can thiet...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v Start /t REG_DWORD /d 4 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v Start /t REG_DWORD /d 4 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 4 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v Start /t REG_DWORD /d 4 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da tat cac dich vu khong can thiet!
pause
goto debloat

:disable_onedrive
cls
echo ===============================================================================
echo                TAT ONEDRIVE
echo ===============================================================================
echo Dang tat OneDrive...
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" /UNINSTALL >> ToiUu_Log.txt 2>&1
rd "%USERPROFILE%\OneDrive" /q /s >> ToiUu_Log.txt 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /q /s >> ToiUu_Log.txt 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /q /s >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da tat OneDrive!
pause
goto debloat

:diskcheck
cls
echo ===============================================================================
echo                KIEM TRA VA SUA LOI DIA
echo ===============================================================================
echo Dang kiem tra va sua loi dia C:...
chkdsk C: /f
echo Ban co muon len lich kiem tra dia khi khoi dong lai khong? (Y/N)
set /p disk_choice="Nhap lua chon (Y/N): "
if /i "%disk_choice%"=="Y" (
    echo y | chkdsk C: /f /r >> ToiUu_Log.txt 2>&1
    echo [THANH CONG] Da len lich kiem tra dia cho lan khoi dong tiep theo!
) else (
    echo [THONG TIN] Khong len lich kiem tra dia.
)
pause
goto menu

:revert
cls
echo ===============================================================================
echo                KHOI PHUC CAC THAY DOI
echo ===============================================================================
echo Lua chon khoi phuc:
echo 1. Khoi phuc Registry tu ban sao luu
echo 2. Bat lai dich vu bi tat
echo 3. Bat lai Cortana
echo 4. Bat lai OneDrive
echo 5. Cai lai ung dung cai san
echo 6. Khoi phuc tat ca thiet lap toi uu
echo 7. Tro ve Menu
echo.
set /p revert_choice="Nhap lua chon (1-7): "
if "%revert_choice%"=="1" goto revert_registry
if "%revert_choice%"=="2" goto revert_services
if "%revert_choice%"=="3" goto revert_cortana
if "%revert_choice%"=="4" goto revert_onedrive
if "%revert_choice%"=="5" goto revert_apps
if "%revert_choice%"=="6" goto revert_all
if "%revert_choice%"=="7" goto menu
echo Lua chon khong hop le!
pause
goto revert

:revert_registry
cls
echo ===============================================================================
echo                KHOI PHUC REGISTRY
echo ===============================================================================
echo Dang tim ban sao luu Registry tren Desktop...
set "backup_found=0"
for %%F in ("%userprofile%\Desktop\RegistryBackup_*.reg") do (
    set "backup_found=1"
    echo Tim thay: %%F
    set /p reg_choice="Ban co muon khoi phuc tu file nay khong? (Y/N): "
    if /i "!reg_choice!"=="Y" (
        reg import "%%F" >> ToiUu_Log.txt 2>&1
        if !errorlevel!==0 (
            echo [THANH CONG] Da khoi phuc Registry tu %%F!
        ) else (
            echo [LOI] Khong the khoi phuc Registry tu %%F.
        )
        pause
    )
)
if "!backup_found!"=="0" (
    echo [LOI] Khong tim thay ban sao luu Registry tren Desktop!
)
pause
goto revert

:revert_services
cls
echo ===============================================================================
echo                BAT LAI DICH VU
echo ===============================================================================
echo Dang bat lai cac dich vu bi tat...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v Start /t REG_DWORD /d 3 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v Start /t REG_DWORD /d 3 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v Start /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da bat lai cac dich vu!
pause
goto revert

:revert_cortana
cls
echo ===============================================================================
echo                BAT LAI CORTANA
echo ===============================================================================
echo Dang bat lai Cortana...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /f >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da bat lai Cortana! Vui long cai lai ung dung Cortana tu Microsoft Store neu can.
pause
goto revert

:revert_onedrive
cls
echo ===============================================================================
echo                BAT LAI ONEDRIVE
echo ===============================================================================
echo Dang bat lai OneDrive...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /f >> ToiUu_Log.txt 2>&1
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da bat lai OneDrive! Neu OneDrive khong khoi dong, vui long cai lai tu Microsoft Store.
pause
goto revert

:revert_apps
cls
echo ===============================================================================
echo                CAI LAI UNG DUNG CAI SAN
echo ===============================================================================
echo Dang cai lai cac ung dung cai san...
powershell -Command "Get-AppxPackage -allusers Microsoft.3DBuilder | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.BingWeather | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.Getstarted | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.WindowsAlarms | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.WindowsMaps | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.WindowsFeedbackHub | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da cai lai cac ung dung cai san! Neu co loi, vui long cai lai tu Microsoft Store.
pause
goto revert

:revert_all
cls
echo ===============================================================================
echo                KHOI PHUC TAT CA THIET LAP TOI UU
echo ===============================================================================
echo Dang khoi phuc tat ca thiet lap toi uu...
:: Khoi phuc BCD
bcdedit /deletevalue useplatformclock >> ToiUu_Log.txt 2>&1
bcdedit /deletevalue disabledynamictick >> ToiUu_Log.txt 2>&1
bcdedit /deletevalue tscsyncpolicy >> ToiUu_Log.txt 2>&1
bcdedit /deletevalue nx >> ToiUu_Log.txt 2>&1
:: Khoi phuc hieu ung hinh anh
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc do tre menu
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 400 /f >> ToiUu_Log.txt 2>&1
:: Bat lai khoi dong nhanh
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
:: Bat che do ngu dong
powercfg /h on >> ToiUu_Log.txt 2>&1
:: Bat nen bo nho
powershell -Command "Enable-MMAgent -MemoryCompression" >> ToiUu_Log.txt 2>&1
:: Tat bo dem lon
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Bat Paging Executive
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 0 /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc do uu tien Win32
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc NTFS
fsutil behavior set memoryusage 1 >> ToiUu_Log.txt 2>&1
fsutil behavior set mftzone 1 >> ToiUu_Log.txt 2>&1
fsutil behavior set disablelastaccess 0 >> ToiUu_Log.txt 2>&1
:: Khoi phuc mang
netsh int tcp set global autotuninglevel=disabled >> ToiUu_Log.txt 2>&1
netsh int tcp set global congestionprovider=none >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc game
reg delete "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /f >> ToiUu_Log.txt 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /f >> ToiUu_Log.txt 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Latency Sensitive" /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc Windows 11 mitigations
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc dich vu
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v Start /t REG_DWORD /d 3 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpcMonSvc" /v Start /t REG_DWORD /d 3 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\MapsBroker" /v Start /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v Start /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 2 /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc Cortana
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >> ToiUu_Log.txt 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /f >> ToiUu_Log.txt 2>&1
:: Khoi phuc OneDrive
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /f >> ToiUu_Log.txt 2>&1
start /wait "" "%SYSTEMROOT%\SYSWOW64\ONEDRIVESETUP.EXE" >> ToiUu_Log.txt 2>&1
:: Cai lai ung dung
powershell -Command "Get-AppxPackage -allusers Microsoft.3DBuilder | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.BingWeather | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.Getstarted | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.WindowsAlarms | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.WindowsMaps | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
powershell -Command "Get-AppxPackage -allusers Microsoft.WindowsFeedbackHub | Add-AppxPackage -Register -DisableDevelopmentMode" >> ToiUu_Log.txt 2>&1
echo [THANH CONG] Da khoi phuc tat ca thiet lap toi uu!
echo Neu co loi voi ung dung, vui long cai lai tu Microsoft Store.
echo Vui long khoi phuc Registry tu ban sao luu rieng biet neu can.
pause
goto revert

:exit
cls
echo ===============================================================================
echo                CAM ON BAN DA SU DUNG TOI UU HE THONG
echo ===============================================================================
echo Nhan phim bat ky de thoat...
pause >nul
exit