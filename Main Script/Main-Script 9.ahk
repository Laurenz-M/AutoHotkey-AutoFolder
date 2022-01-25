global ConfigPath := "TestConfig.ini"
global MainGuiConfigPath := ""
global WorkingPathSectionName := "WorkingPath"
global WorkingPathKeyName := "Key"

;global SortingSettings=====

global HandlingOfEmptyFolders := "" ;contains info about "fate" of empty folders
global EmptyFoldersMoveLocation := ""
global DelayHandlingFoldersPostcreation := "" ;contains the delay between creation of folder and processing (in days)

;global WorkingPathList := WorkingPathList(ConfigPath)
;msgbox, % WorkingPathList[2]

;IniRead, CurrentWorkPath, %ConfigPath%, %WorkingPathSectionName%,%WorkingPathKeyName% ;gets value of the given section and key name
;IniRead, CurrentWorkPath, TestConfig.ini, H, h ;gets value of the given section and key name

;msgbox, % CurrentWorkPath
;msgbox, % WorkingPathCount(ConfigPath)
msgbox, % IsValidPath("C:\Users\test\Desktop\AutoFolder MAIN PROJECT FOLDER\Main AutoFolder Script")
TryPathCorrection("Hello this is a sentence with commas")
;CreateWorkingPathList(ConfigPath)[2]
;msgbox, % Array[0]
return

;LoadConfigValues(ConfigPath){

;}
LoadSortingSettings(MainGuiConfigPath){
    
}


TryPathCorrection(InputPath){
    
    ;correct spaces ======
    SpaceDelimeterArray := StrSplit(InputPath, A_Space)
    SpaceDelimeterArrayCombineString := ""
    loop, % SpaceDelimeterArray.Count(){
        SpaceDelimeterArrayCombineString .= SpaceDelimeterArray[A_Index]
    }
    if(IsValidPath(SpaceDelimeterArrayCombineString)){
        return SpaceDelimeterArrayCombineString
    }

    return 0 ;at bottom of function. Gets returned when none of the corrections work
}


IsValidPath(InputPath){

    IfExist, %InputPath%
        return 1

    return 0

}


CreateWorkingPathList(ConfigPath){

    PathCount := WorkingPathCount(ConfigPath)
    WorkingPathList := []
    static LoopVar := 0

    while(LoopVar < PathCount){


        IniRead, CurrentWorkPath, %ConfigPath%, %WorkingPathSectionName%%LoopVar%, %WorkingPathKeyName% ;gets value of the given section and key name
        /*%
        ;msgbox, % CurrentWorkPath
        IfExist, %CurrentWorkPath%
            WorkingPathList[LoopVar] := CurrentWorkPath
            ;WorkingPathList.Push(CurrentWorkPath)
        
        IfNotExist, %CurrentPath%
            WorkingPathList[LoopVar] := "ERROR"
            ;WorkingPathList.Push("ERROR")
            */
        if(IsValidPath(CurrentWorkPath)){
            
            WorkingPathList[LoopVar] := CurrentWorkPath
            continue
        }
        else{

            if(!TryPathCorrection(CurrentWorkPath)){
                WorkingPathList[LoopVar] := "ERROR|PathCorrectionFail"
            }
            else{
                WorkingPathList[LoopVar] := CurrentWorkPath "|PathCorrectionSuccess"
            }
        
        }
        ;WorkingPathList.Push(CurrentWorkPath)
        ;WorkingPathList[LoopVar] := CurrentWorkPath
        LoopVar++
    }

    return WorkingPathList
}

WorkingPathCount(ConfigPath){

    IniRead, ListAllSectionNames, %ConfigPath%
    ListAllSectionNamesArray := StrSplit(ListAllSectionNames, "`n")
    return ListAllSectionNamesArray.Count()
}