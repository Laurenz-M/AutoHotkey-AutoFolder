#NoTrayIcon

IniRead,LanguageIni,Config.ini,LanguageSetTo,Language


;==============================Sprachen=================================================

global Deutsch:=["Über","Einstellungen","Checkbox","Allgemein","Box123","Werksein- stellungen","Änderungen speichern","Änderungen verwerfen","Leere Ordner verschieben","Leere Ordner löschen","Leere Ordner überspringen","nach","Durch suchen","Konfiguration öffnen","Source Code ansehen","Verwerfen","Abbrechen","Speichern","Sie haben ungespeicherte Veränderrungen!","Ja","Nein"]

global English:=["About","Settings","Checkbox","General","Box123","Default settings","Save changes","Cancel changes","Move empty folders","Delete empty folders","Skip empty folders","to","Browse","Open Config","View source code","Discard","Cancel","Save","There are unsaved changes!","Yes","No"]

global Français:=["A propos","Paramètres","Case à cocher","Général","Boîte123","Paramètres par défaut","Sauvegarder les modifications","Annuler les modifications","Déplacer les dossiers vides","Supprimer les dossiers vides","Ne changez pas les dossiers vides","vers","Parcourir","Ouvrez Config","Afficher le code source","jeter","Annuler","Sauvegarder","Il y a des changements non sauvés!","Oui","Non"]

global PossibleLanguage:=["English","Deutsch","Français"]

;========================================================================================

PossibleLanguageCount:=PossibleLanguage.count()

Loop, %PossibleLanguageCount% 
{
	LanguageVar:=% PossibleLanguage[PossibleLanguageCount]

	if(LanguageVar=LanguageIni){	
		;MsgBox, Found: %LanguageVar%!
	LanguageIni:=LanguageVar
	
	}
	else if(PossibleLanguageCount<=1){
	LanguageIni:="English"
	Iniwrite, %LanguageIni%, Config.ini, LanguageSetTo,Language 
	;MsgBox, Set to %LanguageIni%
	}
	else{
	PossibleLanguageCount--
	}
}

OptionLanguage:=LanguageIni




Gui, New,, %A_Space%AutoFolder V1.0
Gui, Font, S20 CDefault, Verdana
Gui, Font, S20 CDefault Bold, Verdana
Gui, Font, S40 CDefault Bold, Verdana
Gui, Font, S32 CDefault Bold, Verdana
Gui, Add, Text, x32 y19 w390 h60 , AutoFolder.ahk
Gui, Font, S8 CDefault, Verdana
Gui, Add, Picture, x431 y29 w100 h60 , 
Gui, Font, S15 CDefault Bold, Verdana
Gui, Add, Button, x440 y70 w90 h40 gAbout,% %LanguageIni%[1]
Gui, Add, Button, w60 h50 x470 y15 hwndIcon5 gSettings, % ""
GuiButtonIcon(Icon5, "zahnrad_2.png", 0)
Gui, Font, S8 CDefault Bold, Verdana
Gui, Add, Text, x32 y99 w400 h270 , Text

Gui +LastFound
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist() , "int", 1, "int64*", 6 | 6<<32, "uint", 8)
Gui, Show, w547 h379
ControlGet, SettingsButton, Hwnd ,, Button2, %A_Space%AutoFolder V1.0
WinGet, HwndMainWindow,, %A_Space%AutoFolder V1.0
return

Settings:

