#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 1

winTitleInstall = VeraCrypt Setup

WinWait, %winTitleInstall%, , 300
WinActivate
BlockInput, Off

; License terms
ControlClick, I &accept the license terms, %winTitleInstall%,,,, NA
ControlClick, &Next >, %winTitleInstall%,,,, NA

; Type of install
ControlClick, &Next >, %winTitleInstall%,,,, NA

; Upgrade or Install
IfWinExist, %winTitleInstall%, upgraded in the location,,
	ControlClick, Upgrade, %winTitleInstall%,,,, NA
else
	ControlClick, &Install, %winTitleInstall%,,,, NA

; Wait until the install process is finished
WinWait, %winTitleInstall% ahk_class #32770
ControlClick, OK, %winTitleInstall%,,,, NA

; Donation
IfWinExist, %winTitleInstall%, VeraCrypt has been successfully
	ControlClick, &Finish, %winTitleInstall%

; Help / manual suggestion	
IfWinExist, %winTitleInstall%, If you have never used VeraCrypt before
	ControlClick, &No, %winTitleInstall%

; If doing an upgrade you are prompted to restart
IfWinExist, %winTitleInstall%, computer must be restarted
	ControlClick, &No, %winTitleInstall%