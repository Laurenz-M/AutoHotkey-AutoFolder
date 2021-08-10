global DefaultLanguage:="Deutsch"
global SetLanguage:=DefaultLanguage

global NumberOfPagesMin:=1
global NumberOfPagesMax:=4
global NumberOfPagesCurrently:=NumberOfPagesMin

global InitializedBefore:=[]
LoopVar:=1
loop, %NumberOfPagesMax% {
    InitializedBefore%LoopVar% := 0
    InitializedBefore.Push(InitializedBefore%LoopVar%)
    LoopVar++
}

;==============================Arrays=================================================

global Deutsch:=["AutoFolder.ahk installierung", "Bitte wähle die Installationssprache.","Weiter > "," < Zurück","Installieren", "Fertigstellen", "Ich akzeptiere die Vereinbarung.", "Ich lehne die Vereinbarung ab.", "Durchsuchen", "Das Programm wird installiert in","Nach Installation ausführen?","Desktop-Verknüpfung hinzufügen?","ReadMe öffnen?","Installation abbrechen?","Ja","Nein","Bist du sicher, dass du die Installation abbrechen willst?"]
global English:=["AutoFolder.ahk installer","Please select the language of your installation.","Next >", " < Previous", "Install", "Finish", "I accept the agreement.","I decline the agreement.", "Browse", "The program will be installed at","Run after install?","Add desktop icon?","Open ReadMe?","Cancel installation?","Yes","No","Are you sure that you want to cancel the installation?"]
global Français:=[]
global PossibleLanguage:=["English","Deutsch"] ;,"Français"]
global ControlsAllPages:=[]

;==================Main calling of functions================================


;Goto, ButtonInstall
;Return

Gui 1:new, hwndGui1
Gui 1:show, w350 h450, % %SetLanguage%[1]
Page%NumberOfPagesCurrently%()
UiElements()
return

;===============================================

Page1(){
    global ButtonPrevious
    global ButtonNext
	LanguageArray()
	if(InitializedBefore[1]=0){
		Gui 1:add, DropDownList, x15 y15 vLanguageOption gLanguageOption hwndDDL1, % PossibleLanguage[1] "|" PossibleLanguage[2] "|" PossibleLanguage[3]
		global LanguageOption
        Gui 1:add, Text, x15 y40 w100000 hwndControlText1, % %SetLanguage%[2]
		global ControlText1
		GuiControl, ChooseString, %DDL1%, %SetLanguage%
		Gui 1:submit, NoHide

			global ControlsPage1:=[ControlText1,DDL1]  ;ButtonNext,ButtonPrevious,

			loop, % ControlsPage1.Count() {
				ControlsAllPages.Push(ControlsPage1[A_Index])
			}
			InitializedBefore[1] := 1
	}
	else{

		loop, % ControlsPage1.Count() {
			ControlsAllPages.Push(ControlsPage1[A_Index])
		}
		loop, % ControlsPage1.Count(){
			GuiControl, show, % ControlsPage1[A_Index]
			GuiControl, enable, % ControlsPage1[A_Index]
		}
	}

        Gui 1:show, w350 h450, % %SetLanguage%[1]


    return


LanguageOption:
	Gui 1:submit, NoHide
	SetLanguage:=LanguageOption
	ControlSetText, , % %SetLanguage%[2], % "ahk_id " ControlText1
	WinGetTitle, TitleGui1, %Gui1%  
	WinSetTitle, %TitleGui1%,, % %SetLanguage%[1]
	ControlSetText, , % %SetLanguage%[3], % "ahk_id " ButtonNext
	ControlSetText, , % %SetLanguage%[4], % "ahk_id " ButtonPrevious
	Gui 1:submit, NoHide
    return
}

;===================================================

