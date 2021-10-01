RangeMinUpDown := 1
RangeMaxUpDown := 10

;Msgbox, % FormatNumber("dijnnv")


Gui, Add, Edit,hwndEdit gWhileFocused, -2mceoir2
Gui, Add, UpDown, vMyUpDown gUpDown Range%RangeMinUpDown%-%RangeMaxUpDown% Wrap, 5
;gui, add, button,hwndUpdateContentbutton gUpdateContent,UpdateContent
Gui, Add, button, x-100 y-100 hwndInvisibleButton,Ignore`nthis
gui, add, button, x10 hwndSaveButton gSave,Save
Gui, Add, Edit, x100 y5, ;Only for testing
gui, show, w300 h300, UpDownTest
GuiControlGet, MyUpDown, , %Edit%
;MsgBox, % FormatNumber(MyUpDown)
UpDownFinalValue := MyUpDown
return

UpDown:
    UpDownFinalValue := MyUpDown
return

WhileFocused:
    GuiControlGet, IsFocusedEdit, Focus ;
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%

    While(IsActive(Edit,3)) ; && IsFocusedHwnd = Edit)
    {
        ;GuiControlGet, IsFocusedEdit, Focus ;
        ;GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
        ;wait
    }
    ;MsgBox, goto
    ;IsInactive(Edit)
    Goto, UpdateContent
return

WhileNotFocused:

    GuiControlGet, MyUpDown, , %Edit%

    ;MsgBox, MyUpDown: %MyUpDown%
    MyUpDown := FormatNumber(MyUpDown)
    ;MsgBox, MyUpDown: %MyUpDown%

    UpDownFinalValue := MyUpDown
    GuiControlGet, IsFocusedEdit, Focus ;
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%

    While(IsFocusedHwnd != Edit)
    {
        GuiControlGet, IsFocusedEdit, Focus
        GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    }
    Goto, WhileFocused
return

UpdateContent:

    ;/*===========================Sets value to Max when overMax==================0
    GuiControlGet,CurrentContentEdit,, %Edit%

    ;MsgBox, CurrentContentEdit: %CurrentContentEdit%
    CurrentContentEdit := FormatNumber(CurrentContentEdit)
    ;MsgBox, CurrentContentEdit: %CurrentContentEdit%

    if(CurrentContentEdit = "ERROR"){
        GuiControl,, %Edit%, %MyUpDown%
        Msgbox, Please input a valid number!
        return
    }

    if(CurrentContentEdit < RangeMinUpDown){
        MyUpDown := RangeMinUpDown
        GuiControl,Text, %Edit%, %MyUpDown%
        UpDownFinalValue := MyUpDown
        MsgBox,, Invalid Value!, The smallest supported value is %RangeMinUpDown%!
    }
    else if(CurrentContentEdit > RangeMaxUpDown){
        MyUpDown := RangeMaxUpDown
        GuiControl,Text, %Edit%, %MyUpDown%
        UpDownFinalValue := MyUpDown
        MsgBox,, Invalid Value!, The biggest supported value is %RangeMaxUpDown%!
    }
    else{ ; if(CurrentContentEdit <= RangeMaxUpDown && CurrentContentEdit >= RangeMinUpDown){
        UpDownFinalValue := CurrentContentEdit
    }

    UnfocusEverything(InvisibleButton)
    ;MsgBox, %InvisibleButton%

    GuiControlGet, IsFocusedEdit, Focus
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    if(IsFocusedHwnd != Edit){
        Goto, WhileNotFocused
    }
    else{
        Goto, WhileFocused
    }
    /*
    else if(CurrentContentEdit <= RangeMaxUpDown && CurrentContentEdit >= RangeMinUpDown){
        MyUpDown := CurrentContentEdit
        GuiControl,Text, %Edit%, %MyUpDown%
    }
    */
    ;*/


    ;=====================Resets to last value when overMax or underMin=========================
    /*
    GuiControlGet,CurrentContentEdit,, %Edit%
    if(CurrentContentEdit >= RangeMinUpDown && CurrentContentEdit <= RangeMaxUpDown){
        MyUpDown := CurrentContentEdit
    }
    else{
        GuiControl,Text, %Edit%, %MyUpDown%
    }
    */
return

Save:
    MsgBox, %UpDownFinalValue%
return

F6::
    MsgBox, %UpDownFinalValue%
return

GuiClose:
    ExitApp
return

FormatNumber(number){

    ;number2 := ""number
    ;MsgBox, %number%
    ;number := "-00035+11"
    Didgets := StrSplit(number)

    loop, % Didgets.Count(){ ;Sorts out anything else than numbers, plus and minus operators

        if(IsNumber(Didgets[A_Index]) = false && Didgets[A_Index] != "-" && Didgets[A_Index] != "+"){
            Didgets[A_Index] := ""
        }
        if((Didgets[A_Index] = "-" || Didgets[A_Index] = "+") && A_Index != 1){
            Didgets[A_Index] := ""
        }

    }

    /*
    AddVar := 0
    loop, % Didgets.Count(){ ;Checks if number is zero to avoid further processing
        AddVar += Didgets[A_Index]
    }
    if(AddVar = 0){
        return 0
    }
    */

    if(Didgets[1] = "-" || Didgets[1] = "+"){  ;Ensures that following while-loop doesnt break on the first run because of a mathematical sign
        WhileLoopVar := 2
    }
    Else{
        WhileLoopVar := 1
    }

    while(Didgets[WhileLoopVar] = 0 && WhileLoopVar <= Didgets.Count()){  ;Finds point in didgets where didget is above 0 in value

        Didgets[WhileLoopVar] := ""
        WhileLoopVar++
        
    }

    RemovePlusSign(Didgets)
    RemoveMinusSign(Didgets)
    
    loop, % Didgets.Count() ;Add everything exept 0's before first number to a ReturnString
    {
        ReturnString .= Didgets[A_Index] 

    }

    if(ReturnString != ""){ 
        return ReturnString
    }
    else{
        return "ERROR"
    }

}

IsNumber(Input){
    if(Input = 0 || Input = 1 || Input = 2 || Input = 3 || Input = 4 || Input = 5 || Input = 6 || Input = 7 || Input = 8 || Input = 9){
        return true
    }
    else{
        return false
    }

}

RemovePlusSign(DidgetsArray){
    if(DidgetsArray[1] = "+"){
        DidgetsArray[1] := ""
        return DidgetsArray
    }
    else{
        return DidgetsArray
    }
}

RemoveMinusSign(DidgetsArray){
        if(DidgetsArray[1] = "-"){
        DidgetsArray[1] := ""
        return DidgetsArray
    }
    else{
        return DidgetsArray
    }
}

IsAllNumbers(Input){
    DidgetsArray := StrSplit(Input)
    loop, % DidgetsArray.Count(){
        if(!IsNumber(DidgetsArray[A_Index])){
            return false
        }
    }
    return true
}

IsActive(EditControlHwnd,TimeUntilInactive){

    TimeUntilInactive := TimeUntilInactive * 1000
    _starttime := A_TickCount ;Starts the timer
    ;Msgbox, % _starttime - A_TickCount
    static InitialEditContent
    static UpdatedEditContent
    GuiControlGet, InitialEditContent ,, %EditControlHwnd% ;Get content from edit

    GuiControlGet, IsFocusedEdit, Focus ;Gets name of focused control
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit% ;Gets Hwnd of focused control

    while(A_TickCount - _starttime < TimeUntilInactive && GetKeyState("Enter") != 1 && IsFocusedHwnd = EditControlHwnd){
        ;Msgbox, % A_TickCount - _starttime
        GuiControlGet, UpdatedEditContent ,, %EditControlHwnd% ;Get from edit
        if(InitialEditContent != UpdatedEditContent){ ;A_TickCount - _starttime > 5000){ ;resets timer back to 0
            _starttime := A_TickCount
        }
        InitialEditContent := UpdatedEditContent

        GuiControlGet, IsFocusedEdit, Focus ;
        GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    }
    
    return false
}

/*
IsInactive(EditControlHwnd,TimeUntilInactive){
    Sleep, % TimeUntilInactive * 1000
    static InitialEditContent
    static UpdatedEditContent
    GuiControlGet, InitialEditContent ,, %EditControlHwnd%
    ;MsgBox, %InitialEditContent%
    ;loop{
        ;Sleep, % TimeUntilInactive * 1000
        GuiControlGet, UpdatedEditContent ,, %EditControlHwnd%
        if(InitialEditContent = UpdatedEditContent){
            return true
        }
        else{
            return false
        }
    ;}
}
*/

UnfocusEverything(InvisibleButtonHwnd){
    ControlFocus,, % "ahk_id" InvisibleButtonHwnd
}