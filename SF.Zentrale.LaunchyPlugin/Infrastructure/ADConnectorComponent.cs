using System.ComponentModel;
using System.DirectoryServices;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public partial class ADConnectorComponent : Component
    {
        public ADConnectorComponent()
        {
            InitializeComponent();
        }

        public ADConnectorComponent(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }

        public bool TryFindADUserByNumber(string number, out SearchResult adEntry)
        {
            dsPhoneNumbers.Filter = string.Format("(telephoneNumber={0})", number);
            adEntry = dsPhoneNumbers.FindOne();
            return adEntry != null;
        }
    }
}
