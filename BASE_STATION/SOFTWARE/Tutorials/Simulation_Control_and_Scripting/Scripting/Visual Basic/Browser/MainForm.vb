Public Class MainForm
    Inherits System.Windows.Forms.Form
    Private App As GENESYS.Application
    Private RootItem As GENESYS.Item
    Private SelectedItem As GENESYS.Item
    Private strProduct As String


#Region " Windows Form Designer generated code "

    Public Sub New()
        MyBase.New()

        'This call is required by the Windows Form Designer.
        InitializeComponent()

        'Add any initialization after the InitializeComponent() call

    End Sub

    'Form overrides dispose to clean up the component list.
    Protected Overloads Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    Friend WithEvents Panel As System.Windows.Forms.Panel
    Friend WithEvents ItemListBox As System.Windows.Forms.ListBox
    Friend WithEvents MethodListBox As System.Windows.Forms.ListBox
    Friend WithEvents ItemTextBox As System.Windows.Forms.TextBox
    Friend WithEvents UpBtn As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents VarNameListBox As System.Windows.Forms.ListBox
    Friend WithEvents ToTop As System.Windows.Forms.Button
    Friend WithEvents RefreshBtn As System.Windows.Forms.Button
    Friend WithEvents ContextCombo As System.Windows.Forms.ComboBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Execute As System.Windows.Forms.Button
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.ToTop = New System.Windows.Forms.Button
        Me.Panel = New System.Windows.Forms.Panel
        Me.Execute = New System.Windows.Forms.Button
        Me.Label5 = New System.Windows.Forms.Label
        Me.ContextCombo = New System.Windows.Forms.ComboBox
        Me.RefreshBtn = New System.Windows.Forms.Button
        Me.UpBtn = New System.Windows.Forms.Button
        Me.ItemTextBox = New System.Windows.Forms.TextBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.ItemListBox = New System.Windows.Forms.ListBox
        Me.VarNameListBox = New System.Windows.Forms.ListBox
        Me.MethodListBox = New System.Windows.Forms.ListBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Panel.SuspendLayout()
        Me.SuspendLayout()
        '
        'ToTop
        '
        Me.ToTop.Location = New System.Drawing.Point(536, 51)
        Me.ToTop.Name = "ToTop"
        Me.ToTop.Size = New System.Drawing.Size(96, 23)
        Me.ToTop.TabIndex = 5
        Me.ToTop.Text = "Go To Root"
        '
        'Panel
        '
        Me.Panel.Controls.Add(Me.Execute)
        Me.Panel.Controls.Add(Me.Label5)
        Me.Panel.Controls.Add(Me.ContextCombo)
        Me.Panel.Controls.Add(Me.RefreshBtn)
        Me.Panel.Controls.Add(Me.UpBtn)
        Me.Panel.Controls.Add(Me.ItemTextBox)
        Me.Panel.Controls.Add(Me.ToTop)
        Me.Panel.Controls.Add(Me.Label4)
        Me.Panel.Dock = System.Windows.Forms.DockStyle.Top
        Me.Panel.Location = New System.Drawing.Point(0, 0)
        Me.Panel.Name = "Panel"
        Me.Panel.Size = New System.Drawing.Size(709, 80)
        Me.Panel.TabIndex = 6
        '
        'Execute
        '
        Me.Execute.Location = New System.Drawing.Point(318, 51)
        Me.Execute.Name = "Execute"
        Me.Execute.Size = New System.Drawing.Size(96, 23)
        Me.Execute.TabIndex = 17
        Me.Execute.Text = "Execute Method"
        '
        'Label5
        '
        Me.Label5.Location = New System.Drawing.Point(22, 50)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(56, 23)
        Me.Label5.TabIndex = 16
        Me.Label5.Text = "Context:"
        Me.Label5.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'ContextCombo
        '
        Me.ContextCombo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.ContextCombo.Items.AddRange(New Object() {"Application.Manager", "Application.Menu", "Application.StdMenu"})
        Me.ContextCombo.Location = New System.Drawing.Point(91, 51)
        Me.ContextCombo.Name = "ContextCombo"
        Me.ContextCombo.Size = New System.Drawing.Size(208, 21)
        Me.ContextCombo.TabIndex = 15
        '
        'RefreshBtn
        '
        Me.RefreshBtn.Location = New System.Drawing.Point(427, 51)
        Me.RefreshBtn.Name = "RefreshBtn"
        Me.RefreshBtn.Size = New System.Drawing.Size(96, 23)
        Me.RefreshBtn.TabIndex = 14
        Me.RefreshBtn.Text = "Refresh"
        '
        'UpBtn
        '
        Me.UpBtn.Location = New System.Drawing.Point(656, 22)
        Me.UpBtn.Name = "UpBtn"
        Me.UpBtn.Size = New System.Drawing.Size(35, 23)
        Me.UpBtn.TabIndex = 7
        Me.UpBtn.Text = "Up"
        '
        'ItemTextBox
        '
        Me.ItemTextBox.Location = New System.Drawing.Point(0, 25)
        Me.ItemTextBox.Name = "ItemTextBox"
        Me.ItemTextBox.Size = New System.Drawing.Size(648, 20)
        Me.ItemTextBox.TabIndex = 6
        Me.ItemTextBox.Text = "ItemTextBox"
        '
        'Label4
        '
        Me.Label4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label4.Location = New System.Drawing.Point(8, 5)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(100, 16)
        Me.Label4.TabIndex = 13
        Me.Label4.Text = "Selected Item:"
        Me.Label4.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'ItemListBox
        '
        Me.ItemListBox.Location = New System.Drawing.Point(4, 106)
        Me.ItemListBox.Name = "ItemListBox"
        Me.ItemListBox.Size = New System.Drawing.Size(200, 316)
        Me.ItemListBox.TabIndex = 7
        '
        'VarNameListBox
        '
        Me.VarNameListBox.Location = New System.Drawing.Point(209, 106)
        Me.VarNameListBox.Name = "VarNameListBox"
        Me.VarNameListBox.Size = New System.Drawing.Size(210, 316)
        Me.VarNameListBox.TabIndex = 8
        '
        'MethodListBox
        '
        Me.MethodListBox.Location = New System.Drawing.Point(424, 106)
        Me.MethodListBox.Name = "MethodListBox"
        Me.MethodListBox.Size = New System.Drawing.Size(282, 316)
        Me.MethodListBox.TabIndex = 9
        '
        'Label1
        '
        Me.Label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label1.Location = New System.Drawing.Point(48, 86)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(100, 16)
        Me.Label1.TabIndex = 10
        Me.Label1.Text = "Item List"
        Me.Label1.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label2
        '
        Me.Label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label2.Location = New System.Drawing.Point(246, 86)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(120, 16)
        Me.Label2.TabIndex = 11
        Me.Label2.Text = "Variable List"
        Me.Label2.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'Label3
        '
        Me.Label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label3.Location = New System.Drawing.Point(512, 86)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(100, 16)
        Me.Label3.TabIndex = 12
        Me.Label3.Text = "Method List"
        Me.Label3.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'MainForm
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.ClientSize = New System.Drawing.Size(709, 431)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.MethodListBox)
        Me.Controls.Add(Me.VarNameListBox)
        Me.Controls.Add(Me.ItemListBox)
        Me.Controls.Add(Me.Panel)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.Name = "MainForm"
        Me.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Hide
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "VB Browser"
        Me.Panel.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub

