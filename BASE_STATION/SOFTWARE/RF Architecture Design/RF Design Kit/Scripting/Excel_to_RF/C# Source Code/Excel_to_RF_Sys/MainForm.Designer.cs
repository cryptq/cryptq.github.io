namespace Excel_Form
{
    partial class ExceltoSpectrasys
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.richTextBox1 = new System.Windows.Forms.RichTextBox();
            this.WriteDataButton = new System.Windows.Forms.Button();
            this.IP2 = new System.Windows.Forms.Label();
            this.ReadDataButton = new System.Windows.Forms.Button();
            this.DataGroup = new System.Windows.Forms.GroupBox();
            this.helpButton = new System.Windows.Forms.Button();
            this.StageNameText = new System.Windows.Forms.TextBox();
            this.StageNamecheck = new System.Windows.Forms.CheckBox();
            this.StartRowColumnLabel = new System.Windows.Forms.Label();
            this.StopRowColumnLabel = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.RowColumnRefStart = new System.Windows.Forms.TextBox();
            this.NF_check = new System.Windows.Forms.CheckBox();
            this.Input_Ref = new System.Windows.Forms.CheckBox();
            this.RowColumnRefStop = new System.Windows.Forms.TextBox();
            this.IP2_ref = new System.Windows.Forms.TextBox();
            this.IP2_check = new System.Windows.Forms.CheckBox();
            this.IndexLabel = new System.Windows.Forms.Label();
            this.IP3_ref = new System.Windows.Forms.TextBox();
            this.P1dB_check = new System.Windows.Forms.CheckBox();
            this.PSat_ref = new System.Windows.Forms.TextBox();
            this.IP3_check = new System.Windows.Forms.CheckBox();
            this.P1dB_ref = new System.Windows.Forms.TextBox();
            this.PSat_check = new System.Windows.Forms.CheckBox();
            this.DataGroupRowColumnLabel = new System.Windows.Forms.Label();
            this.Gain = new System.Windows.Forms.TextBox();
            this.noiseFigure = new System.Windows.Forms.TextBox();
            this.RadioGroup = new System.Windows.Forms.GroupBox();
            this.RowsButton = new System.Windows.Forms.RadioButton();
            this.ColumnsButton = new System.Windows.Forms.RadioButton();
            this.DataGroup.SuspendLayout();
            this.RadioGroup.SuspendLayout();
            this.SuspendLayout();
            // 
            // richTextBox1
            // 
            this.richTextBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.richTextBox1.Location = new System.Drawing.Point(0, 324);
            this.richTextBox1.Name = "richTextBox1";
            this.richTextBox1.ReadOnly = true;
            this.richTextBox1.Size = new System.Drawing.Size(397, 116);
            this.richTextBox1.TabIndex = 30;
            this.richTextBox1.Text = "";
            // 
            // WriteDataButton
            // 
            this.WriteDataButton.Enabled = false;
            this.WriteDataButton.Location = new System.Drawing.Point(281, 16);
            this.WriteDataButton.Name = "WriteDataButton";
            this.WriteDataButton.Size = new System.Drawing.Size(86, 63);
            this.WriteDataButton.TabIndex = 19;
            this.WriteDataButton.Text = "Select and Run Workspace";
            this.WriteDataButton.UseVisualStyleBackColor = true;
            this.WriteDataButton.Click += new System.EventHandler(this.WriteDataButton_Click);
            // 
            // IP2
            // 
            this.IP2.AutoSize = true;
            this.IP2.Location = new System.Drawing.Point(33, 227);
            this.IP2.Name = "IP2";
            this.IP2.Size = new System.Drawing.Size(0, 13);
            this.IP2.TabIndex = 27;
            // 
            // ReadDataButton
            // 
            this.ReadDataButton.Location = new System.Drawing.Point(189, 16);
            this.ReadDataButton.Name = "ReadDataButton";
            this.ReadDataButton.Size = new System.Drawing.Size(86, 63);
            this.ReadDataButton.TabIndex = 18;
            this.ReadDataButton.Text = "Read Excel data";
            this.ReadDataButton.UseVisualStyleBackColor = true;
            this.ReadDataButton.Click += new System.EventHandler(this.ReadDataButton_Click_1);
            // 
            // DataGroup
            // 
            this.DataGroup.CausesValidation = false;
            this.DataGroup.Controls.Add(this.helpButton);
            this.DataGroup.Controls.Add(this.StageNameText);
            this.DataGroup.Controls.Add(this.StageNamecheck);
            this.DataGroup.Controls.Add(this.StartRowColumnLabel);
            this.DataGroup.Controls.Add(this.StopRowColumnLabel);
            this.DataGroup.Controls.Add(this.label3);
            this.DataGroup.Controls.Add(this.RowColumnRefStart);
            this.DataGroup.Controls.Add(this.NF_check);
            this.DataGroup.Controls.Add(this.Input_Ref);
            this.DataGroup.Controls.Add(this.RowColumnRefStop);
            this.DataGroup.Controls.Add(this.IP2_ref);
            this.DataGroup.Controls.Add(this.IP2_check);
            this.DataGroup.Controls.Add(this.IndexLabel);
            this.DataGroup.Controls.Add(this.IP3_ref);
            this.DataGroup.Controls.Add(this.P1dB_check);
            this.DataGroup.Controls.Add(this.PSat_ref);
            this.DataGroup.Controls.Add(this.IP3_check);
            this.DataGroup.Controls.Add(this.P1dB_ref);
            this.DataGroup.Controls.Add(this.PSat_check);
            this.DataGroup.Controls.Add(this.DataGroupRowColumnLabel);
            this.DataGroup.Controls.Add(this.Gain);
            this.DataGroup.Controls.Add(this.noiseFigure);
            this.DataGroup.Location = new System.Drawing.Point(9, 93);
            this.DataGroup.Name = "DataGroup";
            this.DataGroup.Size = new System.Drawing.Size(313, 215);
            this.DataGroup.TabIndex = 36;
            this.DataGroup.TabStop = false;
            this.DataGroup.Text = "Spreadsheet Information";
            // 
            // helpButton
            // 
            this.helpButton.Location = new System.Drawing.Point(257, 186);
            this.helpButton.Name = "helpButton";
            this.helpButton.Size = new System.Drawing.Size(50, 23);
            this.helpButton.TabIndex = 20;
            this.helpButton.Text = "Help";
            this.helpButton.UseVisualStyleBackColor = true;
            this.helpButton.Click += new System.EventHandler(this.helpButton_Click);
            // 
            // StageNameText
            // 
            this.StageNameText.Location = new System.Drawing.Point(97, 170);
            this.StageNameText.Name = "StageNameText";
            this.StageNameText.Size = new System.Drawing.Size(51, 20);
            this.StageNameText.TabIndex = 14;
            this.StageNameText.TextChanged += new System.EventHandler(this.StageNameText_TextChanged);
            // 
            // StageNamecheck
            // 
            this.StageNamecheck.AutoSize = true;
            this.StageNamecheck.Location = new System.Drawing.Point(10, 172);
            this.StageNamecheck.Name = "StageNamecheck";
            this.StageNamecheck.Size = new System.Drawing.Size(93, 17);
            this.StageNamecheck.TabIndex = 26;
            this.StageNamecheck.Text = "Stage Names:";
            this.StageNamecheck.UseVisualStyleBackColor = true;
            // 
            // StartRowColumnLabel
            // 
            this.StartRowColumnLabel.AutoSize = true;
            this.StartRowColumnLabel.Location = new System.Drawing.Point(174, 36);
            this.StartRowColumnLabel.Name = "StartRowColumnLabel";
            this.StartRowColumnLabel.Size = new System.Drawing.Size(57, 13);
            this.StartRowColumnLabel.TabIndex = 18;
            this.StartRowColumnLabel.Text = "Start Row:";
            // 
            // StopRowColumnLabel
            // 
            this.StopRowColumnLabel.AutoSize = true;
            this.StopRowColumnLabel.Location = new System.Drawing.Point(174, 58);
            this.StopRowColumnLabel.Name = "StopRowColumnLabel";
            this.StopRowColumnLabel.Size = new System.Drawing.Size(57, 13);
            this.StopRowColumnLabel.TabIndex = 19;
            this.StopRowColumnLabel.Text = "Stop Row:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(27, 39);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(32, 13);
            this.label3.TabIndex = 9;
            this.label3.Text = "Gain:";
            // 
            // RowColumnRefStart
            // 
            this.RowColumnRefStart.Location = new System.Drawing.Point(248, 32);
            this.RowColumnRefStart.Name = "RowColumnRefStart";
            this.RowColumnRefStart.Size = new System.Drawing.Size(50, 20);
            this.RowColumnRefStart.TabIndex = 16;
            this.RowColumnRefStart.TextChanged += new System.EventHandler(this.RowColumnRefStart_TextChanged);
            // 
            // NF_check
            // 
            this.NF_check.AutoSize = true;
            this.NF_check.Location = new System.Drawing.Point(9, 57);
            this.NF_check.Name = "NF_check";
            this.NF_check.Size = new System.Drawing.Size(88, 17);
            this.NF_check.TabIndex = 21;
            this.NF_check.Text = "Noise Figure:";
            this.NF_check.UseVisualStyleBackColor = true;
            // 
            // Input_Ref
            // 
            this.Input_Ref.AutoSize = true;
            this.Input_Ref.Location = new System.Drawing.Point(10, 192);
            this.Input_Ref.Name = "Input_Ref";
            this.Input_Ref.Size = new System.Drawing.Size(213, 17);
            this.Input_Ref.TabIndex = 27;
            this.Input_Ref.Text = "Input Referenced Nonlinear Parameters";
            this.Input_Ref.UseVisualStyleBackColor = true;
            // 
            // RowColumnRefStop
            // 
            this.RowColumnRefStop.Location = new System.Drawing.Point(248, 54);
            this.RowColumnRefStop.Name = "RowColumnRefStop";
            this.RowColumnRefStop.Size = new System.Drawing.Size(50, 20);
            this.RowColumnRefStop.TabIndex = 17;
            this.RowColumnRefStop.TextChanged += new System.EventHandler(this.RowColumnRefStop_TextChanged);
            // 
            // IP2_ref
            // 
            this.IP2_ref.Location = new System.Drawing.Point(97, 146);
            this.IP2_ref.Name = "IP2_ref";
            this.IP2_ref.Size = new System.Drawing.Size(51, 20);
            this.IP2_ref.TabIndex = 12;
            this.IP2_ref.TextChanged += new System.EventHandler(this.IP2_ref_TextChanged);
            // 
            // IP2_check
            // 
            this.IP2_check.AutoSize = true;
            this.IP2_check.Location = new System.Drawing.Point(10, 149);
            this.IP2_check.Name = "IP2_check";
            this.IP2_check.Size = new System.Drawing.Size(45, 17);
            this.IP2_check.TabIndex = 25;
            this.IP2_check.Text = "IP2:";
            this.IP2_check.UseVisualStyleBackColor = true;
            // 
            // IndexLabel
            // 
            this.IndexLabel.AutoSize = true;
            this.IndexLabel.Location = new System.Drawing.Point(257, 16);
            this.IndexLabel.Name = "IndexLabel";
            this.IndexLabel.Size = new System.Drawing.Size(33, 13);
            this.IndexLabel.TabIndex = 15;
            this.IndexLabel.Text = "Index";
            // 
            // IP3_ref
            // 
            this.IP3_ref.Location = new System.Drawing.Point(97, 124);
            this.IP3_ref.Name = "IP3_ref";
            this.IP3_ref.Size = new System.Drawing.Size(51, 20);
            this.IP3_ref.TabIndex = 10;
            this.IP3_ref.TextChanged += new System.EventHandler(this.IP3_ref_TextChanged);
            // 
            // P1dB_check
            // 
            this.P1dB_check.AutoSize = true;
            this.P1dB_check.Location = new System.Drawing.Point(9, 80);
            this.P1dB_check.Name = "P1dB_check";
            this.P1dB_check.Size = new System.Drawing.Size(55, 17);
            this.P1dB_check.TabIndex = 22;
            this.P1dB_check.Text = "P1dB:";
            this.P1dB_check.UseVisualStyleBackColor = true;
            // 
            // PSat_ref
            // 
            this.PSat_ref.Location = new System.Drawing.Point(97, 101);
            this.PSat_ref.Name = "PSat_ref";
            this.PSat_ref.Size = new System.Drawing.Size(51, 20);
            this.PSat_ref.TabIndex = 8;
            this.PSat_ref.TextChanged += new System.EventHandler(this.PSat_ref_TextChanged);
            // 
            // IP3_check
            // 
            this.IP3_check.AutoSize = true;
            this.IP3_check.Location = new System.Drawing.Point(10, 126);
            this.IP3_check.Name = "IP3_check";
            this.IP3_check.Size = new System.Drawing.Size(45, 17);
            this.IP3_check.TabIndex = 24;
            this.IP3_check.Text = "IP3:";
            this.IP3_check.UseVisualStyleBackColor = true;
            // 
            // P1dB_ref
            // 
            this.P1dB_ref.Location = new System.Drawing.Point(97, 78);
            this.P1dB_ref.Name = "P1dB_ref";
            this.P1dB_ref.Size = new System.Drawing.Size(51, 20);
            this.P1dB_ref.TabIndex = 6;
            this.P1dB_ref.TextChanged += new System.EventHandler(this.P1dB_ref_TextChanged);
            // 
            // PSat_check
            // 
            this.PSat_check.AutoSize = true;
            this.PSat_check.Location = new System.Drawing.Point(9, 103);
            this.PSat_check.Name = "PSat_check";
            this.PSat_check.Size = new System.Drawing.Size(50, 17);
            this.PSat_check.TabIndex = 23;
            this.PSat_check.Text = "Psat:";
            this.PSat_check.UseVisualStyleBackColor = true;
            // 
            // DataGroupRowColumnLabel
            // 
            this.DataGroupRowColumnLabel.AutoSize = true;
            this.DataGroupRowColumnLabel.Location = new System.Drawing.Point(95, 16);
            this.DataGroupRowColumnLabel.Name = "DataGroupRowColumnLabel";
            this.DataGroupRowColumnLabel.Size = new System.Drawing.Size(42, 13);
            this.DataGroupRowColumnLabel.TabIndex = 11;
            this.DataGroupRowColumnLabel.Text = "Column";
            // 
            // Gain
            // 
            this.Gain.Location = new System.Drawing.Point(97, 32);
            this.Gain.Name = "Gain";
            this.Gain.Size = new System.Drawing.Size(51, 20);
            this.Gain.TabIndex = 2;
            this.Gain.TextChanged += new System.EventHandler(this.Gain_TextChanged);
            // 
            // noiseFigure
            // 
            this.noiseFigure.Location = new System.Drawing.Point(97, 55);
            this.noiseFigure.Name = "noiseFigure";
            this.noiseFigure.Size = new System.Drawing.Size(51, 20);
            this.noiseFigure.TabIndex = 3;
            this.noiseFigure.TextChanged += new System.EventHandler(this.noiseFigure_TextChanged);
            // 
            // RadioGroup
            // 
            this.RadioGroup.CausesValidation = false;
            this.RadioGroup.Controls.Add(this.RowsButton);
            this.RadioGroup.Controls.Add(this.ColumnsButton);
            this.RadioGroup.Location = new System.Drawing.Point(12, 12);
            this.RadioGroup.Name = "RadioGroup";
            this.RadioGroup.Size = new System.Drawing.Size(171, 75);
            this.RadioGroup.TabIndex = 40;
            this.RadioGroup.TabStop = false;
            this.RadioGroup.Text = "Is your data organized by columns or rows?";
            // 
            // RowsButton
            // 
            this.RowsButton.AutoSize = true;
            this.RowsButton.Location = new System.Drawing.Point(6, 50);
            this.RowsButton.Name = "RowsButton";
            this.RowsButton.Size = new System.Drawing.Size(52, 17);
            this.RowsButton.TabIndex = 1;
            this.RowsButton.Text = "Rows";
            this.RowsButton.UseVisualStyleBackColor = true;
            this.RowsButton.CheckedChanged += new System.EventHandler(this.RowsButton_CheckedChanged);
            // 
            // ColumnsButton
            // 
            this.ColumnsButton.AutoSize = true;
            this.ColumnsButton.Checked = true;
            this.ColumnsButton.Location = new System.Drawing.Point(6, 27);
            this.ColumnsButton.Name = "ColumnsButton";
            this.ColumnsButton.Size = new System.Drawing.Size(65, 17);
            this.ColumnsButton.TabIndex = 0;
            this.ColumnsButton.TabStop = true;
            this.ColumnsButton.Text = "Columns";
            this.ColumnsButton.UseVisualStyleBackColor = true;
            this.ColumnsButton.CheckedChanged += new System.EventHandler(this.ColumnsButton_CheckedChanged);
            // 
            // ExceltoSpectrasys
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(397, 440);
            this.Controls.Add(this.RadioGroup);
            this.Controls.Add(this.DataGroup);
            this.Controls.Add(this.ReadDataButton);
            this.Controls.Add(this.richTextBox1);
            this.Controls.Add(this.IP2);
            this.Controls.Add(this.WriteDataButton);
            this.Name = "ExceltoSpectrasys";
            this.Text = "Import Excel RF System Chain (.xls)";
            this.DataGroup.ResumeLayout(false);
            this.DataGroup.PerformLayout();
            this.RadioGroup.ResumeLayout(false);
            this.RadioGroup.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.RichTextBox richTextBox1;
        private System.Windows.Forms.Button WriteDataButton;
        private System.Windows.Forms.Label IP2;
        private System.Windows.Forms.Button ReadDataButton;
        private System.Windows.Forms.GroupBox DataGroup;
        private System.Windows.Forms.TextBox StageNameText;
        private System.Windows.Forms.CheckBox StageNamecheck;
        private System.Windows.Forms.Label StartRowColumnLabel;
        private System.Windows.Forms.Label StopRowColumnLabel;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox RowColumnRefStart;
        private System.Windows.Forms.CheckBox NF_check;
        private System.Windows.Forms.CheckBox Input_Ref;
        private System.Windows.Forms.TextBox RowColumnRefStop;
        private System.Windows.Forms.TextBox IP2_ref;
        private System.Windows.Forms.CheckBox IP2_check;
        private System.Windows.Forms.Label IndexLabel;
        private System.Windows.Forms.TextBox IP3_ref;
        private System.Windows.Forms.CheckBox P1dB_check;
        private System.Windows.Forms.TextBox PSat_ref;
        private System.Windows.Forms.CheckBox IP3_check;
        private System.Windows.Forms.TextBox P1dB_ref;
        private System.Windows.Forms.CheckBox PSat_check;
        private System.Windows.Forms.Label DataGroupRowColumnLabel;
        private System.Windows.Forms.TextBox Gain;
        private System.Windows.Forms.TextBox noiseFigure;
        private System.Windows.Forms.GroupBox RadioGroup;
        private System.Windows.Forms.RadioButton RowsButton;
        private System.Windows.Forms.RadioButton ColumnsButton;
        private System.Windows.Forms.Button helpButton;

    }
}