;==============================SETUP FUNCTIONS==============================

	Gui 2:Destroy

	Gui 2: +owner%HwndMainWindow%

	Gui, 2:Add, Tab3,, % %LanguageIni%[3]"|"%LanguageIni%[4]

	Gui, 2:Tab, 1
	Gui, 2:add, checkbox,w90 h20 y50 x20 gUpdate, % %LanguageIni%[5]
	Gui, 2:add, edit,  ReadOnly w200 h20,
	Gui, 2:add, button, x225 y74 w50 h25 gBrowse vBrowse, % %LanguageIni%[13]
	Gui 2:add,DropDownList, x20 y110 w115 gUpdate2 vDropDownEmptyFolders, % %LanguageIni%[9]"|"%LanguageIni%[10]"|"%LanguageIni%[11]
	Gui 2:add, text, x140 y115, % %LanguageIni%[12]
	Gui, 2:add, edit, vEdit2 ReadOnly x20 y140 w200 h20,
	Gui, 2:add, button, x225 y137 w50 h25 gBrowse2 vBrowse2, % %LanguageIni%[13]
	GuiControl, disable, %SettingsButton%


	Gui 2:add,DropDownList, x20 y172 w115 gUpdateLanguage vDropDownLanguage, % PossibleLanguage[1]"|"PossibleLanguage[2]"|"PossibleLanguage[3]


	;=========================NEEDS WORK!!!======================
	Gui, 2:add, Button, x30 y250 w70 h40 gDefaultSettings vDefaultSettings,% %LanguageIni%[6]
	;GuiControl 2:disable, DefaultSettings
	Gui, 2:add, Button, x120 y250 w70 h40 gCancelChanges vCancelChanges,% %LanguageIni%[8]
	GuiControl 2:disable, CancelChanges
	Gui, 2:add, Button, x210 y250 w70 h40 gSaveChanges vSaveChanges,% %LanguageIni%[7]
	GuiControl 2:disable, SaveChanges
	;==================================================================

	gui, 2:add, text, x15 y105 w270 h60 0x7 vRectangle


	Gui, 2:Tab, 2
	Gui, 2:add, button, w100 h30 gIniFile, % %LanguageIni%[14]
	Gui, 2:add, button, w100 h30 gSourceCode, % %LanguageIni%[15]
	Gui, 2:add, button, w100 h30 gRunScript, Run script
	Gui 2:+LastFound
	DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist() , "int", 1, "int64*", 6 | 6<<32, "uint", 8)
	Gui, 2:show, w300 h300, % %LanguageIni%[2]


	WinGet, HwndSettingsWindow,, % %LanguageIni%[2]
	;MsgBox, % %LanguageIni%[2]
	;MsgBox, %HwndSettingsWindow%



	SettingsOn:=1

	IniRead,OnOff,Config.ini, CheckBox123, Checkbox
	if(OnOff="checked")
	{
	Control, Check,,% %LanguageIni%[5],% %LanguageIni%[2]
	}
	else
	{
	}
	OnOffOriginalSettings:=OnOff  ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	IniRead, IniPath, Config.ini, FolderPath,Path
	ControlSetText,Edit1, %IniPath%, % %LanguageIni%[2]
	IniPathOriginalSettings:=IniPath  ;!!!!!!!!!!!!!!!!!!!!!!!!!
	IniRead, IniPath2, Config.ini, EmptyFolderPath,Path
	ControlSetText,Edit2, %IniPath2%, % %LanguageIni%[2]
	IniPath2OriginalSettings:=IniPath2  ;!!!!!!!!!!!!!!!!!!!!!!
	NewPath:=IniPathOriginalSettings
	NewPath2:=IniPath2OriginalSettings

	IniRead, OptionEmptyFolders, Config.ini, WhatToDoWithEmptyFolders,Mode
    ;MsgBox, %LanguageIni%, %OptionEmptyFolders%
	OptionEmptyFoldersOriginalSettings:=TranslateIniRead(LanguageIni, OptionEmptyFolders) ;!!!!!!!!!!!!!!!

	OptionLanguageOriginalSettings:=OptionLanguage


	PossibleLanguageCount:=PossibleLanguage.count()

	Loop, %PossibleLanguageCount% 
	{
		LanguageVar:=% PossibleLanguage[PossibleLanguageCount]

		ArrayObjectCount:=%LanguageVar%.count()
			Loop, %ArrayObjectCount%
			{
			if(OptionEmptyFoldersOriginalSettings=%LanguageVar%[ArrayObjectCount]){
			Control, ChooseString,% %LanguageIni%[ArrayObjectCount],ComboBox1, % %LanguageIni%[2]
			ChangedSettings:=0
			GuiControl 2:disable, SaveChanges
			break, 2 
			}
			else{
			ArrayObjectCount--
			}

			}

		
		PossibleLanguageCount--
		
	}


	;==========================SetLanguage====================

	Control, ChooseString,%LanguageIni%,ComboBox2, % %LanguageIni%[2]
	ChangedSettings:=0
	GuiControl 2:disable, SaveChanges
	GuiControl 2:disable, CancelChanges
	return

