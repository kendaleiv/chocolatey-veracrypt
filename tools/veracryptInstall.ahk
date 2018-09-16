#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 1
SetControlDelay -1

winTitleInstall = VeraCrypt Setup
upgradeVeraCrypt = 0

WinWait, %winTitleInstall%, , 300
WinActivate
; BlockInput, Off

; Language selection
ControlClick, OK, %winTitleInstall%,,,, NA

; License terms
WinWait, %winTitleInstall%, license
ControlClick, I &accept the license terms, %winTitleInstall%,,,, NA
ControlClick, &Next >, %winTitleInstall%,,,, NA

; Type of install
WinWait, %winTitleInstall%, Wizard Mode, , 2
if !(ErrorLevel) {
	ControlClick, &Next >, %winTitleInstall%,,,, NA
}

Sleep, 200

; Upgrade or Install
IfWinExist, %winTitleInstall%, upgraded in the location,,
{
	ControlClick, Upgrade, %winTitleInstall%,,,, NA
	upgradeVeraCrypt = 1
}
else
	ControlClick, &Install, %winTitleInstall%,,,, NA

; Wait until the install process is finished
WinWait, %winTitleInstall% ahk_class #32770
ControlClick, OK, %winTitleInstall%,,,, NA

; Donation
WinWait, %winTitleInstall%, donation, , 10
if !(ErrorLevel) {
	Sleep, 200
	ControlClick, &Finish, %winTitleInstall%,,,, NA
}

; If doing an upgrade you are prompted to restart
if (upgradeVeraCrypt) {
	WinWait, %winTitleInstall%, computer must be restarted, , 2
	if !(ErrorLevel) {
		ControlClick, &No, %winTitleInstall%,,,, NA
	}
}
else {
	; Help / manual suggestion	
	WinWait, %winTitleInstall%, If you have never used VeraCrypt before, , 2
	if !(ErrorLevel) {
		ControlClick, &No, %winTitleInstall%,,,, NA
	}
}
