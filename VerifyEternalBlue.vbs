' Checks if the computer is vulnerable to EternalBlue
'
'	Author: Cassius Puodzius

Dim KBList
Set KBList = CreateObject("System.Collections.ArrayList")

KBList.Add "3177186"
KBList.Add "3205401"
KBList.Add "3205409"
KBList.Add "3210720"
KBList.Add "3210721"
KBList.Add "3212646"
KBList.Add "3213986"
KBList.Add "4012212"
KBList.Add "4012213"
KBList.Add "4012214"
KBList.Add "4012215"
KBList.Add "4012216"
KBList.Add "4012217"
KBList.Add "4012598"
KBList.Add "4012606"
KBList.Add "4013198"
KBList.Add "4013429"

Set WshShell = CreateObject("WScript.Shell")

CreateObject("WScript.Shell").Popup "Fetching list of installed KBs", 5, "Vulnerable to EternalBlue?", vbOKOnly

'Dim HotFixList : Set HotFixList = WshShell.Exec("wmic qfe list")
WshShell.Run "cmd /c wmic qfe list | clip", 0, True

For Each kb In KBList
	If InStr(CreateObject("htmlfile").ParentWindow.ClipboardData.GetData("text"), "KB" + kb) = 0 Then
		MsgBox("Your computer is patched against EternalBlue")
		WScript.Quit
	End If
Next

MsgBox("Your computer is NOT patched agaist EternalBlue")