Page2(){
	global ButtonNext
	LanguageArray()
	if(InitializedBefore[2]=0){
		Gui 1:add, Edit, r9 vConditionsOfUseEdit x30 y30 w135 hwndConditionsEdit ReadOnly, Text
		global ConditionsOfUseEdit
		;MsgBox, % %SetLanguage%[7]
		Gui 1:add, Radio, x30 y180 w100000 vAcceptRadioVar gRadioGroupLabel hwndAcceptRadio, % %SetLanguage%[7]
		global AcceptRadio
		global AcceptRadioVar
		Gui 1:add, Radio, x30 y210 w100000 vDeclineRadioVar gRadioGroupLabel hwndDeclineRadio, % %SetLanguage%[8]
		global DeclineRadio
		global DeclineRadioVar
		Gui 1:submit, NoHide

		global ControlsPage2:=[ConditionsEdit,DeclineRadio,AcceptRadio]

		loop, % ControlsPage2.Count() {
			ControlsAllPages.Push(ControlsPage2[A_Index])
		}
		InitializedBefore[2] := 1
	}
	else{

		loop, % ControlsPage2.Count() {
			ControlsAllPages.Push(ControlsPage2[A_Index])
		}
		loop, % ControlsPage2.Count() {
			GuiControl, show, % ControlsPage2[A_Index]
			GuiControl, enable, % ControlsPage2[A_Index]
		}
	}

    Gui 1:show, w300 h400, % %SetLanguage%[1]
	;MsgBox, %AcceptRadio% , %SetLanguage%
	ControlSetText,, % %SetLanguage%[7], % " ahk_id" AcceptRadio
	ControlSetText,, % %SetLanguage%[8], % " ahk_id" DeclineRadio
    GuiControl, disable, %ButtonNext%
    GoSub, RadioGroupLabel
return

	RadioGroupLabel:
    	Gui 1:submit, NoHide
		if(AcceptRadioVar=1){
			GuiControl, enable, %ButtonNext%
		}
		else{
			GuiControl, disable, %ButtonNext%
		}
    return
}

Page3(){
    global InstallPath
	global InstallPathOriginalSetting
	LanguageArray()
	if(InitializedBefore[3]=0){
		InstallPath:=A_MyDocuments
		InstallPathOriginalSetting:=InstallPath
		Gui 1:add, edit,  ReadOnly x20 y40 w200 h20 hwndEditBrowse1,%InstallPath%
		global EditBrowse1

        ;PathEditY := Round(PathEditY -2.5, 1)

		;MsgBox, %PathEditY%
        global ControlsPage3:=[EditBrowse1] ;, Browse1]

		loop, % ControlsPage3.Count() {
			ControlsAllPages.Push(ControlsPage3[A_Index])
		}
		InitializedBefore[3] := 1
	}
	else{

		loop, % ControlsPage3.Count() {
			ControlsAllPages.Push(ControlsPage3[A_Index])
		}
		loop, % ControlsPage3.Count() {
			GuiControl, show, % ControlsPage3[A_Index]
			GuiControl, enable, % ControlsPage3[A_Index]
		}
	}

    GuiControlGet, PathEdit, Pos, %EditBrowse1%
    Gui 1:add, button, % " x" PathEditX + PathEditW + 20 " y" PathEditY - 2.5 " h" 25 " gBrowse hwndBrowse1 ", % %SetLanguage%[9]
    global Browse1
    ControlsAllPages.Push(Browse1)
    Gui 1:show, w450 h550, % %SetLanguage%[1]
Return

;===============================================================

