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
            this.tvf_FindAddressesByTelephoneNumberTableAdapter1 = new SF.Zentrale.LaunchyPlugin.SorpetalerDataSetTableAdapters.tvf_FindAddressesByTelephoneNumberTableAdapter();
            this.adresseN_Telefonnummern_VerwendungTableAdapter1 = new SF.Zentrale.LaunchyPlugin.SorpetalerDataSetTableAdapters.ADRESSEN_Telefonnummern_VerwendungTableAdapter();
            this.tvf_GetPersonByIDTableAdapter1 = new SF.Zentrale.LaunchyPlugin.SorpetalerDataSetTableAdapters.tvf_GetPersonByIDTableAdapter();
            // 
            // tvf_FindAddressesByTelephoneNumberTableAdapter1
            // 
            this.tvf_FindAddressesByTelephoneNumberTableAdapter1.ClearBeforeFill = true;
            // 
            // adresseN_Telefonnummern_VerwendungTableAdapter1
            // 
            this.adresseN_Telefonnummern_VerwendungTableAdapter1.ClearBeforeFill = true;
            // 
            // tvf_GetPersonByIDTableAdapter1
            // 
            this.tvf_GetPersonByIDTableAdapter1.ClearBeforeFill = true;

        }

        #endregion

        private SorpetalerDataSetTableAdapters.tvf_FindAddressesByTelephoneNumberTableAdapter tvf_FindAddressesByTelephoneNumberTableAdapter1;
        private SorpetalerDataSetTableAdapters.ADRESSEN_Telefonnummern_VerwendungTableAdapter adresseN_Telefonnummern_VerwendungTableAdapter1;
        private SorpetalerDataSetTableAdapters.tvf_GetPersonByIDTableAdapter tvf_GetPersonByIDTableAdapter1;
    }
}
