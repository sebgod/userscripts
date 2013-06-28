using System.ComponentModel;
using SF.Zentrale.LaunchyPlugin.SorpetalerDataSetTableAdapters;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public partial class SFDBConnection : Component
    {
        public SFDBConnection()
        {
            InitializeComponent();
        }

        public SFDBConnection(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }

        public ADRESSEN_TelefonnummernTableAdapter AdressenTelefonnummern
        {
            get { return this.adresseN_TelefonnummernTableAdapter1; }
        }
    }
}