;==============================LABELS=========================================0000

2GuiSize:
	if(ErrorLevel=1){
	Goto, 2GuiClose
	}
return


GuiClose:
	if(SettingsOn=1){
	MsgBox, Ist An. Ändere diese Nachricht zu einem Blinken des Einstellungs-Fensters
	}
	else{
	Gui, Cancel
	ExitApp
	}
Return

2GuiClose:
	if(ChangedSettings=1)
	{
	Gui 2:+Disabled
	;GuiControl 2:disable, CancelChanges
	;GuiControl 2:disable, SaveChanges
    Gui 3:New, hwndUnsavedChangeshwnd
	Gui 3:Add, text, 
	Gui 3:+LastFound
	DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist() , "int", 1, "int64*", 6 | 6<<32, "uint", 8)
	Gui 3:-SysMenu
	Gui 3:Add, Button, x270 y104 w70 h30 gCloseAndSaveChanges, % %LanguageIni%[18] 
	Gui 3:Add, Button, x200 y104 w70 h30 gCancelLeavingSettings, % %LanguageIni%[17]
	Gui 3:Add, Button, x130 y104 w70 h30 gCloseAndCancelChanges, % %LanguageIni%[16]
	Gui 3: +owner%HwndSettingsWindow%
	Gui 3:show, w350 h138, % %LanguageIni%[19]
	}
	else 
	{
	Gui 2:Cancel
	GuiControl,enable, %SettingsButton%
	SettingsOn:=0
	}
Return

CancelLeavingSettings:
	Gui 3:Cancel
	Gui 2:-Disabled 
	GuiControl 2:enable, CancelChanges
	GuiControl 2:enable, SaveChanges
	WinActivate, % %LanguageIni%[2]
return

CloseAndCancelChanges:
	if(OnOffOriginalSettings="checked")
	{
	Control, Check,,% %LanguageIni%[5], % %LanguageIni%[2]
	}
	else if(OnOffOriginalSettings="unchecked")
	{
	Control, Uncheck,,% %LanguageIni%[5], % %LanguageIni%[2]
	}
	GuiControl 2:disable, CancelChanges

	Control, ChooseString,%OptionEmptyFoldersOriginalSettings%,ComboBox1, % %LanguageIni%[2]
	GuiControl 2:disable, SaveChanges

	ControlSetText, Edit1,%IniPathOriginalSettings%, % %LanguageIni%[2]
	ControlSetText, Edit2,%IniPath2OriginalSettings%, % %LanguageIni%[2]
	ChangedSettings:=0
	Gui 3:Cancel
	Gui 2:Cancel
	GuiControl, enable, %SettingsButton%
	SettingsOn:=0
return

CloseAndSaveChanges:
    ;msgbox, % "return: " ReloadGui(LanguageIni,HwndSettingsWindow,UnsavedChangeshwnd)
    ;msgbox, % "TestM: " TestM()
    ;msgbox, hello
    if(ReloadGui(LanguageIni,HwndSettingsWindow,UnsavedChangeshwnd) = 1){
	OnOffOriginalSettings:=OnOff
	if(NewPath!=""){
	IniPathOriginalSettings:=NewPath
	}
	if(NewPath2!=""){
	IniPath2OriginalSettings:=NewPath2
	}
	OptionEmptyFoldersOriginalSettings:=DropDownEmptyFolders

	OptionLanguageOriginalSettings:=DropDownLanguage

	IniWrite, %OnOffOriginalSettings%, Config.ini,CheckBox123,CheckBox
	IniWrite, %IniPathOriginalSettings%, Config.ini, FolderPath, Path
	IniWrite, %IniPath2OriginalSettings%, Config.ini, EmptyFolderPath, Path
	IniWrite, %OptionEmptyFoldersOriginalSettings%, Config.ini, WhatToDoWithEmptyFolders,Mode
	ChangedSettings:=0
	Gui 3:Cancel
	Gui 2:Cancel
	GuiControl, enable, %SettingsButton%
	SettingsOn:=0
    Reload
    }
    else{
        ;msgbox, bruh
        GuiControl 2:enable, CancelChanges
        GuiControl 2:enable, SaveChanges
        Gui 3:Cancel
    }