#End Region

    Private Sub InitializeRootItem()
        Select Case ContextCombo.Text
            Case "Application.Manager"
                RootItem = App.Manager
            Case "Application.Menu"
                RootItem = App.Menu
            Case "Application.StdMenu"
                RootItem = App.StdMenu
        End Select

        SelectedItem = RootItem
        InitializeSelection()

    End Sub

    Private Sub MainForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        strProduct = "Keysight EDA Product"

        App = StartProduct(False)

        strProduct = App.Name
        strProduct = strProduct.Substring(0, strProduct.IndexOf(" "))

        Me.Text = "VB Browser for " & strProduct

        MsgBox("Running " & App.Name)
        App.Caption = "Test: " & strProduct & " Under Automation Control"
        App.Visible = True
        ContextCombo.SelectedIndex = 0

        InitializeRootItem()
    End Sub

    Private Function StartProduct(ByVal bForceNewInstance As Boolean) As GENESYS.Application
        If bForceNewInstance Then
OpenNewProduct:
            On Error GoTo ShowError
            StartProduct = CreateObject("GENESYS.Application")  ' Will start a New copy of GENESYS
            Exit Function
        End If

        On Error GoTo ErrFindingOpenProduct
        StartProduct = GetObject(, "GENESYS.Application")       ' Will use Open version of GENESYS
        Exit Function

