namespace SF.Zentrale.LaunchyPlugin
{
    partial class OptionsWidget
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.caseSensitiveCheckBox = new System.Windows.Forms.CheckBox();
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tbPageWindowManagement = new System.Windows.Forms.TabPage();
            this.tbPagePhoneSystem = new System.Windows.Forms.TabPage();
            this.label1 = new System.Windows.Forms.Label();
            this.textBoxObjectRoot = new System.Windows.Forms.TextBox();
            this.tabControl1.SuspendLayout();
            this.tbPageWindowManagement.SuspendLayout();
            this.tbPagePhoneSystem.SuspendLayout();
            this.SuspendLayout();
            // 
            // caseSensitiveCheckBox
            // 
            this.caseSensitiveCheckBox.AutoSize = true;
            this.caseSensitiveCheckBox.Location = new System.Drawing.Point(6, 6);
            this.caseSensitiveCheckBox.Name = "caseSensitiveCheckBox";
            this.caseSensitiveCheckBox.Size = new System.Drawing.Size(140, 17);
            this.caseSensitiveCheckBox.TabIndex = 0;
            this.caseSensitiveCheckBox.Text = "Case-sensitive matching";
            this.caseSensitiveCheckBox.UseVisualStyleBackColor = true;
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tbPageWindowManagement);
            this.tabControl1.Controls.Add(this.tbPagePhoneSystem);
            this.tabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl1.Location = new System.Drawing.Point(0, 0);
            this.tabControl1.Multiline = true;
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(521, 424);
            this.tabControl1.TabIndex = 1;
            // 
            // tbPageWindowManagement
            // 
            this.tbPageWindowManagement.Controls.Add(this.caseSensitiveCheckBox);
            this.tbPageWindowManagement.Location = new System.Drawing.Point(4, 22);
            this.tbPageWindowManagement.Name = "tbPageWindowManagement";
            this.tbPageWindowManagement.Padding = new System.Windows.Forms.Padding(3);
            this.tbPageWindowManagement.Size = new System.Drawing.Size(513, 398);
            this.tbPageWindowManagement.TabIndex = 1;
            this.tbPageWindowManagement.Text = "Window Management";
            this.tbPageWindowManagement.UseVisualStyleBackColor = true;
            // 
            // tbPagePhoneSystem
            // 
            this.tbPagePhoneSystem.Controls.Add(this.label1);
            this.tbPagePhoneSystem.Controls.Add(this.textBoxObjectRoot);
            this.tbPagePhoneSystem.Location = new System.Drawing.Point(4, 22);
            this.tbPagePhoneSystem.Name = "tbPagePhoneSystem";
            this.tbPagePhoneSystem.Padding = new System.Windows.Forms.Padding(3);
            this.tbPagePhoneSystem.Size = new System.Drawing.Size(513, 398);
            this.tbPagePhoneSystem.TabIndex = 2;
            this.tbPagePhoneSystem.Text = "Phone System";
            this.tbPagePhoneSystem.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(73, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Registry Path:";
            // 
            // textBoxObjectRoot
            // 
            this.textBoxObjectRoot.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.textBoxObjectRoot.Location = new System.Drawing.Point(82, 6);
            this.textBoxObjectRoot.Name = "textBoxObjectRoot";
            this.textBoxObjectRoot.Size = new System.Drawing.Size(425, 20);
            this.textBoxObjectRoot.TabIndex = 0;
            this.textBoxObjectRoot.Text = "Software\\Zentrale\\Objects";
            // 
            // OptionsWidget
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tabControl1);
            this.Name = "OptionsWidget";
            this.Size = new System.Drawing.Size(521, 424);
            this.tabControl1.ResumeLayout(false);
            this.tbPageWindowManagement.ResumeLayout(false);
            this.tbPageWindowManagement.PerformLayout();
            this.tbPagePhoneSystem.ResumeLayout(false);
            this.tbPagePhoneSystem.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.CheckBox caseSensitiveCheckBox;
        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tbPageWindowManagement;
        private System.Windows.Forms.TabPage tbPagePhoneSystem;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textBoxObjectRoot;
    }
}