return


Update2:
	Gui 2:Submit, NoHide
    OptionEmptyFolders := TranslateIniRead(LanguageIni,DropDownEmptyFolders)
	if(OptionEmptyFolders=%LanguageIni%[11])
	{
	GuiControl 2:disable, Edit2
	GuiControl 2:hide, Edit2
	GuiControl 2:hide, % %LanguageIni%[12]
	GuiControl 2:disable, Browse2
	GuiControl 2:hide, Browse2
	GuiControl 2:hide, Rectangle

	}
	if(OptionEmptyFolders=%LanguageIni%[10])
	{
	GuiControl 2:disable, Edit2
	GuiControl 2:hide, Edit2
	GuiControl 2:hide, % %LanguageIni%[12]
	GuiControl 2:disable, Browse2
	GuiControl 2:hide, Browse2
	GuiControl 2:hide, Rectangle
	}
	else if(OptionEmptyFolders=%LanguageIni%[9])
	{
	GuiControl 2:enable, Edit2
	GuiControl 2:show, Edit2
	GuiControl 2:show, % %LanguageIni%[12]
	GuiControl 2:enable, Browse2
	GuiControl 2:show, Browse2
	GuiControl 2:show, Rectangle
	}

	if(OptionEmptyFoldersOriginalSettings!=OptionEmptyFolders)
	{
	GuiControl 2:enable, CancelChanges
	GuiControl 2:enable, SaveChanges
	ChangedSettings:=1
	}
	else{
	Goto, IfChangesReversed
	}
return

Update:
	Gui 2:Submit, NoHide
	ControlGet, OnOff, Checked,, % %LanguageIni%[5], % %LanguageIni%[2]
	if(OnOff=1)
	{
	OnOff:="checked"
	}
	else if(OnOff=0)
	{
	OnOff:="unchecked"
	}


	if(OnOffOriginalSettings!=OnOff)
	{
	GuiControl 2:enable, CancelChanges
	GuiControl 2:enable, SaveChanges
	ChangedSettings:=1
	}
	else{
	Goto, IfChangesReversed
	}
return

UpdateLanguage:
	Gui 2:Submit, NoHide
	if(DropDownLanguage=PossibleLanguage[1]){ ;English
	}
	if(DropDownLanguage=PossibleLanguage[2]){ ;Deutsch
	}
	else if(DropDownLanguage=PossibleLanguage[3]){ ;Français
	}
	if(OptionLanguageOriginalSettings!=DropDownLanguage)
	{
	GuiControl 2:enable, CancelChanges
	GuiControl 2:enable, SaveChanges
	ChangedSettings:=1
	}
	else{
	Goto, IfChangesReversed
	}
return

IniFile:
	Run, Config.Ini
return

SourceCode:
	Run, SourceCode.txt
return

RunScript:
return

About:
	Run, TextAbout.txt
return

