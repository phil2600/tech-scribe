'On Error Resume Next
'*********************************
'*********************************
'**
'**  SCRIPT DEVELOPPE PAR K@ZUYA
'**  ---------------------------
'**  http://www.kazuya.chez.tiscali.fr/index.php
'**  -------------------------------------------
'**  Samedi 27 Décembre 2003
'**  13 h 02
'**
'*********************************
'*********************************
 
GetMessages()
sub GetMessages()
MsgBox "RECEPTION DES MESSAGES EN COURS"
SckData = VbNullstring
set UDP_SERVER = CreateObject("MSWinsock.Winsock")
UDP_SERVER.Protocol = 1
UDP_SERVER.LocalPort = 32520
UDP_SERVER.Bind
Do
   UDP_SERVER.Getdata SckData
   If SckData <> VbNullString Then
      Reply = Split(SckData,Chr(0))
      If Ubound(Reply) = 1 Then
         If Reply(1) = Chr(1) Then
            MsgBox Reply(0) & " S'est Déconnecté !"
            UDP_SERVER.Close
            UDP_SERVER.Bind
         Else
            MsgBox Reply(1),vbokonly,Reply(0)
         End If
      ElseIf SckData = "HELLO" Then
         UDP_SERVER.Senddata "OK"
      ElseIf SckData = "QUIT" Then
         Exit Do
      End If
      SckData = VbNullString
   End If
Loop
MsgBox "FIN DE RECEPTION DES MESSAGES"
End Sub