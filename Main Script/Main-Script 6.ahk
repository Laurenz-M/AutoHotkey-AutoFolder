global ConfigPath := "TestConfig.ini"
global WorkingPathSectionName := "WorkingPath"
global WorkingPathKeyName := "Key"
;global WorkingPathList := WorkingPathList(ConfigPath)
;msgbox, % WorkingPathList[2]

;IniRead, CurrentWorkPath, %ConfigPath%, %WorkingPathSectionName%,%WorkingPathKeyName% ;gets value of the given section and key name
;IniRead, CurrentWorkPath, TestConfig.ini, H, h ;gets value of the given section and key name

;msgbox, % CurrentWorkPath
;msgbox, % WorkingPathCount(ConfigPath)
msgbox, % WorkingPathList(ConfigPath)[0]
;msgbox, % Array[0]
return

;LoadConfigValues(ConfigPath){

;}






WorkingPathList(ConfigPath){

    PathCount := WorkingPathCount(ConfigPath)
    WorkingPathList := []
    static LoopVar := 0

    while(LoopVar < PathCount){

        IniRead, CurrentWorkPath, %ConfigPath%, %WorkingPathSectionName%%LoopVar%, %WorkingPathKeyName% ;gets value of the given section and key name
        ;msgbox, % CurrentWorkPath
        IfExist, %CurrentWorkPath%
            WorkingPathList[LoopVar] := CurrentWorkPath
            ;WorkingPathList.Push(CurrentWorkPath)
        
        IfNotExist, %CurrentPath%
            WorkingPathList[LoopVar] := "ERROR"
            ;WorkingPathList.Push("ERROR")
        
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