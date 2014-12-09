namespace SoftFluent.AspNetIdentity
{
    partial class ConfigurationForm
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
            this.buttonOk = new System.Windows.Forms.Button();
            this.buttonCancel = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label2 = new System.Windows.Forms.Label();
            this.comboBoxNamespace = new System.Windows.Forms.ComboBox();
            this.checkBoxRoleClaim = new System.Windows.Forms.CheckBox();
            this.checkBoxExternalLogins = new System.Windows.Forms.CheckBox();
            this.checkBoxClaims = new System.Windows.Forms.CheckBox();
            this.checkBoxRole = new System.Windows.Forms.CheckBox();
            this.checkBoxPhoneNumberUnique = new System.Windows.Forms.CheckBox();
            this.textBoxRoleClaimEntityName = new System.Windows.Forms.TextBox();
            this.checkBoxEmailUnique = new System.Windows.Forms.CheckBox();
            this.textBoxUserLoginsEntityName = new System.Windows.Forms.TextBox();
            this.textBoxClaimsEntityName = new System.Windows.Forms.TextBox();
            this.textBoxRoleEntityName = new System.Windows.Forms.TextBox();
            this.textBoxUserEntityName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonOk
            // 
            this.buttonOk.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonOk.Location = new System.Drawing.Point(196, 374);
            this.buttonOk.Name = "buttonOk";
            this.buttonOk.Size = new System.Drawing.Size(75, 23);
            this.buttonOk.TabIndex = 0;
            this.buttonOk.Text = "&OK";
            this.buttonOk.UseVisualStyleBackColor = true;
            this.buttonOk.Click += new System.EventHandler(this.buttonOk_Click);
            // 
            // buttonCancel
            // 
            this.buttonCancel.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.buttonCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.buttonCancel.Location = new System.Drawing.Point(115, 374);
            this.buttonCancel.Name = "buttonCancel";
            this.buttonCancel.Size = new System.Drawing.Size(75, 23);
            this.buttonCancel.TabIndex = 1;
            this.buttonCancel.Text = "&Cancel";
            this.buttonCancel.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.comboBoxNamespace);
            this.groupBox1.Controls.Add(this.checkBoxRoleClaim);
            this.groupBox1.Controls.Add(this.checkBoxExternalLogins);
            this.groupBox1.Controls.Add(this.checkBoxClaims);
            this.groupBox1.Controls.Add(this.checkBoxRole);
            this.groupBox1.Controls.Add(this.checkBoxPhoneNumberUnique);
            this.groupBox1.Controls.Add(this.textBoxRoleClaimEntityName);
            this.groupBox1.Controls.Add(this.checkBoxEmailUnique);
            this.groupBox1.Controls.Add(this.textBoxUserLoginsEntityName);
            this.groupBox1.Controls.Add(this.textBoxClaimsEntityName);
            this.groupBox1.Controls.Add(this.textBoxRoleEntityName);
            this.groupBox1.Controls.Add(this.textBoxUserEntityName);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(259, 351);
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Entities options";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 306);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(67, 13);
            this.label2.TabIndex = 4;
            this.label2.Text = "Namespace:";
            // 
            // comboBoxNamespace
            // 
            this.comboBoxNamespace.FormattingEnabled = true;
            this.comboBoxNamespace.Location = new System.Drawing.Point(6, 322);
            this.comboBoxNamespace.Name = "comboBoxNamespace";
            this.comboBoxNamespace.Size = new System.Drawing.Size(247, 21);
            this.comboBoxNamespace.TabIndex = 1;
            this.comboBoxNamespace.TextChanged += new System.EventHandler(this.textBoxEntityName_TextChanged);
            // 
            // checkBoxRoleClaim
            // 
            this.checkBoxRoleClaim.AutoSize = true;
            this.checkBoxRoleClaim.Checked = true;
            this.checkBoxRoleClaim.CheckState = System.Windows.Forms.CheckState.Checked;
            this.checkBoxRoleClaim.Location = new System.Drawing.Point(6, 214);
            this.checkBoxRoleClaim.Name = "checkBoxRoleClaim";
            this.checkBoxRoleClaim.Size = new System.Drawing.Size(112, 17);
            this.checkBoxRoleClaim.TabIndex = 3;
            this.checkBoxRoleClaim.Text = "Role Claims entity:";
            this.checkBoxRoleClaim.UseVisualStyleBackColor = true;
            this.checkBoxRoleClaim.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // checkBoxExternalLogins
            // 
            this.checkBoxExternalLogins.AutoSize = true;
            this.checkBoxExternalLogins.Checked = true;
            this.checkBoxExternalLogins.CheckState = System.Windows.Forms.CheckState.Checked;
            this.checkBoxExternalLogins.Location = new System.Drawing.Point(6, 165);
            this.checkBoxExternalLogins.Name = "checkBoxExternalLogins";
            this.checkBoxExternalLogins.Size = new System.Drawing.Size(125, 17);
            this.checkBoxExternalLogins.TabIndex = 3;
            this.checkBoxExternalLogins.Text = "External logins entity:";
            this.checkBoxExternalLogins.UseVisualStyleBackColor = true;
            this.checkBoxExternalLogins.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // checkBoxClaims
            // 
            this.checkBoxClaims.AutoSize = true;
            this.checkBoxClaims.Checked = true;
            this.checkBoxClaims.CheckState = System.Windows.Forms.CheckState.Checked;
            this.checkBoxClaims.Location = new System.Drawing.Point(6, 116);
            this.checkBoxClaims.Name = "checkBoxClaims";
            this.checkBoxClaims.Size = new System.Drawing.Size(87, 17);
            this.checkBoxClaims.TabIndex = 3;
            this.checkBoxClaims.Text = "Claims entity:";
            this.checkBoxClaims.UseVisualStyleBackColor = true;
            this.checkBoxClaims.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // checkBoxRole
            // 
            this.checkBoxRole.AutoSize = true;
            this.checkBoxRole.Checked = true;
            this.checkBoxRole.CheckState = System.Windows.Forms.CheckState.Checked;
            this.checkBoxRole.Location = new System.Drawing.Point(6, 67);
            this.checkBoxRole.Name = "checkBoxRole";
            this.checkBoxRole.Size = new System.Drawing.Size(79, 17);
            this.checkBoxRole.TabIndex = 3;
            this.checkBoxRole.Text = "Role entity:";
            this.checkBoxRole.UseVisualStyleBackColor = true;
            this.checkBoxRole.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // checkBoxPhoneNumberUnique
            // 
            this.checkBoxPhoneNumberUnique.AutoSize = true;
            this.checkBoxPhoneNumberUnique.Location = new System.Drawing.Point(6, 286);
            this.checkBoxPhoneNumberUnique.Name = "checkBoxPhoneNumberUnique";
            this.checkBoxPhoneNumberUnique.Size = new System.Drawing.Size(140, 17);
            this.checkBoxPhoneNumberUnique.TabIndex = 3;
            this.checkBoxPhoneNumberUnique.Text = "Is phone number unique";
            this.checkBoxPhoneNumberUnique.UseVisualStyleBackColor = true;
            this.checkBoxPhoneNumberUnique.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // textBoxRoleClaimEntityName
            // 
            this.textBoxRoleClaimEntityName.Location = new System.Drawing.Point(6, 237);
            this.textBoxRoleClaimEntityName.Name = "textBoxRoleClaimEntityName";
            this.textBoxRoleClaimEntityName.Size = new System.Drawing.Size(247, 20);
            this.textBoxRoleClaimEntityName.TabIndex = 1;
            this.textBoxRoleClaimEntityName.Text = "RoleClaim";
            this.textBoxRoleClaimEntityName.TextChanged += new System.EventHandler(this.textBoxEntityName_TextChanged);
            // 
            // checkBoxEmailUnique
            // 
            this.checkBoxEmailUnique.AutoSize = true;
            this.checkBoxEmailUnique.Location = new System.Drawing.Point(6, 263);
            this.checkBoxEmailUnique.Name = "checkBoxEmailUnique";
            this.checkBoxEmailUnique.Size = new System.Drawing.Size(136, 17);
            this.checkBoxEmailUnique.TabIndex = 3;
            this.checkBoxEmailUnique.Text = "Is email address unique";
            this.checkBoxEmailUnique.UseVisualStyleBackColor = true;
            this.checkBoxEmailUnique.CheckedChanged += new System.EventHandler(this.checkBox_CheckedChanged);
            // 
            // textBoxUserLoginsEntityName
            // 
            this.textBoxUserLoginsEntityName.Location = new System.Drawing.Point(6, 188);
            this.textBoxUserLoginsEntityName.Name = "textBoxUserLoginsEntityName";
            this.textBoxUserLoginsEntityName.Size = new System.Drawing.Size(247, 20);
            this.textBoxUserLoginsEntityName.TabIndex = 1;
            this.textBoxUserLoginsEntityName.Text = "UserLogin";
            this.textBoxUserLoginsEntityName.TextChanged += new System.EventHandler(this.textBoxEntityName_TextChanged);
            // 
            // textBoxClaimsEntityName
            // 
            this.textBoxClaimsEntityName.Location = new System.Drawing.Point(6, 139);
            this.textBoxClaimsEntityName.Name = "textBoxClaimsEntityName";
            this.textBoxClaimsEntityName.Size = new System.Drawing.Size(247, 20);
            this.textBoxClaimsEntityName.TabIndex = 1;
            this.textBoxClaimsEntityName.Text = "UserClaim";
            this.textBoxClaimsEntityName.TextChanged += new System.EventHandler(this.textBoxEntityName_TextChanged);
            // 
            // textBoxRoleEntityName
            // 
            this.textBoxRoleEntityName.Location = new System.Drawing.Point(6, 88);
            this.textBoxRoleEntityName.Name = "textBoxRoleEntityName";
            this.textBoxRoleEntityName.Size = new System.Drawing.Size(247, 20);
            this.textBoxRoleEntityName.TabIndex = 1;
            this.textBoxRoleEntityName.Text = "Role";
            this.textBoxRoleEntityName.TextChanged += new System.EventHandler(this.textBoxEntityName_TextChanged);
            // 
            // textBoxUserEntityName
            // 
            this.textBoxUserEntityName.Location = new System.Drawing.Point(6, 41);
            this.textBoxUserEntityName.Name = "textBoxUserEntityName";
            this.textBoxUserEntityName.Size = new System.Drawing.Size(247, 20);
            this.textBoxUserEntityName.TabIndex = 1;
            this.textBoxUserEntityName.Text = "User";
            this.textBoxUserEntityName.TextChanged += new System.EventHandler(this.textBoxEntityName_TextChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(3, 25);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(60, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "User entity:";
            // 
            // ConfigurationForm
            // 
            this.AcceptButton = this.buttonOk;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.buttonCancel;
            this.ClientSize = new System.Drawing.Size(283, 409);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.buttonCancel);
            this.Controls.Add(this.buttonOk);
            this.Name = "ConfigurationForm";
            this.Text = "ASP.NET Identity";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button buttonOk;
        private System.Windows.Forms.Button buttonCancel;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox textBoxClaimsEntityName;
        private System.Windows.Forms.TextBox textBoxRoleEntityName;
        private System.Windows.Forms.TextBox textBoxUserEntityName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textBoxUserLoginsEntityName;
        private System.Windows.Forms.CheckBox checkBoxClaims;
        private System.Windows.Forms.CheckBox checkBoxRole;
        private System.Windows.Forms.ComboBox comboBoxNamespace;
        private System.Windows.Forms.CheckBox checkBoxExternalLogins;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.CheckBox checkBoxEmailUnique;
        private System.Windows.Forms.CheckBox checkBoxPhoneNumberUnique;
        private System.Windows.Forms.CheckBox checkBoxRoleClaim;
        private System.Windows.Forms.TextBox textBoxRoleClaimEntityName;
    }
}