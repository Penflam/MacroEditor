If Not FileExists($CharacterPath) Then MsgBox(16, "Erreur", "Dossier invalide"): Exit
Global $aChars = _FileListToArray($CharacterPath, "*", 2)
If @error Then MsgBox(16, "Erreur", "Aucun personnage trouvé."): Exit