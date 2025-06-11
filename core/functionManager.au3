; dans macroEditor
Func _BoolToCheck($b)
    Return $b ? $GUI_CHECKED : $GUI_UNCHECKED
EndFunc

; dans uiManager
Func _setCharacterList()
	GUICtrlSetData($cbChar, _ArrayToString($aChars, "|", 1), $aChars[1])
EndFunc
