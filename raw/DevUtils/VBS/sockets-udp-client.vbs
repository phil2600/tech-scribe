On Error Resume Next
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
 
Set Sock = CreateObject("MSWinsock.Winsock")
Dim Login
HOST = InputBox("Veuillez saisir l'adress IP ou le nom d'hôte de l'interlocuteur")
If HOST <> VbNullString Then If Connect(HOST) Then If UserRegistration Then SendMessage
 
Function Connect(HOST)
Dim SckData
Dim Result
SckData = VbNullString
Result = False
Sock.Protocol = 1
Sock.RemotePort = 32520
Sock.RemoteHost = HOST
Sock.SendData "HELLO"
Cur_Time = Time
Tempo = 5
Do While Tempo > 0
   If Cur_Time <> Time Then
      Cur_Time = Time
      Tempo = Tempo - 1
   End If
   Sock.GetData SckData
   If SckData = "OK" Then
      MsgBox "Connection Etablie",vbokonly
      Result = True
      Exit Do
   End If
Loop
If Not Result Then MsgBox "Connection Impossible !"
Connect = Result
End Function
 
Function UserRegistration()
Login = InputBox("Veuillez Entrer votre Pseudo:" & VbCrlf & "Annuler = Quitter")
If Login = VbNullString Then
   UserRegistration = False
Else
   UserRegistration = True
End If
End Function
 
Sub SendMessage()
Do
   Message = InputBox("Veuillez Saisir le message a envoyer." & VbCrLf & "Le Message QUIT permet de quitter l'application")
   If Message = "QUIT" Then
      Sock.Close
      Sock.RemoteHost = "LocalHost"
      Sock.SendData "QUIT"
      Sock.Close
      Sock.RemoteHost = HOST
      Sock.SendData LoGin & Chr(0) & Chr(1)
      Exit Sub
   Else
      Sock.SendData Login & Chr(0) & Message
   End If
Loop
End Sub
