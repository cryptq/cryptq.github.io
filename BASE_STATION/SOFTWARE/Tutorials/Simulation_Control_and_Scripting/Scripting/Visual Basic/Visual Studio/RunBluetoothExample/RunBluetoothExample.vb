Imports System.Windows.Forms

Public Class Main_Window
    Public SystemVueApp As GENESYS.Application
    Dim bVisible As Boolean = False

    Private Sub Close_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Close_Button.Click
        Me.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Close()
    End Sub

    Private Sub Check_Visible_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles Check_Visible.CheckedChanged
        bVisible = Not bVisible
        If SystemVueApp IsNot Nothing Then
            SystemVueApp.Visible = bVisible
        End If
    End Sub

    Private Sub ClearBluetoothData_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ClearBluetoothData_Button.Click
        Chart1.Series.RemoveAt(1)
        Chart1.Series.RemoveAt(0)
    End Sub

    Private Sub RunBluetoothExample_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RunBluetoothExample_Button.Click
        RunBluetoothExample()
    End Sub

    Private Sub RunBluetoothExample()
        Dim vbScript As GENESYS.ScriptLanguage
        Dim WorkspaceDoc As GENESYS.Workspace
        Dim S1 As Double(), S1_Time As Double()
        Dim S2 As Double(), S2_Time As Double()

        vbScript = GENESYS.ScriptLanguage.genLangVBScript

        'Start SystemVue
        If SystemVueApp Is Nothing Then
            SystemVueApp = New GENESYS.Application()
        End If

        SystemVueApp.Visible = bVisible

        'Run Bluetooth.wsv example in Systemvue.
        SystemVueApp.RunScript("FileOpenExample(""Comms\Bluetooth.wsv"")", vbScript)
        WorkspaceDoc = SystemVueApp.Manager.GetWorkspaceByIndex(0)
#If PLATFORM = "x86" Then
        Dim path = SystemVueApp.Manager.GetExeDir()
        WorkspaceDoc.SetEqnWorkingDir(path) 'needed for x86 configuration only
#End If
        WorkspaceDoc.Analyses.DF1.RunAnalysis()

        'Retrieve data from Systemvue
        S1 = WorkspaceDoc.Analyses.DF1_Data.Eqns.VarBlock.S1.GetValue()
        S1_Time = WorkspaceDoc.Analyses.DF1_Data.Eqns.VarBlock.S1_Time.GetValue()
        S2 = WorkspaceDoc.Analyses.DF1_Data.Eqns.VarBlock.S2.GetValue()
        S2_Time = WorkspaceDoc.Analyses.DF1_Data.Eqns.VarBlock.S2_Time.GetValue()

        'Create chart
        If Chart1.Series.Count = 0 Then
            Chart1.Series.Add("S1")
            Chart1.Series("S1").ChartType = DataVisualization.Charting.SeriesChartType.Line
            Chart1.Series("S1").Name() = "S1"

            Chart1.Series.Add("S2")
            Chart1.Series("S2").ChartType = DataVisualization.Charting.SeriesChartType.Line
            Chart1.Series("S2").Name() = "S2"
        End If

        'Display data
        For i = 0 To 2499
            Chart1.Series(0).Points.AddXY(S1_Time(i), S1(i))
            Chart1.Series(1).Points.AddXY(S2_Time(i), S2(i))
        Next i

        Exit Sub
Err_Handler:
        MsgBox(Err.Description, vbCritical, "Error: " & Err.Number)
    End Sub

    Private Sub Main_Window_Unload(sender As System.Object, e As System.EventArgs) Handles MyBase.FormClosing
        If SystemVueApp IsNot Nothing Then
            SystemVueApp.Quit()
        End If
    End Sub
End Class
