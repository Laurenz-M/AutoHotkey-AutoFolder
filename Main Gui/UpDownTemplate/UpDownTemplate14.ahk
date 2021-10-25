RangeMinUpDown := 1     ;variable to adjust Range of the updown
RangeMaxUpDown := 10      ;variable to adjust Range of the updown

Gui, Add, Edit,hwndEdit gWhileFocused, -2mceoir2    ;Edit of updown
Gui, Add, UpDown, -16 hwndUpDownHWND vMyUpDown gUpDown Range%RangeMinUpDown%-%RangeMaxUpDown% Wrap, 5  ;updown

Gui, Add, button, x-100 y-100 hwndInvisibleButton,Ignore`nthis  ;Invisible button so that the focus can be "taken away" from all controls on the gui
gui, add, button, x10 hwndSaveButton gSave,Save   ;Shows the value of the updown; doesnt really save anything; is placeholder for now
Gui, Add, Edit, x100 y5, ;Edit without any function for testing of focus
gui, show, w300 h300, UpDownTest
SetUpDown(UpDownHWND,Edit,20)

GuiControlGet, MyUpDown, , %Edit%   ;Sets value of updown to variable on startup
UpDownFinalValue := MyUpDown        ;^
;msgbox, % HasNoNumber("-")

return

UpDown:
    UpDownFinalValue := MyUpDown    ;updates the final variable
return
WhileFocused:
    ;msgbox, WhileFocused
    SetTimer, WhileFocusedSubroutine,-1
return

WhileFocusedSubroutine:   ;as long as the contents of updown's edit changes below the time of "IsActive", control stays focused
    ;msgbox, WhileFocusedSubroutine
    While(IsActive(Edit,3))     
    {
        ;wait
    }
     SetTimer, WhileFocusedSubroutine,Delete
    SetTimer,UpdateContentSubroutine, -1
    ;Goto, UpdateContent
return

WhileNotFocused:    ;sets a SetTimer to WhileNotFocusedSubroutine
    ;msgbox, WhileNotFocused
    SetTimer, WhileNotFocusedSubRoutine, -1
return

WhileNotFocusedSubroutine:    ;formats the content of updown's edit to valid number and writes it to final variable; calls "WhileActive" once updown's edit is being focused
    ;msgbox, WhileNotFocusedSubRoutine
    GuiControlGet, MyUpDown, , %Edit%
    MyUpDown := FormatNumber(MyUpDown)  ;formats edits content

    UpDownFinalValue := MyUpDown    ;sets content to final variable
    GuiControl,Text, %Edit%, %MyUpDown%     ;sets formated content to edit

    GuiControlGet, IsFocusedEdit, Focus ;gets focused control's hwnd
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%   ;^

    While(IsFocusedHwnd != Edit)    ;waits until updown's edit is focused
    {
        GuiControlGet, IsFocusedEdit, Focus
        GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit%
    }
    SetTimer, WhileNotFocusedSubRoutine, Delete
    SetTimer, WhileFocusedSubroutine, -1
    ;Goto, WhileFocused
return

UpdateContentSubroutine:  ;Updates the content of updown's edit after it changed
    ;msgbox, UpdateContentSubRoutine
    ;/*===========================Sets value to Max when overMax==================0
    GuiControlGet,CurrentContentEdit,, %Edit%
    CurrentContentEdit := FormatNumber(CurrentContentEdit)  ;formats updown's edit's content

    if(CurrentContentEdit = "ERROR"){   ;checks if formated content is valid
        GuiControl,, %Edit%, %MyUpDown%
        Msgbox, Please input a valid number!
        return
    }

    if(CurrentContentEdit < RangeMinUpDown){    ;Checks if value is below min value
        MyUpDown := RangeMinUpDown
        GuiControl,Text, %Edit%, %MyUpDown%
        UpDownFinalValue := MyUpDown
        MsgBox,, Invalid Value!, The smallest supported value is %RangeMinUpDown%!
    }
    else if(CurrentContentEdit > RangeMaxUpDown){   ;checks if value is above max value
        MyUpDown := RangeMaxUpDown
        GuiControl,Text, %Edit%, %MyUpDown%
        UpDownFinalValue := MyUpDown
        MsgBox,, Invalid Value!, The biggest supported value is %RangeMaxUpDown%!
    }
    else{ ; UNUSED CODE:    if(CurrentContentEdit <= RangeMaxUpDown && CurrentContentEdit >= RangeMinUpDown){
        UpDownFinalValue := CurrentContentEdit  ;updates final value
    }

    UnfocusEverything(InvisibleButton)  ;unfocuses controls

    GuiControlGet, IsFocusedEdit, Focus     ;gets focused control's hwnd
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit% ;^

    SetTimer, UpdateContentSubroutine,Delete
    if(IsFocusedHwnd != Edit){  ;checks if updown's edit is focused and calls correct label accordingly
        ;Goto, WhileNotFocused
        SetTimer, WhileNotFocusedSubRoutine, -1
    }
    else{
        ;Goto, WhileFocused
        SetTimer, WhileFocusedSubRoutine, -1
    }
return

Save:   ;displays final value
    MsgBox, %UpDownFinalValue%
return

F6::    ;displays final value trough keystroke
    MsgBox, %UpDownFinalValue%
return

GuiClose:   ;Stops script when gui is closed
    ExitApp
return

FormatNumber(number){   ;formats input to valid number

    if(HasNoNumber(number)){
        return "ERROR"
    }
    
    Didgets := StrSplit(number) ;splits input into characters

    loop, % Didgets.Count(){ ;Sorts out anything else than numbers, plus and minus operators

        if(IsNumber(Didgets[A_Index]) = false && Didgets[A_Index] != "-" && Didgets[A_Index] != "+"){
            Didgets[A_Index] := ""
        }
        if((Didgets[A_Index] = "-" || Didgets[A_Index] = "+") && A_Index != 1){
            Didgets[A_Index] := ""
        }

    }

    if(IfMergingOfArrayObjectsIs(Didgets,"0")){
        return 0
    }


    if(Didgets[1] = "-" || Didgets[1] = "+"){  ;Ensures that following while-loop doesnt break on the first run because of a mathematical sign
        WhileLoopVar := 2
    }
    Else{
        WhileLoopVar := 1
    }

    if()

    while(Didgets[WhileLoopVar] = 0 && WhileLoopVar <= Didgets.Count()){  ;Finds point in didgets where didget is above 0 in value

        Didgets[WhileLoopVar] := ""
        WhileLoopVar++
        
    }

    RemovePlusSign(Didgets) ;removes numbers prefix
    ;RemoveMinusSign(Didgets) ;^
    
    loop, % Didgets.Count() ;Add everything exept 0's before first number to a ReturnString
    {
        ReturnString .= Didgets[A_Index] 

    }

    if(ReturnString != ""){ ;checks if ReturnString is empty
        return ReturnString
    }
    else{   ;returns error when returnString is empty
        return "ERROR"
    }

}

IsNumber(Input){    ;Checks if input is numerical didget
    if(Input = 0 || Input = 1 || Input = 2 || Input = 3 || Input = 4 || Input = 5 || Input = 6 || Input = 7 || Input = 8 || Input = 9){
        return true
    }
    else{
        return false
    }

}

RemovePlusSign(DidgetsArray){   ;removes prefix from numerical input
    if(DidgetsArray[1] = "+"){
        DidgetsArray[1] := ""
        return DidgetsArray
    }
    else{
        return DidgetsArray
    }
}

RemoveMinusSign(DidgetsArray){  ;removes prefix from numerical input
        if(DidgetsArray[1] = "-"){
        DidgetsArray[1] := ""
        return DidgetsArray
    }
    else{
        return DidgetsArray
    }
}

IsAllNumbers(Input){    ;Checks if whole input is numerical 
    DidgetsArray := StrSplit(Input)
    loop, % DidgetsArray.Count(){
        if(!IsNumber(DidgetsArray[A_Index])){
            return false
        }
    }
    return true
}

IsActive(EditControlHwnd,TimeUntilInactive){    ;Checks if control has focus over input amount of time

    TimeUntilInactive := TimeUntilInactive * 1000   ;Converts param from seconds to miliseconds
    _starttime := A_TickCount ;Starts the timer
    static InitialEditContent
    static UpdatedEditContent
    GuiControlGet, InitialEditContent ,, %EditControlHwnd% ;Get content from edit

    GuiControlGet, IsFocusedEdit, Focus ;Gets name of focused control
    GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit% ;Gets Hwnd of focused control

    while(A_TickCount - _starttime < TimeUntilInactive && GetKeyState("Enter") != 1 && IsFocusedHwnd = EditControlHwnd){    ;while enter is not pressed and control is focused and content is changed before time is zero

        GuiControlGet, UpdatedEditContent ,, %EditControlHwnd% ;Get from edit
        if(InitialEditContent != UpdatedEditContent){ ;If content is different from initial content -> reset timer
            _starttime := A_TickCount
        }
        InitialEditContent := UpdatedEditContent

        GuiControlGet, IsFocusedEdit, Focus ;gets hwnd of focused control
        GuiControlGet, IsFocusedHwnd, Hwnd, %IsFocusedEdit% ;^
    }
    
    return false
}

UnfocusEverything(InvisibleButtonHwnd){     ;Sets focus to invisible button and unfocuses every visible control as result
    ControlFocus,, % "ahk_id" InvisibleButtonHwnd
}

SetUpDown(UpDownHandle, BuddyHandle, UpDownWidth) {
  ControlGetPos, x, y, w, h,, ahk_id %BuddyHandle%
  GuiControl, Move, %BuddyHandle%, % "w " w + 16 ; Idk why but without doing this, the SendMessage below will mess up this control's width.
  SendMessage, 0x469, BuddyHandle, 0, , ahk_id %UpDownHandle% ; Change UpDown's buddy
  GuiControl, Move,  %UpDownHandle%, w%UpDownWidth% ; Seems required since it gets resized after changing it's buddy.
  Sleep, 0 ; Helps WinSet Redraw a bit i think?
  WinSet, Redraw,, ahk_id %UpDownHandle% ; Fixes "graphical glitches" after chainging buddy. (Rarely messes up)
}

HasNoNumber(Input){
    DidgetsArray := StrSplit(Input)
    loop, % DidgetsArray.Count(){
        if(IsNumber(DidgetsArray[A_Index])){
            return false
        }
    }
    return true
}

IfMergingOfArrayObjectsIs(InputArray,ExpectedResult := ""){
    LoopVar:=1
    if(!IsNumber(InputArray[1])){
        LoopVar:= 2
    }
    AddVar := ""
    loop, % InputArray.Count(){
        AddVar .= InputArray[LoopVar]
        LoopVar++
    }
    if(AddVar = ExpectedResult){
        return true
    }
    else if(AddVar != ExpectedResult){
        return false
    }
    else if(ExpectedResult = ""){
        return AddVar
    }
}