ErrFindingOpenProduct:
        If Err().Number = 429 Then      ' Doesn't exist, so just start a new one
            GoTo OpenNewProduct
        End If
        ' Otherwise show error
ShowError:
        MsgBox("Error starting" & strProduct & ": " & Err.Number & " " & Err.Description, vbCritical, strProduct & " Test")
    End Function
    Private Function InitializeSelection()
        ItemTextBox.Text = GetItemHierarchy(SelectedItem)

        ' List all of the items in the workspace
        ListAllItems(SelectedItem)
        ListAllValueNames(SelectedItem)
        ListAllMethods(SelectedItem)
    End Function
    Private Function ListAllItems(ByVal Item As GENESYS.Item)
        ' ListAllItems()
        '   This function will empty the current items list and will add all 
        '   new items given the specified item
        Dim i As Integer
        Dim iMaxCount As Integer
        Dim strItemName As String
        Dim LocalItem As GENESYS.Item

        On Error GoTo ShowError

        ' List all of the items in the given item
        ItemListBox.Items.Clear()
        iMaxCount = Item.GetItemCount()
        For i = 0 To iMaxCount - 1
            LocalItem = Item.GetItemByIndex(i)
            strItemName = LocalItem.GetName()
            ItemListBox.Items.Add(strItemName)
        Next i

        Exit Function
ShowError:
        MsgBox("Error Listing Items: " & Err.Number & " " & Err.Description, vbCritical, strProduct & " Test")
    End Function
    Private Function ListAllMethods(ByVal Item As GENESYS.Item)
        ' ListAllItems()
        '   This function will empty the current items list and will add all 
        '   new items given the specified item
        Dim i As Integer
        Dim iMaxCount As Integer
        Dim strMethodDelimit As String
        Dim strMethodList As String, strMethod As String
        strMethodList = Item.GetMethodList
        MethodListBox.Items.Clear()

        On Error GoTo ShowError

        strMethodDelimit = strMethodList.Substring(0, 1)        ' Get the method list delmiter (first char in string)
        strMethodList = Trim(Mid(strMethodList, 2))
        While strMethodList <> ""
            i = InStr(strMethodList, strMethodDelimit)
            If i > 0 Then
                strMethod = strMethodList.Substring(0, i - 1)   ' Get the method name excluding the delimiter
                strMethodList = Trim(Mid(strMethodList, i + 1)) ' Remove the method name from the list including the delimiter
            Else
                strMethod = strMethodList
                strMethodList = ""
            End If
            MethodListBox.Items.Add(strMethod)
        End While


        Exit Function