Browse:
    global InstallPath
    global InstallPathOriginalSetting
    FileSelectFolder, InstallPath, ,,Please select a folder for the script to work in.`nOld folders of the script will NOT be moved automaticly.
    IfExist, %InstallPath%
    {
    	GuiControl, , %EditBrowse1%, %InstallPath%
		    InstallPathOriginalSetting:=InstallPath
    }
    else if(InstallPath=""&&ErrorLevel=1){
    	MsgBox, ErrorLevel1
    	InstallPath:=InstallPathOriginalSetting
    	return
    }
    else if(InstallPath=""){
    	msgbox, Can't set to that location!
    	InstallPath:=InstallPathOriginalSetting
	    return
    }
    Gui 1:submit, NoHide
    return
}

Page4(){
	Gui 1:submit, NoHide
	global InstallPath
	global ButtonNext
	global XBNtl
	global YBNtl
	LanguageArray()

	;GuiControlGet, bi, Pos, %ButtonInstall%
    ;GuiControl, Move, %ButtonNext%, x%biX% y%biY% w%biW% h%biH%
    ;GuiControl,Text, %ButtonNext%, % %SetLanguage%[5]
	;GuiControl, disable, %ButtonNext%
	;GuiControl, hide, %ButtonNext%
	if(InitializedBefore[4]=0){
		Gui 1:add, Checkbox, x20 y20 w100000 vLaunchAfterInstall gUpdateCheckboxes hwndLaunchAfterInstallhwnd Checked1, % %SetLanguage%[11]
		global LaunchAfterInstall
        global LaunchAfterInstallhwnd
		;global LaunchAfterInstallhwnd
        ;Gui 1:Submit,NoHide
		;GuiControlGet, LaunchAfterInstall, Enabled, %LaunchAfterInstallhwnd%
        ;MsgBox, %LaunchAfterInstall%
		Gui 1:add, Checkbox, x20 y50 w100000 vDesktopIcon gUpdateCheckboxes hwndDesktopIconhwnd Checked1, % %SetLanguage%[12]
		global DesktopIcon
        global DesktopIconhwnd
		Gui 1:add, Text, x20 y80 w100000 hwndInstallPathText, % %SetLanguage%[10]":" ;`n"InstallPath
		Gui 1:add, Edit, Readonly x20 y100 w200 h20 hwndInstalledAtEdit, %InstallPath%
        global InstallPathText
        global InstalledAtEdit

        global ControlsPage4:=[LaunchAfterInstallhwnd, DesktopIconhwnd, InstallPathText, InstalledAtEdit]

		loop, % ControlsPage4.Count() {
			ControlsAllPages.Push(ControlsPage4[A_Index])
		}
		InitializedBefore[4] := 1
	}
	else{

		loop, % ControlsPage4.Count() {
			ControlsAllPages.Push(ControlsPage4[A_Index])
		}
		loop, % ControlsPage4.Count() {
			GuiControl, show, % ControlsPage4[A_Index]
			GuiControl, enable, % ControlsPage4[A_Index]
		}
	}
    ;MsgBox, %DesktopIconhwnd%
    GuiControl, , %InstallPathText%, % %SetLanguage%[10]":" ;The program will be installed at:
    GuiControl, , %InstalledAtEdit%, %InstallPath%
    GuiControl, , %LaunchAfterInstallhwnd%, % %SetLanguage%[11]
    GuiControl, , %DesktopIconhwnd%, % %SetLanguage%[12]
    ;ControlSetText, , %InstallPath%, % " ahk_id" InstallPathText
    Gui 1:show, w250 h250, % %SetLanguage%[1]
	global XBPtl
    global YBPtl
    global XBNtl
    global YBNtl
    global Gui1
    ;global ButtonNext 
    global ButtonPrevious
    ;global bpW

        ;msgbox, %ButtonInstall%

        Gui 1:add, Button, x-100 y-100 hwndButtonInstall gButtonInstall, % %SetLanguage%[5]
        global ButtonInstall

    ;================Calculation=============================
global cp := WinGetClientPos(Gui1)

    a := 15   ;Distance between top right corner of "ButtonPrevious" and top left corner of "ButtonNext"
    GuiControlGet, bi, Pos , %ButtonInstall%
    GuiControlGet, bp, Pos , %ButtonPrevious%

    aX := 20   ;Distance of right side of "ButtonNext" to right border of Gui
    aY := 10   ;Distance of bottom side of "ButtonNext" to bottom border of Gui

    gXbr := % cp.w  ;"guiXbottomright": X-coordinate of bottom right gui-corner
    gYbr := % cp.h  ;"guiYbottomright": Y-coordinate of bottom right gui-corner

    global XBNtl:= (gXbr - aX) - biW
    global YBNtl:= (gYbr - aY) - biH

    global XBPtl:= (XBNtl - a) - bpW
    global YBPtl:= YBNtl


    GuiControl, Move, %ButtonInstall%, x%XBNtl% y%YBNtl%
    GuiControl, Move, %ButtonPrevious%, x%XBPtl% y%YBPtl%
    ;GuiControl, Text, %ButtonInstall%, % %SetLanguage%[5]
    ;MsgBox, AfterMove: x%XBPtl% y%YBPtl%
    ControlsAllPages.Push(ButtonInstall)
    ;ButtonNext := testvar
    global LaunchAfterInstall
    GuiControlGet,LaunchAfterInstall, Enabled, %LaunchAfterInstallhwnd%
    return

	UpdateCheckboxes:
		Gui 1:Submit, NoHide
	return
}

;====================================================

ClearPage(){
	loop, % ControlsAllPages.Count(){
		GuiControl, disable, % ControlsAllPages[A_Index]
		GuiControl, hide, % ControlsAllPages[A_Index]
	}
	ControlsAllPages:=[]
}