;=======================NEEDS WORK!!!====================
SaveChanges:
    if(ReloadGui(LanguageIni,HwndSettingsWindow) = 1){
        OnOffOriginalSettings:=OnOff
        if(NewPath!=""){
        IniPathOriginalSettings:=NewPath
        }
        if(NewPath2!=""){
        IniPath2OriginalSettings:=NewPath2
        }
        OptionEmptyFoldersOriginalSettings:=DropDownEmptyFolders

        OptionLanguageOriginalSettings:=DropDownLanguage

        GuiControl 2:disable, SaveChanges
        GuiControl 2:disable, CancelChanges

        IniWrite, %OnOffOriginalSettings%, Config.ini,CheckBox123,CheckBox
        IniWrite, %IniPathOriginalSettings%, Config.ini, FolderPath, Path
        IniWrite, %IniPath2OriginalSettings%, Config.ini, EmptyFolderPath, Path
        IniWrite, %OptionEmptyFoldersOriginalSettings%, Config.ini, WhatToDoWithEmptyFolders,Mode

        IniWrite, %OptionLanguageOriginalSettings%, Config.ini, LanguageSetTo,Language

        ChangedSettings:=0
        Reload
    }
    else{
        GuiControl 2:enable, CancelChanges
        GuiControl 2:enable, SaveChanges
    }
    
    
    
return

CancelChanges:
	if(OnOffOriginalSettings="checked")
	{
	Control, Check,,% %LanguageIni%[5], % %LanguageIni%[2]
	}
	else if(OnOffOriginalSettings="unchecked")
	{
	Control, Uncheck,,% %LanguageIni%[5], % %LanguageIni%[2]
	}

	Control, ChooseString,%OptionEmptyFoldersOriginalSettings%,ComboBox1, % %LanguageIni%[2]

	Control, ChooseString,%OptionLanguageOriginalSettings%,ComboBox2, % %LanguageIni%[2]

	GuiControl 2:disable, CancelChanges
	GuiControl 2:disable, SaveChanges

	ControlSetText, Edit1,%IniPathOriginalSettings%, % %LanguageIni%[2]
	ControlSetText, Edit2,%IniPath2OriginalSettings%, % %LanguageIni%[2]
	ChangedSettings:=0
return
;========================================================

