using System.Collections.Generic;
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

        public IEnumerable<SorpetalerDataSet.tvf_FindAddressesByTelephoneNumberRow> FindAddressByTelephoneNumber(string number)
        {
            return tvf_FindAddressesByTelephoneNumberTableAdapter1.GetData(number);
        }
        
        public IEnumerable<SorpetalerDataSet.tvf_GetPersonByIDRow> GetPersonByID(int id)
        {
            return this.tvf_GetPersonByIDTableAdapter1.GetData(id);
        }

        public ADRESSEN_Telefonnummern_VerwendungTableAdapter TelefonnummernVerwendung
        {
            get { return this.adresseN_Telefonnummern_VerwendungTableAdapter1; }
        }
    }
}