LanguageArray(){
	PossibleLanguageCount:=PossibleLanguage.count()
	Loop, %PossibleLanguageCount% 
	{
		LanguageVar:=% PossibleLanguage[PossibleLanguageCount]
		if(LanguageVar=SetLanguage){	
			SetLanguage:=LanguageVar
		}
		else if(PossibleLanguageCount<=1){
			SetLanguage:="English"
			Iniwrite, %SetLanguage%, Config.ini, LanguageSetTo,Language 
			MsgBox, Set to %SetLanguage%
		}
		else{
			PossibleLanguageCount--
		}
	}
}
;=================================

UiElementsCalculation(GuiNumber){

    global Gui1
	global XBPtl
    global YBPtl
    global XBNtl
    global YBNtl
    global ButtonNext
    global ButtonPrevious
        ;==========================
    ;global GuiNumber

    global cp := WinGetClientPos(GuiNumber)
        
    ;================Calculation=============================
    a := 15   ;Distance between top right corner of "ButtonPrevious" and top left corner of "ButtonNext"
    GuiControlGet, bn, Pos , %ButtonNext%
    GuiControlGet, bp, Pos , %ButtonPrevious%
    aX := 20   ;Distance of right side of "ButtonNext" to right border of Gui
    aY := 10   ;Distance of bottom side of "ButtonNext" to bottom border of Gui

    gXbr := % cp.w  ;"guiXbottomright": X-coordinate of bottom right gui-corner
    gYbr := % cp.h  ;"guiYbottomright": Y-coordinate of bottom right gui-corner

    global XBNtl:= (gXbr - aX) - bnW
    global YBNtl:= (gYbr - aY) - bnH

    global XBPtl:= (XBNtl - a) - bpW
    global YBPtl:= YBNtl
        ;MsgBox, InFunc: x%XBPtl% y%YBPtl%
}


UiElements(){
    global XBPtl
    global YBPtl
    global XBNtl
    global YBNtl
    global Gui1

	Gui 1:add, Button, x-100 y-100 gNext hwndButtonNext, % %SetLanguage%[3]
	global ButtonNext
	Gui 1:add, Button, x-100 y-100 gPrevious hwndButtonPrevious, % %SetLanguage%[4]
	global ButtonPrevious

    UiElementsCalculation(Gui1)

    GuiControl, Move, %ButtonPrevious% , x%XBPtl% y%YBPtl%
    GuiControl, Move, %ButtonNext% , x%XBNtl% y%YBNtl%

    

			if(NumberOfPagesCurrently=NumberOfPagesMin){
				GuiControl, disable, %ButtonPrevious%
				;GuiControl, hide, %ButtonPrevious%
			}
			else if(NumberOfPagesCurrently<NumberOfPagesMin){
				MsgBox, Fehler!
				ExitApp
			}
			if(NumberOfPagesCurrently=NumberOfPagesMax){
				GuiControl, disable, %ButtonNext%
				;GuiControl, hide, %ButtonNext%
			}
			else if(NumberOfPagesCurrently>NumberOfPagesMax){
				MsgBox, Fehler!
				ExitApp
			}

return

Next:
    global cp
    global Gui1
	if(NumberOfPagesCurrently>=NumberOfPagesMin && NumberOfPagesCurrently<NumberOfPagesMax){
		NumberOfPagesCurrently+=1
		GuiControl, enable, %ButtonPrevious%
		GuiControl, show, %ButtonPrevious%
		ClearPage()
		Page%NumberOfPagesCurrently%()
		if(NumberOfPagesCurrently != NumberOfPagesMax){
		MoveUiButtons(Gui1)
		}
	}
	if(NumberOfPagesCurrently=NumberOfPagesMax){
		GuiControl, disable, %ButtonNext%
	}
return

Previous:
	if(NumberOfPagesCurrently<=NumberOfPagesMax && NumberOfPagesCurrently>NumberOfPagesMin){
		NumberOfPagesCurrently-=1
		GuiControl, enable, %ButtonNext%
		GuiControl, show, %ButtonNext%
		ClearPage()
		Page%NumberOfPagesCurrently%()
		MoveUiButtons(Gui1)
		
	}
	if(NumberOfPagesCurrently=NumberOfPagesMin){
		GuiControl, disable, %ButtonPrevious%
	}
return

;====================================================================

}





