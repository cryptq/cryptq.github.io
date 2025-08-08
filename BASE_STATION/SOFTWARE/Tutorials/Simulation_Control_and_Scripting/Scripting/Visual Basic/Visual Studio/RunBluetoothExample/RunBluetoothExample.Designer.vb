<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Main_Window
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim ChartArea1 As System.Windows.Forms.DataVisualization.Charting.ChartArea = New System.Windows.Forms.DataVisualization.Charting.ChartArea()
        Dim Legend1 As System.Windows.Forms.DataVisualization.Charting.Legend = New System.Windows.Forms.DataVisualization.Charting.Legend()
        Me.ClearBluetoothData_Button = New System.Windows.Forms.Button()
        Me.RunBluetoothExample_Button = New System.Windows.Forms.Button()
        Me.Chart1 = New System.Windows.Forms.DataVisualization.Charting.Chart()
        Me.TextBox1 = New System.Windows.Forms.TextBox()
        Me.Check_Visible = New System.Windows.Forms.CheckBox()
        Me.Close_Button = New System.Windows.Forms.Button()
        CType(Me.Chart1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'ClearBluetoothData_Button
        '
        Me.ClearBluetoothData_Button.Location = New System.Drawing.Point(32, 19)
        Me.ClearBluetoothData_Button.Margin = New System.Windows.Forms.Padding(2)
        Me.ClearBluetoothData_Button.Name = "ClearBluetoothData_Button"
        Me.ClearBluetoothData_Button.Size = New System.Drawing.Size(124, 35)
        Me.ClearBluetoothData_Button.TabIndex = 1
        Me.ClearBluetoothData_Button.Text = "Clear Bluetooth Data"
        Me.ClearBluetoothData_Button.UseVisualStyleBackColor = True
        '
        'RunBluetoothExample_Button
        '
        Me.RunBluetoothExample_Button.Location = New System.Drawing.Point(32, 74)
        Me.RunBluetoothExample_Button.Margin = New System.Windows.Forms.Padding(2)
        Me.RunBluetoothExample_Button.Name = "RunBluetoothExample_Button"
        Me.RunBluetoothExample_Button.Size = New System.Drawing.Size(124, 35)
        Me.RunBluetoothExample_Button.TabIndex = 2
        Me.RunBluetoothExample_Button.Text = "Run Bluetooth Example"
        Me.RunBluetoothExample_Button.UseVisualStyleBackColor = True
        '
        'Chart1
        '
        ChartArea1.Name = "ChartArea1"
        Me.Chart1.ChartAreas.Add(ChartArea1)
        Legend1.Name = "Legend1"
        Me.Chart1.Legends.Add(Legend1)
        Me.Chart1.Location = New System.Drawing.Point(32, 138)
        Me.Chart1.Margin = New System.Windows.Forms.Padding(2)
        Me.Chart1.Name = "Chart1"
        Me.Chart1.Size = New System.Drawing.Size(578, 276)
        Me.Chart1.TabIndex = 3
        Me.Chart1.Text = "Chart1"
        '
        'TextBox1
        '
        Me.TextBox1.Location = New System.Drawing.Point(251, 19)
        Me.TextBox1.Margin = New System.Windows.Forms.Padding(2)
        Me.TextBox1.Multiline = True
        Me.TextBox1.Name = "TextBox1"
        Me.TextBox1.Size = New System.Drawing.Size(359, 90)
        Me.TextBox1.TabIndex = 4
        Me.TextBox1.Text = "Tutorial Example: Running a Script from Visual Basic" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "This example shows how yo" & _
    "u can control SystemVue with Visual Basic and import data into a VB application." & _
    "" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10)
        '
        'Check_Visible
        '
        Me.Check_Visible.AutoSize = True
        Me.Check_Visible.Location = New System.Drawing.Point(32, 430)
        Me.Check_Visible.Name = "Check_Visible"
        Me.Check_Visible.Size = New System.Drawing.Size(112, 17)
        Me.Check_Visible.TabIndex = 5
        Me.Check_Visible.Text = "SystemVue Visible"
        Me.Check_Visible.UseVisualStyleBackColor = True
        '
        'Close_Button
        '
        Me.Close_Button.Anchor = System.Windows.Forms.AnchorStyles.None
        Me.Close_Button.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Close_Button.Location = New System.Drawing.Point(543, 430)
        Me.Close_Button.Name = "Close_Button"
        Me.Close_Button.Size = New System.Drawing.Size(67, 23)
        Me.Close_Button.TabIndex = 1
        Me.Close_Button.Text = "Close"
        '
        'Main_Window
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.CancelButton = Me.Close_Button
        Me.ClientSize = New System.Drawing.Size(625, 465)
        Me.Controls.Add(Me.Close_Button)
        Me.Controls.Add(Me.Check_Visible)
        Me.Controls.Add(Me.TextBox1)
        Me.Controls.Add(Me.Chart1)
        Me.Controls.Add(Me.RunBluetoothExample_Button)
        Me.Controls.Add(Me.ClearBluetoothData_Button)
        Me.DoubleBuffered = True
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "Main_Window"
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "RunBluetoothExample"
        CType(Me.Chart1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents ClearBluetoothData_Button As System.Windows.Forms.Button
    Friend WithEvents RunBluetoothExample_Button As System.Windows.Forms.Button
    Friend WithEvents Chart1 As System.Windows.Forms.DataVisualization.Charting.Chart
    Friend WithEvents TextBox1 As System.Windows.Forms.TextBox
    Friend WithEvents Check_Visible As System.Windows.Forms.CheckBox
    Friend WithEvents Close_Button As System.Windows.Forms.Button

End Class
