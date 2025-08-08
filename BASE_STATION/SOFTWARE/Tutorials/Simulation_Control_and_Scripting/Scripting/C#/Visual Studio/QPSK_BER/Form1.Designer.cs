namespace _QPSK_BER
{
    partial class Form1
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
            this.components = new System.ComponentModel.Container();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.simulationResultBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.LaunchSystemVue = new System.Windows.Forms.Button();
            this.Clear = new System.Windows.Forms.Button();
            this.HideSystemVue = new System.Windows.Forms.CheckBox();
            this.ebN0DataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.bERDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.testDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.simulationResultBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // dataGridView1
            // 
            this.dataGridView1.AllowUserToAddRows = false;
            this.dataGridView1.AllowUserToDeleteRows = false;
            this.dataGridView1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ebN0DataGridViewTextBoxColumn,
            this.bERDataGridViewTextBoxColumn,
            this.testDataGridViewTextBoxColumn});
            this.dataGridView1.DataSource = this.simulationResultBindingSource;
            this.dataGridView1.EditMode = System.Windows.Forms.DataGridViewEditMode.EditProgrammatically;
            this.dataGridView1.Location = new System.Drawing.Point(12, 66);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.ReadOnly = true;
            this.dataGridView1.RowHeadersVisible = false;
            this.dataGridView1.Size = new System.Drawing.Size(374, 101);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.Tag = "";
            // 
            // simulationResultBindingSource
            // 
            this.simulationResultBindingSource.DataSource = typeof(_QPSK_BER.QPSK_BER.SimulationResult);
            // 
            // LaunchSystemVue
            // 
            this.LaunchSystemVue.Location = new System.Drawing.Point(12, 10);
            this.LaunchSystemVue.Name = "LaunchSystemVue";
            this.LaunchSystemVue.Size = new System.Drawing.Size(74, 22);
            this.LaunchSystemVue.TabIndex = 1;
            this.LaunchSystemVue.Text = "Run";
            this.LaunchSystemVue.UseVisualStyleBackColor = true;
            this.LaunchSystemVue.Click += new System.EventHandler(this.LaunchSystemVue_Click);
            // 
            // Clear
            // 
            this.Clear.Location = new System.Drawing.Point(12, 38);
            this.Clear.Name = "Clear";
            this.Clear.Size = new System.Drawing.Size(74, 22);
            this.Clear.TabIndex = 2;
            this.Clear.Text = "Clear Results";
            this.Clear.UseVisualStyleBackColor = true;
            this.Clear.Click += new System.EventHandler(this.Clear_Click);
            // 
            // HideSystemVue
            // 
            this.HideSystemVue.AutoSize = true;
            this.HideSystemVue.Checked = true;
            this.HideSystemVue.CheckState = System.Windows.Forms.CheckState.Checked;
            this.HideSystemVue.Location = new System.Drawing.Point(282, 14);
            this.HideSystemVue.Name = "HideSystemVue";
            this.HideSystemVue.Size = new System.Drawing.Size(104, 17);
            this.HideSystemVue.TabIndex = 3;
            this.HideSystemVue.Text = "Hide SystemVue";
            this.HideSystemVue.UseVisualStyleBackColor = true;
            this.HideSystemVue.CheckedChanged += new System.EventHandler(this.HideSystemVue_CheckedChanged);
            // 
            // ebN0DataGridViewTextBoxColumn
            // 
            this.ebN0DataGridViewTextBoxColumn.DataPropertyName = "EbN0";
            this.ebN0DataGridViewTextBoxColumn.HeaderText = "EbN0";
            this.ebN0DataGridViewTextBoxColumn.Name = "ebN0DataGridViewTextBoxColumn";
            this.ebN0DataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // bERDataGridViewTextBoxColumn
            // 
            this.bERDataGridViewTextBoxColumn.DataPropertyName = "BER";
            this.bERDataGridViewTextBoxColumn.HeaderText = "BER";
            this.bERDataGridViewTextBoxColumn.Name = "bERDataGridViewTextBoxColumn";
            this.bERDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // testDataGridViewTextBoxColumn
            // 
            this.testDataGridViewTextBoxColumn.DataPropertyName = "Test";
            this.testDataGridViewTextBoxColumn.HeaderText = "Status";
            this.testDataGridViewTextBoxColumn.Name = "testDataGridViewTextBoxColumn";
            this.testDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(398, 179);
            this.Controls.Add(this.HideSystemVue);
            this.Controls.Add(this.Clear);
            this.Controls.Add(this.LaunchSystemVue);
            this.Controls.Add(this.dataGridView1);
            this.Name = "Form1";
            this.Text = "SystemVue BER Tester";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.simulationResultBindingSource)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.Button LaunchSystemVue;
        private System.Windows.Forms.Button Clear;
        private System.Windows.Forms.CheckBox HideSystemVue;
        private System.Windows.Forms.BindingSource simulationResultBindingSource;
        private System.Windows.Forms.DataGridViewTextBoxColumn ebN0DataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn bERDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn testDataGridViewTextBoxColumn;
    }
}