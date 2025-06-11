; GUI principale
GUICreate($AppTitle, 750, 500)

GUICtrlCreateLabel("Personnage :", 10, 10)
Local $cbChar = GUICtrlCreateCombo("", 90, 10, 200)
_setCharacterList() ; set list

Local $btnCharger = GUICtrlCreateButton("Charger", 310, 10, 100)

; Gestion Onglets
Local $tab = GUICtrlCreateTab(10, 40, 730, 440)

; Onglets 0
Local $tab0 = GUICtrlCreateTabItem("CharacterSettings.json")
Local $editRaw = GUICtrlCreateEdit("", 20, 70, 710, 370, $ES_MULTILINE + $WS_VSCROLL)

; Onglets 1
Local $tab1 = GUICtrlCreateTabItem("KeyMapping.json")
Local $lstKeys = GUICtrlCreateList("", 20, 70, 200, 370, $LBS_NOTIFY + $WS_VSCROLL)

GUICtrlCreateLabel("KeyCode :", 240, 75, 50, 20)
Local $inpCode = GUICtrlCreateInput("", 300, 70, 40, 20);, $ES_READONLY)

GUICtrlCreateLabel("Touche :", 360, 75, 60, 20)
Local $inpKey = GUICtrlCreateInput("", 430, 70, 50, 20, $ES_READONLY)

Local $checkKey = GUICtrlCreateButton("refresh le Keycode de la lettre", 500, 68, 200)

Local $chkCtrl = GUICtrlCreateCheckbox("Ctrl", 240, 100)
Local $chkShft = GUICtrlCreateCheckbox("Shft", 300, 100)
Local $chkAlt = GUICtrlCreateCheckbox("Alt", 360, 100)
Local $chkIgnore = GUICtrlCreateCheckbox("IgnoreModifiers", 420, 100)
Local $btnSaveKey = GUICtrlCreateButton("Enregistrer action", 240, 130, 180)

GUICtrlCreateTabItem("") ; fin des onglets

GUISetState()