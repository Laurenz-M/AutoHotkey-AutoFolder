RangeMinUpDown := 1
RangeMaxUpDown := 10

;Msgbox, % FormatNumber("53")


Gui, Add, Edit, hwndEdit gWhileFocused
Gui, Add, UpDown, vMyUpDown gUpDown Range%RangeMinUpDown%-%RangeMaxUpDown% Wrap, 5
;gui, add, button,hwndheybutton ghey,hey
gui, add, button, hwndSaveButton gSave,Save
gui, show, w300 h300, hey
GuiControlGet, MyUpDown, , %Edit%
UpDownFinalValue := MyUpDown
return

UpDown:
    UpDownFinalValue := MyUpDown
return

WhileFocused:
    GuiControlGet, IsFocusedEdit, Focus ;
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%

    While(IsFocusedHwnd = Edit && GetKeyState("Enter") = 0)
    {
        GuiControlGet, IsFocusedEdit, Focus
        GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    }
    Goto, hey
return

WhileNotFocused:

    GuiControlGet, MyUpDown, , %Edit%
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

hey:
;/*===========================Sets value to Max when overMax==================0
GuiControlGet,CurrentContentEdit,, %Edit%
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
else{
    UpDownFinalValue := CurrentContentEdit
}

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

    AddVar := 0
    loop, % Didgets.Count(){ ;Checks if number is zero to avoid further processing
        AddVar += Didgets[A_Index]
    }
    if(AddVar = 0){
        return 0
    }

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
        return "ERROR, STRING EMPTY"
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





/*

UpDown:
;GuiControl, focus, %heybutton%
;Gui, submit, NoHide
;MyUpDown += 1
;MsgBox, k
gui, submit, NoHide
return

Edit:
;GuiControlGet, FocusControl, Focus ;, %GuiHwnd% 
;Gui, submit, NoHide
;MsgBox, %FocusControl%
return

WhileFocused:
    GuiControlGet, IsFocusedEdit, Focus ;
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    ;MsgBox, %IsFocusedHwnd% %Edit%
    While(IsFocusedHwnd = Edit && GetKeyState("Enter") = 0)
    {
        ;MsgBox, hello
        GuiControlGet, IsFocusedEdit, Focus
        GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    }
    Msgbox, break
    Goto, UpDown
return