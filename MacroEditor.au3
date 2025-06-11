#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <ListBoxConstants.au3>
#include <File.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
#include <TabConstants.au3>
#include <StringConstants.au3>
#include <WinAPI.au3>
#include <Misc.au3>
#include <libs/Json.au3> ; nécessite JSON.au3 d'UDF et BinaryCall.au3

#include "core/iniManager.au3"
#include "core/readfolder.au3"
#include "core/uiManager.au3"
#include "core/functionManager.au3"

; Variables JSON
Local $sLoadedChar = "", $oKeyMap = Null, $sCurrentAction = ""

While 1
	If WinActive($AppTitle) Then
	    ;Local $aKey = GUIGetCursorInfo()
	    ;Local $key = ""
		
	    ;For $i = 1 To 255			
		;	If _IsPressed(Hex($i, 2)) Then
		;		$key = Chr($i)
		;		if $key = "" Then
		;			$key=0
		;		EndIf
		;		GUICtrlSetData($inpKey, $key)
		;		GUICtrlSetData($inpCode, $i)
		;		ExitLoop
		;	EndIf
	    ;Next
	EndIf
	
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit

        Case $btnCharger
            $sLoadedChar = GUICtrlRead($cbChar)
            If $sLoadedChar = "" Then MsgBox(48, "Attention", "Sélectionne un personnage."): ContinueLoop

            ; Charger CharacterSettings.json
            Local $pathChar = $CharacterPath & "\" & $sLoadedChar & "\CharacterSettings.json"
            If FileExists($pathChar) Then
                GUICtrlSetData($editRaw, FileRead($pathChar))
            EndIf

            ; Charger KeyMapping.json
            Local $pathKey = $CharacterPath & "\" & $sLoadedChar & "\KeyMapping.json"
            If FileExists($pathKey) Then
                Local $sKeyJSON = FileRead($pathKey)
                $oKeyMap = Json_Decode($sKeyJSON)
                GUICtrlSetData($lstKeys, "coucou")
                For $k In Json_ObjGetKeys($oKeyMap)
                    GUICtrlSetData($lstKeys, $k)
                Next
            EndIf

       Case $lstKeys
            If $oKeyMap = Null Then ContinueLoop
            $sCurrentAction = GUICtrlRead($lstKeys)
            If $sCurrentAction = "" Then ContinueLoop
				
            Local $action = Json_ObjGet($oKeyMap, $sCurrentAction)
			Local $keyCode = Json_ObjGet($action, "Key")
			GUICtrlSetData($inpKey,Chr($keyCode) )
			GUICtrlSetData($inpCode, $keyCode)
            GUICtrlSetState($chkCtrl, _BoolToCheck(Json_ObjGet($action, "Ctrl")))
            GUICtrlSetState($chkShft, _BoolToCheck(Json_ObjGet($action, "Shft")))
            GUICtrlSetState($chkAlt, _BoolToCheck(Json_ObjGet($action, "Alt")))
            GUICtrlSetState($chkIgnore, _BoolToCheck(Json_ObjGet($action, "IgnoreModifiers")))

        Case $btnSaveKey
            If $sCurrentAction = "" Or $oKeyMap = Null Then ContinueLoop
            Local $action = Json_ObjGet($oKeyMap, $sCurrentAction)
			
			Json_ObjPut($action, "Key", GUICtrlRead($inpCode))
			;Json_ObjPut($action, "KeyChar", GUICtrlRead($inpKey)) ; facultatif, pour garder une trace de la lettre
	    
            Json_ObjPut($action, "Ctrl", GUICtrlRead($chkCtrl) = $GUI_CHECKED)
            Json_ObjPut($action, "Shft", GUICtrlRead($chkShft) = $GUI_CHECKED)
            Json_ObjPut($action, "Alt", GUICtrlRead($chkAlt) = $GUI_CHECKED)
            Json_ObjPut($action, "IgnoreModifiers", GUICtrlRead($chkIgnore) = $GUI_CHECKED)
            Json_ObjPut($oKeyMap, $sCurrentAction, $action)

            ; Sauvegarde
            Local $savePath = $CharacterPath & "\" & $sLoadedChar & "\KeyMapping.json"
            FileCopy($savePath, $savePath & "_" & @MDay & "-" & @Mon & "-" & @Year & "_" & @HOUR & "h" & @MIN & "m" & @SEC & ".bak", 9)
            FileDelete($savePath)
            FileWrite($savePath, Json_Encode($oKeyMap, 1))
            MsgBox(64, "Sauvegardé", "Action enregistrée. avec sauvegarde en .bak")

    EndSwitch
WEnd
