HTTPDownload "https://test.com/test.jpg", "C:\"

Sub HTTPDownload(myURL, myPath)
    Dim i, objFile, objFSO, objHTTP, strFile, strMsg

    ' Create a File System Object
    Set objFSO = CreateObject( "Scripting.FileSystemObject" )
    strFile = objFSO.BuildPath(myPath, Mid( myURL, InStrRev(myURL, "/") + 1) )

    ' Create or open the target file
    Set objFile = objFSO.OpenTextFile( strFile, 2, True )

    ' Create an HTTP object
    Set objHTTP = CreateObject( "WinHttp.WinHttpRequest.5.1" )

    ' Download the specified URL
    objHTTP.Open "GET", myURL, False
    objHTTP.Send

    ' Write the downloaded byte stream to the target file
    For i = 1 To LenB( objHTTP.ResponseBody )
        objFile.Write Chr( AscB( MidB( objHTTP.ResponseBody, i, 1 ) ) )
    Next

    ' Close the target file
    objFile.Close( )
End Sub