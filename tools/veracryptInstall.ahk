#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 1
SetControlDelay -1

upgradeVeraCrypt = 0

; This title is only used in the language selection window
winWizzardTitle := []
winWizzardTitle["en"] := "VeraCrypt Setup"
winWizzardTitle["de"] := "VeraCrypt-Einrichtungsassistent"
winWizzardTitle["fr"] := "Assistant d'installation de VeraCrypt"

winWizzardText := []
winWizzardText["en"] := "language"
winWizzardText["de"] := "Sprache"
winWizzardText["fr"] := "langue"

; Title for all other windows, maybe this is different in other languages?
winInstallTitle := []
winInstallTitle["en"] := "VeraCrypt Setup"
winInstallTitle["de"] := "VeraCrypt Setup"
winInstallTitle["fr"] := "VeraCrypt Setup"

; License window seems to be always in english
winLicenseText := []
winLicenseText["en"] := "Please read the license terms"
winLicenseText["de"] := "Please read the license terms"
winLicenseText["fr"] := "Please read the license terms"

winLicenseCheckBox := []
winLicenseCheckBox["en"] := "I &accept the license terms"
winLicenseCheckBox["de"] := "I &accept the license terms"
winLicenseCheckBox["fr"] := "I &accept the license terms"

winInstallTypeText := []
winInstallTypeText["en"] := "Wizard Mode"
winInstallTypeText["de"] := "Installationsassisten"
winInstallTypeText["fr"] := "Mode assistant"

winInstallOptionsText := []
winInstallOptionsText["en"] := "upgraded in the location"
winInstallOptionsText["de"] := "Geben Sie das Zielverzeichnis"
winInstallOptionsText["fr"] := "ou saisir l'emplacement"

winDonationText := []
winDonationText["en"] := "donation"
winDonationText["de"] := "Spende"
winDonationText["fr"] := "Veuillez envisager de faire un don"

; Restart window only apears on software update,
; and there is no language selection. thats why all english
winRestartText := []
winRestartText["en"] := "computer must be restarted"
winRestartText["de"] := "computer must be restarted"
winRestartText["fr"] := "computer must be restarted"

winHelpText := []
winHelpText["en"] := "If you have never used VeraCrypt before"
winHelpText["de"] := "Falls Sie VeraCrypt noch nie zuvor verwendet haben"
winHelpText["fr"] := "Si vous n'avez jamais utilis"

language = en
time := A_Now
time+= 60

findFirstWindow:
Loop
{
	; search for the language wizzard window
	; this only shows up on first install and is skiped if the software is already installed
	for key, value in winWizzardTitle
	{
		IfWinExist, %value%, % winWizzardText[key],,
		{
			language = %key%
			break findFirstWindow
		}
	}
	; search for the license window
	; if this is found, the setup will update the software
	; the language seems to be always english
	for key, value in winInstallTitle
	{
		IfWinExist, %value%, % winLicenseText[key],,
		{
			language = en
			upgradeVeraCrypt = 1
			break findFirstWindow
		}
	}
	Sleep, 100
	if (A_Now = time)
		break findFirstWindow
}


;MsgBox % "Language selection"
if (! upgradeVeraCrypt) {
	WinActivate, % winWizzardTitle[language],,,
	ControlClick, Button1, % winWizzardTitle[language],,,, NA
}


;MsgBox % "License terms"
WinWait, % winInstallTitle[language], % winLicenseText[language]
ControlClick, Button5, % winInstallTitle[language], % winLicenseText[language],,, NA
ControlClick, Button3, % winInstallTitle[language], % winLicenseText[language],,, NA


;MsgBox % "Type of install"
WinWait, % winInstallTitle[language], % winInstallTypeText[language], , 2
if !(ErrorLevel) {
	ControlClick, Button3, % winInstallTitle[language],,,, NA
}
Sleep, 200


;MsgBox % "Upgrade/Install"
WinWait, % winInstallTitle[language], % winInstallOptionsText[language],,
ControlClick, Button3, % winInstallTitle[language],,,, NA


;MsgBox % "Wait until the install process is finished"
WinWait, % winInstallTitle[language] " ahk_class #32770"
ControlClick, Button1, % winInstallTitle[language] " ahk_class #32770",,,, NA


;MsgBox % "Donation"
WinWait, % winInstallTitle[language], % winDonationText[language], , 10
if !(ErrorLevel) {
	Sleep, 200
	ControlClick, Button3, % winInstallTitle[language],,,, NA
}


;MsgBox % "If doing an upgrade you are prompted to restart"
if (upgradeVeraCrypt) {
	WinWait, % winInstallTitle[language], % winRestartText[language], , 2
	if !(ErrorLevel) {
		ControlClick, Button2, % winInstallTitle[language], % winRestartText[language],,, NA
	}
}
else {
	;MsgBox % "Help / manual suggestion"
	WinWait, % winInstallTitle[language], % winHelpText[language], , 2
	if !(ErrorLevel) {
		ControlClick, Button2, % winInstallTitle[language], % winHelpText[language],,, NA
	}
}
