Global $sIniPath = @ScriptDir & ".\ini.ini"
Global $UserName = @UserName
Global $RepFolder = IniRead($sIniPath, "Path", "RepFolder", "")
$RepFolder = StringReplace($RepFolder, "xfolderx", @UserName)

Global $CharacterPath = IniRead($sIniPath, "Path", "CharacterFolder", "")

$CharacterPath = $RepFolder  & $CharacterPath

Global $AppTitle = IniRead($sIniPath, "Path", "AppTitle", "Éditeur JSON - Macro")