;================================================================
WinGetClientPos(hwnd) {
    global cp
    VarSetCapacity(RECT, 16, 0)
    DllCall("user32\GetClientRect", Ptr, hwnd, Ptr, &RECT)
    DllCall("user32\ClientToScreen", Ptr, hwnd, Ptr, &RECT)
    Win_Client_X := NumGet(&RECT, 0, "Int")
    Win_Client_Y := NumGet(&RECT, 4, "Int")
    Win_Client_W := NumGet(&RECT, 8, "Int")
    Win_Client_H := NumGet(&RECT, 12, "Int")
    return {"x": Win_Client_X, "y": Win_Client_Y, "w": Win_Client_W, "h": Win_Client_H}
}

MoveUiButtons(GuiNumber){
	;global GuiNumber
    global XBNtl
    global YBNtl
    global XBPtl
    global YBPtl
	global cp := WinGetClientPos(GuiNumber)
	global ButtonPrevious
	global ButtonNext

    UiElementsCalculation(GuiNumber)

    GuiControl, Text, %ButtonPrevious%, % %SetLanguage%[4]
    GuiControl, Move, %ButtonPrevious% , x%XBPtl% y%YBPtl%
    GuiControl, Text, %ButtonNext%, % %SetLanguage%[3]
    GuiControl, Move, %ButtonNext% , x%XBNtl% y%YBNtl%
}

ButtonInstall:
    global InstallPath
    global Gui1
	global XBPtl
    global YBPtl
    global XBNtl
    global YBNtl
    /*
    Gui 1:Submit,NoHide
    global LaunchAfterInstall
    LaunchAfterInstall := 0
    */
    Gui 1:Cancel
    ;MsgBox, %InstallPath%
    ProgressBarX:=20
    ProgressBarY:=20
    ProgressBarW:=200
    ProgressBarH:=20
    Gui 2:new, hwndGui2
    Gui 2:add, Progress, Range0-100 x%ProgressBarX% y%ProgressBarY% w%ProgressBarW% h%ProgressBarH% c07E500 Backgroundd8d8d8 hwndInstallProgress vInstallProgressVar, 0
    global InstallProgress
    global InstallProgressVar
    Gui 2:add, text, % "x" ProgressBarX-1 " y" ProgressBarY-1 " w" ProgressBarW+2 " h" ProgressBarH+2 " 0x7 vRectangle" " hwndProgressBarOutline"
    global ProgressBarOutline
    Gui 2:add, text, % "x" ProgressBarX " y" ProgressBarY+30 " w" 200 " h" 100 " hwndInstallingProgressText"
    global InstallingProgressText
	Gui 2:show, w400 h400, % %SetLanguage%[1]
    Gui 2:-SysMenu
    InstallingProcess()
	GuiControl, hide, %InstallProgress%
	GuiControl, disable, %InstallProgress%
	GuiControl, hide, %ProgressBarOutline%
	UiElementsCalculation(Gui2)
	Gui 2:add, Button, x%XBPtl% y%YBPtl% gFinishInstallation hwndFinishInstallationhwnd, % %SetLanguage%[6]
	GuiControlGet, FinishInstallationButton, Pos, %FinishInstallationhwnd%
	Gui 2:add, Checkbox, x50 y100 w100000 vLaunchReadme hwndLaunchReadmehwnd Checked0, % %SetLanguage%[13]
	global LaunchReadmehwnd

Return

