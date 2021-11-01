
GosubIfValidLabel(PopupPromt("Hello", "Back","ReloadGui", "Continue","DontReloadGui", "Checkbox","TestPopupPromt|ShowPromt",1))
ExitApp
return


GosubIfValidLabel(Expression){
    if(IsLabel(Expression)){
        Gosub, %Expression%
    }
}

PopupPromt(GuiText, ButtonBackText, ButtonBackLabel, ButtonContinueText, ButtonContinueLabel, CheckboxText, CheckboxIniValue, OnlyContinueIfCheckbox){

        static OnlyContinueIfCheckbox2 
        OnlyContinueIfCheckbox2 := OnlyContinueIfCheckbox

        static ButtonBackLabel2
        ButtonBackLabel2 := ButtonBackLabel

        static ButtonContinueLabel2
        ButtonContinueLabel2 := ButtonContinueLabel

        static ButtonFinalReturn

        
        if(CheckboxIniValue != ""){
            static CheckboxIniValueArray
            CheckboxIniValueArray := StrSplit(CheckboxIniValue, "|")
            ;msgbox, % "[1]: "CheckboxIniValueArray[1] "`n" "[2]: "CheckboxIniValueArray[2]
            IniRead, ShowPopup, Config.Ini, % CheckboxIniValueArray[1], % CheckboxIniValueArray[2]

            if(ShowPopup = 0){
                return
            }
            ;msgbox, %OutputVar%
        }
        

        Gui 1:New, hwndPopupPromtGuiHwnd
        Gui 1:-SysMenu
        static CheckboxHwnd
		Gui 1:add, CheckBox, hwndCheckboxHwnd gUpdateCheckbox Checked0, %CheckboxText%
		Gui 1:add, Button, gButtonBack hwndButtonBackHwnd, %ButtonBackText%
        static ButtonContinueHwnd
		Gui 1:add, Button, gButtonContinue hwndButtonContinueHwnd, %ButtonContinueText%
		Gui 1:show, w200 h200, %GuiText%
        if(OnlyContinueIfCheckbox2 = 1){
            GuiControl, Disable, %ButtonContinueHwnd%
        }
    ;ChooseGuiStates(PopupPromtGuiHwnd,"+","+","")
    while(WinExist(GuiText)){
        ;wait
    }
    ;ChooseGuiStates(PopupPromtGuiHwnd, "-","-","")

    return ButtonFinalReturn

    UpdateCheckbox:

        if(OnlyContinueIfCheckbox2 = 1){

            ControlGet, CheckboxValue, Checked,,, % " ahk_id" CheckboxHwnd
            if(CheckboxValue = 0){
                GuiControl, Disable, %ButtonContinueHwnd%
            }
            else if(CheckboxValue = 1){
                GuiControl, Enable, %ButtonContinueHwnd%
            }
        }
    return

    ButtonContinue:
        ControlGet, CheckboxValue, Checked,,, % " ahk_id" CheckboxHwnd
        ;msgbox, %CheckboxValue%
        if(CheckboxValue = 1){
            CheckboxValue := 0
        }
        else{
            CheckboxValue := 1
        }
        IniWrite, %CheckboxValue%, Config.ini, % CheckboxIniValueArray[1], % CheckboxIniValueArray[2]
        Gui 1:Destroy
        ;return %ButtonContinueLabel2%
        ;static ButtonFinalReturn
        ButtonFinalReturn := ButtonContinueLabel2
    return

    ButtonBack:
        ControlGet, CheckboxValue, Checked,,, % " ahk_id" CheckboxHwnd
        CheckboxValue := 1
        IniWrite, %CheckboxValue%, Config.ini, % CheckboxIniValueArray[1], % CheckboxIniValueArray[2]
        Gui 1:Destroy
        ;msgbox, %ButtonBackLabel2%
        ;return %ButtonBackLabel2%
        ;static ButtonFinalReturn
        ButtonFinalReturn := ButtonBackLabel2
    return 

}
return

ChooseGuiStates(WillBeOwnedGuiHwnd, OwnerMode, DisableMode, AdditionalOwnershipParam*){
    static AdditionalOwnerships
    AdditionalOwnerships := AdditionalOwnershipParam

            loop, % AdditionalOwnerships.Count(){
            OwnerString := AdditionalOwnerships[A_Index]
            ;MsgBox, %OwnerString%
            if(WillBeOwnedGuiHwnd != "" && OwnerMode != ""){
                Gui %WillBeOwnedGuiHwnd%: %OwnerMode%owner%OwnerString%
            }
            Gui %OwnerString%:%DisableMode%Disabled
        }
}
return

ReloadGui:
;msgbox, Do reload the Gui
return

DontReloadGui:
;msgbox, Do not reload the Gui
return