ShowError:
        MsgBox("Error Listing Methods: " & Err.Number & " " & Err.Description, vbCritical, strProduct & " Test")
    End Function
    Private Function ListAllValueNames(ByVal Item As GENESYS.Item)
        ' ListAllValueNames()
        '   This function will empty the current value names list and will add all 
        '   new value names given the specified item
        Dim i As Integer
        Dim iMaxCount As Integer
        Dim strValueName As String
        Dim strValueType As String
        Dim strValue As String
        Dim Value

        On Error GoTo ShowError
        ' List all of the items in the given item
        VarNameListBox.Items.Clear()
        iMaxCount = Item.GetVarCount()
        For i = 0 To iMaxCount - 1
            strValueName = Item.GetVarName(i)   ' Get the variable name
            strValueType = Item.GetVarType(i)   ' Get the variable type
            If (strValueType.Length > 2) Then
                If ("Ar" <> strValueType.Substring(0, 2)) Then
                    Value = Item.GetVarValue(i)         ' Get the variable value
                    strValue = Value
                End If
            Else
                strValue = ""
            End If
            VarNameListBox.Items.Add(strValueName + " [" + strValueType + "] " + strValue)
        Next i

        Exit Function
ShowError:
        MsgBox("Error ListAllValueNames: " & Err.Number & " " & Err.Description, vbCritical, strProduct & " Test")
    End Function

    Private Function GetFixedItemName(ByVal Name As String) As String
        ' This function will place brackets around names with spaces in them
        Dim i As Integer, length As Integer, test As String

        length = Len(Name)
        For i = 1 To length
            test = UCase(Mid(Name, i, 1))
            If Not (test >= "A" And test <= "Z" Or test >= "1" And test <= "9" Or test = "_") Then
                GetFixedItemName = "[" + Name + "]"
                Exit Function
            End If
        Next
        GetFixedItemName = Name
    End Function
    Private Function GetItemHierarchy(ByVal Item As GENESYS.Item) As String
        ' Build a list of names in the direct upline of the given item
        Dim strHierarchy As String

        strHierarchy = ""

        While Item Is RootItem = False              ' Climb the hierarchy until we get to the root
            On Error GoTo ErrorRootChanged
            strHierarchy = GetFixedItemName(Item.GetName()) + "." + strHierarchy
            Item = RootItem.GetParentOfItem(Item)
        End While

        GetItemHierarchy = ContextCombo.Text + "." + strHierarchy
        Exit Function

ErrorRootChanged:
        MsgBox("Error finding root " & Err.Number & " " & Err.Description & " Reseting root workspace.", vbCritical, strProduct & " Test")
        InitializeRootItem()

    End Function

    Private Sub ItemListBox_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ItemListBox.Click

        On Error GoTo ShowError

        SelectedItem = SelectedItem.GetItemByName(ItemListBox.SelectedItem)

        InitializeSelection()

        Exit Sub
ShowError:
        MsgBox("Error ItemListBox Click: " & Err.Number & " " & Err.Description, vbCritical, strProduct & " Test")
    End Sub

    Private Sub UpBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles UpBtn.Click

        On Error GoTo ShowError

        SelectedItem = RootItem.GetParentOfItem(SelectedItem)
        InitializeSelection()

        Exit Sub

ShowError:
        MsgBox("Error Going Up: " & Err.Number & " " & Err.Description & ". Reloading root workspace.", vbCritical, strProduct & " Test")
        InitializeRootItem()
    End Sub

    Private Sub ToTop_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ToTop.Click
        InitializeRootItem()
    End Sub

    Private Sub RefreshBtn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RefreshBtn.Click
        InitializeSelection()
    End Sub

    Private Sub ContextCombo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ContextCombo.SelectedIndexChanged
        InitializeRootItem()
    End Sub
    Private Sub ExecuteMethod()
        Dim script As String, i As Integer

        script = MethodListBox.SelectedItem
        i = InStr(script, "=")
        If i > 0 Then
            script = "result = " + ItemTextBox.Text + Trim(Mid(script, i + 1))
        Else
            script = ItemTextBox.Text + MethodListBox.SelectedItem
        End If
        script = InputBox("Please replace any arguments with the values you want to use.", "ExecuteScript ", script)
        If script <> "" Then
            App.RunScript(script)
        End If

    End Sub

    Private Sub MethodListBox_DoubleClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles MethodListBox.DoubleClick
        ExecuteMethod()
    End Sub

    Private Sub Execute_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Execute.Click
        ExecuteMethod()
    End Sub
End Class