Browse:
	FileSelectFolder, NewPath, \Desktop,,Please select a folder for the script to work in.`nOld folders of the script will NOT be moved automaticly.
	IfExist, %NewPath%
	{
	ControlSetText, Edit1,%NewPath%, % %LanguageIni%[2]
	}
	else if(NewPath=""&&ErrorLevel=1)
	{
	NewPath:=IniPathOriginalSettings
	return
	}
	else if(NewPath="")
	{
	msgbox, Can't set to that location!
	NewPath:=IniPathOriginalSettings
	return
	}

	if(IniPathOriginalSettings!=NewPath)
	{
	GuiControl 2:enable, CancelChanges
	GuiControl 2:enable, SaveChanges
	ChangedSettings:=1
	}
	else{
	Goto, IfChangesReversed
	}
return

Browse2:
	FileSelectFolder, NewPath2, \Desktop,,Please select a folder for the empty folders to be placed in.
	IfExist, %NewPath2%
	{
		ControlSetText,Edit2,%NewPath2%, % %LanguageIni%[2]
	}
	else if(NewPath2=""&&ErrorLevel=1)
	{
		;================Not sure if letting it stay out==============
		NewPath2:=IniPath2OriginalSettings
		return
	}
	else if(NewPath2="")
	{
		NewPath2:=IniPath2OriginalSettings
		;======================================================
		msgbox, Can't set to that location!

		return
	}
	if(IniPath2OriginalSettings!=NewPath2)
	{
		GuiControl 2:enable, CancelChanges
		GuiControl 2:enable, SaveChanges
		ChangedSettings:=1
	}
	else{
		Goto, IfChangesReversed
	}
return

DefaultSettings:

    Gui 4:new, hwndDefaultSettingshwnd
	Gui 4:Add, text,, Do you really want to revert all settings back to standart?
	Gui 4:+LastFound
	DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist() , "int", 1, "int64*", 6 | 6<<32, "uint", 8)
	Gui 4:-SysMenu
	Gui 4:Add, Button, x270 y104 w70 h30 gDefaultSettingsYes, % %LanguageIni%[20] ;yes
	Gui 4:Add, Button, x200 y104 w70 h30 gDefaultSettingsNo, % %LanguageIni%[21] ;no
	Gui 4:show, w350 h138, % %LanguageIni%[] ;revert to default settings?
	Gui 4: +owner%HwndSettingsWindow%
	Gui 2:+Disabled 

return

DefaultSettingsYes:
    if(ReloadGui(LanguageIni,HwndSettingsWindow, DefaultSettingshwnd) = 1){
	IniWrite, % %LanguageIni%[9], Config.ini, WhatToDoWithEmptyFolders,Mode
	IniWrite, C:, Config.ini, FolderPath, Path
	IniWrite, checked, Config.ini, CheckBox123, CheckBox
    Reload
    }
    else{
        Gui 4:Cancel
    }
	;Gui 4:Cancel
	;GuiControl 2:disable, DefaultSettings
	;Gui 2:-Disabled 
return

DefaultSettingsNo:
	Gui 4:Cancel
	Gui 2:-Disabled 
return

IfChangesReversed: 


    PossibleLanguageLoopVar := 1
    loop, % PossibleLanguage.Count(){

        LanguageArrayLoopVar := 1
        CurrentArrayLanguage := PossibleLanguage[PossibleLanguageLoopVar]
        ;Msgbox, %CurrentArrayLanguage%
        while(DropDownEmptyFolders != %CurrentArrayLanguage%[LanguageArrayLoopVar] && LanguageArrayLoopVar < %CurrentArrayLanguage%.Count()){
            ;Msgbox, % %CurrentArrayLanguage%[LanguageArrayLoopVar]
            LanguageArrayLoopVar++
        }
        if(DropDownEmptyFolders = %CurrentArrayLanguage%[LanguageArrayLoopVar]){
            ;Msgbox, break
            break
        }
        PossibleLanguageLoopVar++
    }
    ;MsgBox, %PossibleLanguageLoopVar%
    temp := PossibleLanguage[PossibleLanguageLoopVar]
    ;MsgBox, temp : %temp%
	if(OnOffOriginalSettings=OnOff && OptionEmptyFoldersOriginalSettings = OptionEmptyFolders && OptionLanguageOriginalSettings=DropDownLanguage && IniPathOriginalSettings=NewPath && IniPath2OriginalSettings=NewPath2)
	{
        ;MsgBox, yes
        GuiControl 2:disable, CancelChanges
        GuiControl 2:disable, SaveChanges
        ChangedSettings:=0
	}
return

F3::
	Reload
return

F5::
	MsgBox, OptionLanguageOriginalSettings: %OptionLanguageOriginalSettings%`nDropDownLanguage: %DropDownLanguage%`n`nOnOffOriginalSettings: %OnOffOriginalSettings%`nOnOff: %OnOff%`n`nIniPathOriginalSettings: %IniPathOriginalSettings%`nNewPath: %NewPath%`n`nIniPath2OriginalSettings: %IniPath2OriginalSettings%`nNewPath2: %NewPath2%`n`nOptionEmptyFoldersOriginalSettings: %OptionEmptyFoldersOriginalSettings%`nOptionEmptyFolders: %OptionEmptyFolders%
return

;==============================FUNCTIONS=================================

GuiButtonIcon(Handle, File, Index := 1, Options := "")
{
	RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 60 :
	RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 35 :
	RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
	RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
	RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
	RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
	RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
	RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
	Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
	VarSetCapacity( button_il, 20 + Psz, 0 )
	NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )	; Width & Height
	NumPut( L, button_il, 0 + Psz, DW )		; Left Margin
	NumPut( T, button_il, 4 + Psz, DW )		; Top Margin
	NumPut( R, button_il, 8 + Psz, DW )		; Right Margin
	NumPut( B, button_il, 12 + Psz, DW )	; Bottom Margin	
	NumPut( A, button_il, 16 + Psz, DW )	; Alignment
	SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
	return IL_Add( normal_il, File, Index )
}
return