InstallingProcess(){
	global InstallPath
    global InstallProgress
    global InstallProgressVar
	global DesktopIcon

    Loop, Read, SourceCode.txt ;words.txt
    {
        totalLinesOfSourceCode = %A_Index%  ;is set to total number of lines of file, after done looping
    }
    GuiControl,+Range0-590, InstallProgressVar ;sets the ProgressBar-range to the total number of lines in SourceCode.txt

	FileCreateDir, %InstallPath%\AutoFolder.ahk.
	FileCopy, %A_ScriptDir%\Components\zahnrad_2.png, %InstallPath%\AutoFolder.ahk., 1
    FileRead,SourceCode, %A_ScriptDir%\Components\SourceCode.txt
    ;msgbox, %SourceCode%
    AllowedFileTypes := ["txt","ahk","ini"]
    FileNames := ["Code1","Code2","Code3","Config"]

    FileNamesLoopVar := 1
    
    ;TempLoopVar:=0
    Loop Parse, SourceCode, `n, `r
    {    
	    if (A_LoopField ~= ("^---(" getRegExOrFromObj(AllowedFileTypes) ")$")){
		    FileEnding := RegExReplace(A_LoopField, "[-]" , Replacement := "",,Limit := 3)
		    FileAppend, % SubStr(text, 1, -1), % InstallPath "\AutoFolder.ahk\" FileNames[FileNamesLoopVar] "."FileEnding, CP65001
		    text := ""
	    	FileNamesLoopVar++
    		continue
	    }
	    text .= A_LoopField "`n"
            ;MsgBox, %A_LoopField% ;%A_Index% ;%SourceCode%
			;GuiControl,, InstallProgressVar, % "+" 100 / FileNames.Count()
            GuiControl,, InstallProgressVar, +1 ;% "+" 100 / 100
            GuiControl, Text, %InstallingProgressText%, %A_LoopField%
            ;GuiControl,, InstallingProgressVar, % "+" 100 / 100 ;+1
            Gui 1:submit, NoHide
            ;TempLoopVar++
            Sleep, 10
            ;GuiControlGet, percentage, , %InstallProgress%
            ;Msgbox, %percentage%
            ;Sleep, 100
            ;MsgBox,%FileNamesLoopVar%
            ;MsgBox, %TestVar%
            ;TestVar++
    }
    ;return
    GuiControl, Hide, %InstallingProgressText%
    ;MsgBox, %TempLoopVar%
	MsgBox, Done %DesktopIcon%
	if(DesktopIcon = 1){
    FileCreateShortcut, % InstallPath "\AutoFolder.ahk\Code1.txt", % A_Desktop "\TestLinkTxt.lnk" ,,,, % A_ScriptDir "\Components.\zahnrad_2.ico"
	}
}

getRegExOrFromObj(obj){
    for _, v in obj
        str .= "|" v
    return, subStr(str, 2)
}

FinishInstallation:
    ;global LaunchAfterInstallhwnd
    global LaunchAfterInstall
    global InstallPath
	global LaunchReadmehwnd
	GuiControlGet,LaunchReadmeValue,Enabled, %LaunchReadmehwnd%
    ;Gui 1:Submit, NoHide
    ;GuiControlGet, LaunchAfterInstall, Enabled, %LaunchAfterInstallhwnd%
    ;Msgbox, %LaunchAfterInstall%
	;Msgbox, %LaunchReadmeValue%
	if(LaunchReadmeValue = 1){
		MsgBox, LaunchReadme
	}
    if(LaunchAfterInstall = 1){
    	;MsgBox, %LaunchAfterInstall% : Run Program
        Run, %InstallPath%
    }
    ExitApp
return

GuiClose:
    Gui 1Close:new, hwnd1CloseGui
    Gui 1Close:add, Text, y40, % %SetLanguage%[17] ;Are you sure that you want to cancel the installation?
    Gui 1Close:add, Button,gYesClose hwndYesClose, % %SetLanguage%[15] ;Yes
    Gui 1Close:add, Button,gNoClose hwndNoClose, % %SetLanguage%[16] ;No
    Gui 1Close:-SysMenu
    Gui 1Close:show, w300 h100, % %SetLanguage%[14] ;Cancel Installation?
    global CloseId := 1  ;Is set to the number of gui to close(Gui1 in this example)
    cp := WinGetClientPos(1CloseGui)
    a := 15   ;Distance between top right corner of "ButtonPrevious" and top left corner of "ButtonNext"
    GuiControlGet, bn, Pos , %NoClose%
    GuiControlGet, by, Pos , %YesClose%
    aX := 20   ;Distance of right side of "ButtonNext" to right border of Gui
    aY := 10   ;Distance of bottom side of "ButtonNext" to bottom border of Gui
    gXbr := % cp.w  ;"guiXbottomright": X-coordinate of bottom right gui-corner
    gYbr := % cp.h  ;"guiYbottomright": Y-coordinate of bottom right gui-corner
    XBNtl:= (gXbr - aX) - bnW
    YBNtl:= (gYbr - aY) - bnH
    XBYtl:= (XBNtl - a) - byW
    YBYtl:= YBNtl
    GuiControl, Move, %YesClose% , x%XBYtl% y%YBYtl%
    GuiControl, Move, %NoClose% , x%XBNtl% y%YBNtl%
return

YesClose:
ExitApp
return

NoClose:
global CloseId
Gui %CloseId%Close:Cancel
return