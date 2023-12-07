Option Explicit
Dim xmlDoc, objNode
Dim strFile 
Dim strAttValue, strAttTittle


strAttValue = "1000000000.00"
strAttTittle = "CashIn"

' Path to your xml file
strFile = "path/to/file.xml"

' Create an xml Documment object and load your file
Set xmlDoc =  CreateObject("Microsoft.XMLDOM")
xmlDoc.Async = "False"
xmlDoc.Load  strFile


' Find the accounts/a0/name node
Set objNode = xmlDoc.SelectSingleNode("Config/AmountLimit")
' Test that a node was returned

If Not objNode Is Nothing Then
    'objNode.Text = strAttValue
    objNode.setAttribute strAttTittle,strAttValue
End If

' Save the changes
xmlDoc.Save strFile

' Clean up
If Not objNode Is Nothing Then
    Set objNode = Nothing
End If

Set xmlDoc = Nothing