namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    partial class ADConnectorComponent
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
            this.dsPhoneNumbers = new System.DirectoryServices.DirectorySearcher();
            this.directoryEntry1 = new System.DirectoryServices.DirectoryEntry();
            // 
            // dsPhoneNumbers
            // 
            this.dsPhoneNumbers.Asynchronous = true;
            this.dsPhoneNumbers.ClientTimeout = System.TimeSpan.Parse("-00:00:01");
            this.dsPhoneNumbers.PropertiesToLoad.AddRange(new string[] {
            "telephoneNumber",
            "mailNickname",
            "mail",
            "distinguishedName",
            "displayName",
            "mobile",
            "info"});
            this.dsPhoneNumbers.SearchRoot = this.directoryEntry1;
            this.dsPhoneNumbers.SearchScope = System.DirectoryServices.SearchScope.OneLevel;
            this.dsPhoneNumbers.ServerPageTimeLimit = System.TimeSpan.Parse("-00:00:01");
            this.dsPhoneNumbers.ServerTimeLimit = System.TimeSpan.Parse("-00:00:01");
            // 
            // directoryEntry1
            // 
            this.directoryEntry1.Path = "LDAP://CN=Users,dc=sorpetaler,dc=de";

        }

        #endregion

        private System.DirectoryServices.DirectorySearcher dsPhoneNumbers;
        private System.DirectoryServices.DirectoryEntry directoryEntry1;
    }
}
