namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    partial class SFDBConnection
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
            this.iD_HitcountsTableAdapter1 = new SF.Zentrale.LaunchyPlugin.SorpetalerDataSetTableAdapters.ID_HitcountsTableAdapter();
            this.adresseN_TelefonnummernTableAdapter1 = new SF.Zentrale.LaunchyPlugin.SorpetalerDataSetTableAdapters.ADRESSEN_TelefonnummernTableAdapter();
            // 
            // iD_HitcountsTableAdapter1
            // 
            this.iD_HitcountsTableAdapter1.ClearBeforeFill = true;
            // 
            // adresseN_TelefonnummernTableAdapter1
            // 
            this.adresseN_TelefonnummernTableAdapter1.ClearBeforeFill = true;

        }

        #endregion

        private SorpetalerDataSetTableAdapters.ID_HitcountsTableAdapter iD_HitcountsTableAdapter1;
        private SorpetalerDataSetTableAdapters.ADRESSEN_TelefonnummernTableAdapter adresseN_TelefonnummernTableAdapter1;
    }
}