TranslateIniRead(LanguageIn, VarIn){

    PossibleLanguageLoopVar := 1
    loop, % PossibleLanguage.Count(){

        LanguageArrayLoopVar := 1
        CurrentArrayLanguage := PossibleLanguage[PossibleLanguageLoopVar]

        while(VarIn != %CurrentArrayLanguage%[LanguageArrayLoopVar] && LanguageArrayLoopVar < %CurrentArrayLanguage%.Count()){

            LanguageArrayLoopVar++
        }
        if(VarIn = %CurrentArrayLanguage%[LanguageArrayLoopVar]){

            break
        }
        PossibleLanguageLoopVar++
    }
    if(%LanguageIn%[LanguageArrayLoopVar] != ""){
        return % %LanguageIn%[LanguageArrayLoopVar]
    }
    else if(%LanguageIn%[LanguageArrayLoopVar] = ""){
        Msgbox, % "Result would be:" %LanguageIn%[LanguageArrayLoopVar]
        Msgbox, [Error!]
        return "[Error]"
    }
}
return

ReloadGui(LanguageIni,AdditionalOwnershipParam*){
	static AdditionalOwnerships
	AdditionalOwnerships := AdditionalOwnershipParam
    static TestBreak
    TestBreak := 0
    static DoReloadGui

    Gui 2:+Disabled
	IniRead, ShowReloadGui, Config.ini, DontShowReloadMessage, Value
    ;ShowReloadGui := 1
    if(ShowReloadGui = 0){
	
		Gui 5:new, hwndReloadGuihwnd
		Gui 5:-SysMenu

        loop, % AdditionalOwnerships.Count(){
            OwnerString := AdditionalOwnerships[A_Index]
            ;Msgbox, %OwnerString%
		    Gui 5: +owner%OwnerString%
            Gui %OwnerString%:+Disabled
        }

		Gui 5:add, Text,, % %LanguageIni%[1]
		Gui 5:add, CheckBox, hwndShowAgainhwnd gShowAgain Checked0, Dont show again ;% %LanguageIni%[1]
		Gui 5:add, Button, gCancelGui hwndCancelGuihwnd, Cancel ;% %LanguageIni%[1]
		Gui 5:add, Button, gReloadGui hwndReloadGuihwnd, Reload ;% %LanguageIni%[1]
		Gui 5:show, w200 h200, % %LanguageIni%[1]
		;Msgbox, %ReloadGuihwnd%
		;ControlGet, ShowAgain, Checked,, % %LanguageIni%[1], % %LanguageIni%[1]
		static ShowAgain
		ControlGet, ShowAgain, Checked,,, % " ahk_id" ShowAgainhwnd
		;Msgbox, %ShowAgain%
		global GuiId
		GuiId := 5

        while(TestBreak = 0){
            ;wait
        }

        return DoReloadGui
        ;msgbox, % TestBreak
	}
    else{
        ;Reload
        return 1
    }
    
    return

    CancelGui:
        ;if(ShowAgain != ""){
        ;    IniWrite, %ShowAgain%, Config.ini, DontShowReloadMessage, Value
        ;}
        ;Msgbox, % AdditionalOwnerships.Count()
        ;MsgBox, %ShowAgain%
        loop, % AdditionalOwnerships.Count(){
            OwnerString := AdditionalOwnerships[A_Index]
            ;MsgBox, %OwnerString%
            Gui %OwnerString%:-Disabled
        }
        global GuiId
        Gui %GuiId%:Destroy
        GuiId := ""
        TestBreak := 1
        DoReloadGui := 0 ;Dont reload
    return

    ReloadGui:
        TestBreak := 1
    	;Msgbox, %ShowAgain%
        if(ShowAgain != ""){
            IniWrite, %ShowAgain%, Config.ini, DontShowReloadMessage, Value
        }
        ;msgbox, here
        DoReloadGui := 1 ;Do Reload
    return

    ShowAgain:
        ControlGet, ShowAgain, Checked,,, % " ahk_id" ShowAgainhwnd
    return

}
return
/*
TestM(){
    if(true){
        static Bruh
        Bruh := 0
        
        while(TestBreak = 0){
            ;wait
            Sleep,1
        }
        Goto, Label2
    }
    else{
        ;Reload
        return 1
    }
    Return

    Label:
        Bruh := 1
        return 1
    return

    Label2:
        Bruh := 1
        return 0
}
Return
*/