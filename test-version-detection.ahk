; Test script for Windows version detection
; Run this to verify the version detection is working correctly

; Include the version detection functions
_GetWindowsVersion() {
    ; Get Windows version using registry
    RegRead, currentVersion, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion, CurrentVersion
    RegRead, currentBuild, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion, CurrentBuild
    
    ; Windows 11 starts from build 22000
    if (currentBuild >= 22000) {
        return "Windows 11"
    }
    ; Windows 10 builds are typically 10240 and above
    else if (currentBuild >= 10240) {
        return "Windows 10"
    }
    else {
        ; Fallback for older versions - assume Windows 10 for compatibility
        return "Windows 10"
    }
}

_GetVirtualDesktopAccessorDllPath(windowsVersion) {
    if (windowsVersion == "Windows 11") {
        return A_ScriptDir . "\libraries\virtual-desktop-accessor-win11.dll"
    }
    else {
        ; Default to Windows 10 DLL
        return A_ScriptDir . "\libraries\virtual-desktop-accessor.dll"
    }
}

; Test the detection
windowsVersion := _GetWindowsVersion()
dllPath := _GetVirtualDesktopAccessorDllPath(windowsVersion)

RegRead, currentBuild, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion, CurrentBuild

MsgBox, 0, Windows Version Detection Test, Detected Version: %windowsVersion%`nBuild Number: %currentBuild%`nDLL Path: %dllPath%`nDLL Exists: %FileExist(dllPath)%

ExitApp